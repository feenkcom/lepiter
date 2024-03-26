Class {
	#name : #GtPharoLinkCoderModel,
	#superclass : #GtSmalltalkSourceCoder,
	#instVars : [
		'pharoBindings',
		'applicationStrategy'
	],
	#category : #'Lepiter-Snippet-PharoLink-Coder'
}

{ #category : #accessing }
GtPharoLinkCoderModel >> applicationStrategy [
	^ applicationStrategy
]

{ #category : #accessing }
GtPharoLinkCoderModel >> applicationStrategy: anObject [
	applicationStrategy := anObject
]

{ #category : #converting }
GtPharoLinkCoderModel >> asCoderViewModel [

	^ GtSourceCoderViewModel new coder: self
]

{ #category : #'private - execution' }
GtPharoLinkCoderModel >> bindAndExecute: sourceString [
	"Answer the source code with all declared variables returned in an immediate dictionary"
	| trimmedSource visitor ast lastStatement varNames llBindings llSource commandFactory application |

	trimmedSource := SmaCCString on: sourceString trimRight.
	visitor := LePharoLinkVarNodeVisitor new.
	ast := GtPharoParser
		parseWithErrors: trimmedSource
		startingAt: GtPharoParser startingStateForMethodSequence.
	visitor acceptNode: ast.
	"The variables to be returned are all the undeclared names"
	varNames := visitor undeclaredVariableNames.

	"Assign the final statement to snippetResult"
	lastStatement := ast statements last.
	trimmedSource 
		insert: 'snippetResult := ' 
		at: lastStatement startPosition.
	varNames add: #snippetResult.

	"Assign the current value to any variables that:
	1. aren't declared,
	2. aren't assigned before use and,
	3. are currently bound in the receiver"
	llBindings := self pharoBindingsFrom: visitor.

	"Get the final source to execute"
	llSource := self sourceFrom: trimmedSource asString returnedVarNames: varNames.
	application := applicationStrategy applicationServer.
	application isRunning ifFalse: [ application start ].
	commandFactory := application newCommandFactory.
	llBindings do: [ :binding |
		commandFactory addBinding: binding ].

	^ commandFactory
		setByValue;
		<< llSource;
		sendAndWait.

]

{ #category : #private }
GtPharoLinkCoderModel >> bindingFor: name in: llBindings [
	"Answer a PharoLinkBinding for the supplied name.
	If the snippet has a binding, use that, otherwise nil"

	llBindings add: (PharoLinkBinding key: name wrap: ((pharoBindings hasBindingOf: name) 
		ifTrue: [ (pharoBindings bindingOf: name) value ]
		ifFalse: [ nil ])).

]

{ #category : #'api - ast' }
GtPharoLinkCoderModel >> computeAst: theSourceString [
	^ GtPharoParser
		parseWithErrors: theSourceString
		startingAt: GtPharoParser startingStateForMethodSequence
]

{ #category : #initialize }
GtPharoLinkCoderModel >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: (GtCoderAstSmaCCParserStyler new smaccStyler: StParser gtStyler).
	
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
GtPharoLinkCoderModel >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDoItShortcut new;
		addShortcut: GtSourceCoderDoItAndInspectShortcut new
]

{ #category : #'instance creation' }
GtPharoLinkCoderModel >> newCompletionStrategy [
	^ GtCompletionStrategy new
]

{ #category : #accessing }
GtPharoLinkCoderModel >> pharoBindings [
	^ pharoBindings
]

{ #category : #accessing }
GtPharoLinkCoderModel >> pharoBindings: anObject [
	pharoBindings := anObject
]

{ #category : #'private - execution' }
GtPharoLinkCoderModel >> pharoBindingsFrom: visitor [
	"Answer a collection of bindings for local variables that aren't declared in the source."
	| llBindings |

	llBindings := OrderedCollection new.
	visitor accessedFirstVariableNames 
		reject: [ :each | each first isUppercase ]
		thenDo: [ :name | self bindingFor: name in: llBindings ].
	visitor undeclaredVariableNames 
		reject: [ :each | each first isUppercase ]
		thenDo: [ :name | self bindingFor: name in: llBindings ].
	llBindings
		detect: [ :each | each key = #snippetResult ]
		ifNone: [ llBindings add: (PharoLinkBinding key: #snippetResult wrap: nil) ].
	^ llBindings
]

{ #category : #'private - actions' }
GtPharoLinkCoderModel >> primitiveDebug: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	self flag: #TODO.
]

{ #category : #'private - actions' }
GtPharoLinkCoderModel >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| result |

	result := self bindAndExecute: aSourceString.
	result associationsDo: [ :binding |
		(pharoBindings bindingOf: binding key asSymbol) value: binding value ].

	^ result
		at: 'snippetResult'
		ifAbsent: anEvaluationFailBlock
]

{ #category : #'private - execution' }
GtPharoLinkCoderModel >> sourceFrom: trimmedSourceString returnedVarNames: varNames [
	"Answer the modified source to return the declared variables"

	^ String streamContents: [ :stream |
		stream << trimmedSourceString.
		trimmedSourceString last = $. ifFalse:
			[ stream nextPut: $. ].
		stream 
			cr
			<< '{ '.
		varNames do: [ :varName |
			stream
				<< '#'; 
				<< varName;
				<< ' -> ';
				<< varName;
				<< '. ' ].
		"Answer the variable dictionary as an immediate object"
		stream
			<< ' } asDictionary' ]
]

{ #category : #accessing }
GtPharoLinkCoderModel >> variableBindings: aGtSnippetBindings [

	^ self pharoBindings: aGtSnippetBindings
]
