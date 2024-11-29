Class {
	#name : #GtPythonCoderModel,
	#superclass : #GtSourceCoder,
	#instVars : [
		'pythonApplicationStrategy',
		'pharoBindings'
	],
	#category : #'Lepiter-Python-Coder'
}

{ #category : #converting }
GtPythonCoderModel >> asCoderViewModel [

	^ GtPythonCoderViewModel new coder: self
]

{ #category : #'private - execution' }
GtPythonCoderModel >> bindAndExecute: sourceString inContext: aGtSourceCoderEvaluationContext [
	"Answer the source code with all declared variables returned in an immediate dictionary"

	| trimmedSource ast commandFactory lastStatement pythonBindings application ws startPosition varNodeVisitor returnBindings |
	
	trimmedSource := SmaCCString on: sourceString.
	ast := PythonParser parseWithErrors: sourceString.
	varNodeVisitor := GtPythonVarNodeVisitor new.
	varNodeVisitor accept: ast.
	startPosition := ast statements first startPosition.
	ws := trimmedSource startOfLineWhitespaceBeforeIndex: startPosition.
	trimmedSource insert: 'self = ' at: startPosition.
	trimmedSource
		insert: (aGtSourceCoderEvaluationContext requesterObject selfObject
				ifNil: [ 'None' ]
				ifNotNil: [ :obj | 
					(obj isKindOf: PBProxyObject)
						ifTrue: [ obj resolveIdPyExpression generate ]
						ifFalse: [ 'None' ] ])
		at: startPosition.
	trimmedSource insert: String cr , ws at: startPosition.
	"Assign the final statement to snippetResult if it isn't already an assignment"
	lastStatement := ast statements last.
	lastStatement isValueStatement
		ifTrue: [ trimmedSource insert: 'snippetResult = ' at: lastStatement startPosition ]
		ifFalse: [ trimmedSource append: String cr; append: 'snippetResult = None' ].
	pythonBindings := self pythonBindings.

	application := pythonApplicationStrategy applicationServer.
	application isRunning ifFalse: [ application start ].
	commandFactory := application newCommandStringFactory.
	"Only bind when read"
	pythonBindings do: [ :binding |
		(varNodeVisitor accessedFirstVariableNames includes: binding key)
			ifTrue: [ commandFactory addBinding: binding ] ].
	"Only bind when written"
	returnBindings := pythonBindings select: [ :binding | 
		varNodeVisitor assignedVariableNames includes: binding key ].
	commandFactory
		script: trimmedSource asString;
		resultExpression: (self returnVariablesExpressionFrom: returnBindings) string.

	^ commandFactory sendAndWait
]

{ #category : #'api - ast' }
GtPythonCoderModel >> computeAst: theSourceString [
	^ PythonParser
		parseWithErrors: theSourceString
		startingAt: PythonParser startingStateForfile_input
]

{ #category : #'api - ast' }
GtPythonCoderModel >> implicitVariableReferencesTo: aString do: aBlock [
	self astSync withAllNodesOfType: PyVariableExpressionNode do: [ :node | 
		node nameToken source = aString ifTrue: [ aBlock value: node ] ]
]

{ #category : #initialize }
GtPythonCoderModel >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: (GtCoderAstSmaCCParserStyler new smaccStyler: PythonParser gtStyler).
	
	addOns
		addMainAction: 'Evaluate' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doIt
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItActionId.
	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doItAndGo
				coderViewModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
]

{ #category : #initialize }
GtPythonCoderModel >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDoItShortcut new;
		addShortcut: GtSourceCoderDoItAndInspectShortcut new
]

{ #category : #'instance creation' }
GtPythonCoderModel >> newCompletionStrategy [
	^ GtCompletionStrategy new
]

{ #category : #accessing }
GtPythonCoderModel >> pharoBindings [
	^ pharoBindings
]

{ #category : #accessing }
GtPythonCoderModel >> pharoBindings: anObject [
	pharoBindings := anObject
]

{ #category : #'private - actions' }
GtPythonCoderModel >> primitiveDebug: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	self flag: #TODO.
]

{ #category : #'private - actions' }
GtPythonCoderModel >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| result remoteValue |
	
	result := self
			bindAndExecute: aSourceString
			inContext: aGtSourceCoderEvaluationContext.
	result associationsDo: [ :binding |
		remoteValue := binding value.
		"try to unwrap all but snippetResult to primitive types"
		binding key = 'snippetResult'
			ifFalse: [ remoteValue := remoteValue unwrapPrimitiveTypes ].
		(pharoBindings bindingOf: binding key asSymbol) value: remoteValue ].

	^ result at: 'snippetResult' ifAbsent: anEvaluationFailBlock
]

{ #category : #accessing }
GtPythonCoderModel >> pythonApplicationStrategy [
	^ pythonApplicationStrategy
]

{ #category : #accessing }
GtPythonCoderModel >> pythonApplicationStrategy: anObject [
	pythonApplicationStrategy := anObject
]

{ #category : #'private - execution' }
GtPythonCoderModel >> pythonBindings [
	"Answer a collection of python bindings.
	This is basically any snippet binding that can be passed in, 
	but always excluding thisSnippet and thisSnippetElement
	while snippetResult is set to nil (None)"
	
	| pythonBindings canBind |

	pythonBindings := OrderedCollection new.
	(pharoBindings bindingOf: #snippetResult) value: nil.
	pharoBindings asDictionary keysAndValuesDo: [ :key :value |
		(#(thisSnippet thisSnippetElement) includes: key) ifFalse: [ 
			canBind := [ MpEncoder encode: value value. true ]
							on: Error do: [ false ].
			canBind ifTrue: [ pythonBindings add: (PBBinding key: key wrap: value value) ] ] ].
	
	^ pythonBindings
]

{ #category : #private }
GtPythonCoderModel >> returnVariablesExpressionFrom: pythonBindings [
	"Answer the LeUninterpretedPythonStatement that returns all the bindings"
	
	| bindingNames expressionString |

	bindingNames := pythonBindings collect: [ :binding | binding key ] as: Set.
	bindingNames add: #snippetResult.
	expressionString := String streamContents: [ :stream |
		stream << '{ '.
		bindingNames 
			do: [ :name | stream  << '"'; << name; << '": registry().proxy('; << name; << ')' ]
			separatedBy: [ stream << ', ' ].
		stream << ' }' ].

	^ LeUninterpretedPythonStatement new string: expressionString
]
