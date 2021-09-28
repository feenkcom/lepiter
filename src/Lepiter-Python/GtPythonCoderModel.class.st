Class {
	#name : 'GtPythonCoderModel',
	#superclass : 'GtSourceCoder',
	#instVars : [
		'pythonApplicationStrategy',
		'pharoBindings'
	],
	#category : 'Lepiter-Python-Coder'
}

{ #category : 'converting' }
GtPythonCoderModel >> asCoderUIModel [

	^ GtSourceCoderViewModel new coder: self
]

{ #category : 'private - execution' }
GtPythonCoderModel >> bindAndExecute: sourceString [
	"Answer the source code with all declared variables returned in an immediate dictionary"
	| statements commandFactory lastStatement pythonBindings application |

	statements := LeUninterpretedPythonStatement statementsFrom: sourceString.

	"Assign the final statement to snippetResult if it isn't already an assignment"
	lastStatement := statements last.
	lastStatement string: 'snippetResult = ', lastStatement string.

	pythonBindings := self pythonBindings.
	"Return the bindings passed in and the result"
	statements := statements, { self returnVariablesExpressionFrom: pythonBindings }.

	application := pythonApplicationStrategy applicationServer.
	application isRunning ifFalse: [ application start ].
	commandFactory := application newCommandFactory.
	pythonBindings do: [ :binding |
		commandFactory addBinding: binding ].
	statements do: [ :statement |
		commandFactory << statement ].
	^ commandFactory sendAndWait.

]

{ #category : 'api - ast' }
GtPythonCoderModel >> computeAst: theSourceString [
	^ PythonParser
		parseWithErrors: theSourceString
		startingAt: PythonParser startingStateForfile_input
]

{ #category : 'api - ast' }
GtPythonCoderModel >> implicitVariableReferencesTo: aString do: aBlock [
	self astAwait allNodesOfType: PySymbolNode do: [ :node | 
		node nameToken source = aString ifTrue: [ aBlock value: node ] ]
]

{ #category : 'initialize' }
GtPythonCoderModel >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: (GtCoderAstSmaCCParserStyler new smaccStyler: PythonParser gtStyler).
	
	addOns
		addMainAction: 'Evaluate' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doIt
				coderUIModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItActionId.
	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doItAndGo
				coderUIModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
]

{ #category : 'initialize' }
GtPythonCoderModel >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDoItShortcut new;
		addShortcut: GtSourceCoderDoItAndInspectShortcut new
]

{ #category : 'instance creation' }
GtPythonCoderModel >> newCompletionStrategy [
	^ GtCompletionStrategy new
]

{ #category : 'accessing' }
GtPythonCoderModel >> pharoBindings [
	^ pharoBindings
]

{ #category : 'accessing' }
GtPythonCoderModel >> pharoBindings: anObject [
	pharoBindings := anObject
]

{ #category : 'private - actions' }
GtPythonCoderModel >> primitiveDebug: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	self flag: #TODO.
]

{ #category : 'private - actions' }
GtPythonCoderModel >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| result |

	result := self bindAndExecute: aSourceString.
	result associationsDo: [ :binding |
		(pharoBindings bindingOf: binding key asSymbol) value: binding value ].

	^ result
		at: 'snippetResult'
		ifAbsent: anEvaluationFailBlock
]

{ #category : 'accessing' }
GtPythonCoderModel >> pythonApplicationStrategy [
	^ pythonApplicationStrategy
]

{ #category : 'accessing' }
GtPythonCoderModel >> pythonApplicationStrategy: anObject [
	pythonApplicationStrategy := anObject
]

{ #category : 'private - execution' }
GtPythonCoderModel >> pythonBindings [
	"Answer a collection of python bindings.
	This is basically any snippet binding that can be passed in, but always excluding thisSnippet, thisSnippetElement and snippetResult"
	| pythonBindings canBind |

	pythonBindings := OrderedCollection new.
	(pharoBindings bindingOf: #snippetResult) value: nil.
	pharoBindings asDictionary keysAndValuesDo: [ :key :value |
		(#(thisSnippet thisSnippetElement) includes: key) ifFalse: 
			[ canBind := [ MpEncoder encode: value value.
					"NeoJSONWriter toString: value value." true ]
				on: Error do: [ false ].
			canBind ifTrue: 
				[ pythonBindings add: (PBBinding key: key wrap: value value) ] ] ].
	^ pythonBindings
]

{ #category : 'private' }
GtPythonCoderModel >> returnVariablesExpressionFrom: pythonBindings [
	"Answer the LeUninterpretedPythonStatement that returns all the bindings"
	| bindingNames expressionString |

	bindingNames := pythonBindings collect: [ :binding | binding key ] as: Set.
	bindingNames add: #snippetResult.
	expressionString := String streamContents: [ :stream |
		stream << '{ '.
		bindingNames 
			do: [ :name |
				stream 
					nextPut: $";
					<< name;
					<< '": ';
					<< name ]
			separatedBy:
				[ stream << ', ' ].
		stream << ' }' ].
	^ LeUninterpretedPythonStatement new string: expressionString
]

{ #category : 'accessing' }
GtPythonCoderModel >> variableBindings: aGtSnippetBindings [

	^ self pharoBindings: aGtSnippetBindings
]
