Class {
	#name : #GtPharoLinkCoderModel,
	#superclass : #GtSourceCoder,
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
GtPharoLinkCoderModel >> asCoderUIModel [

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
		<< llSource;
		sendAndWait.

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
	
	addOns addStyler: (GtCoderAstSmaCCParserStyler new smaccStyler: StParser gtStyler)
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
	"Answer a collection of bindings for variables that aren't declared in the source and are in the snippet's bindings"
	| llBindings |

	llBindings := OrderedCollection new.
	visitor undeclaredVariableNames do: [ :name |
		(pharoBindings hasBindingOf: name) ifTrue: 
			[ llBindings add: (PharoLinkBinding key: name wrap: (pharoBindings bindingOf: name) value) ] ].
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
	result removeKey: '__pharolinkImmediate'.
	result associationsDo: [ :binding |
		pharoBindings at: binding key asSymbol put: binding value ].

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
			<< '#__pharolinkImmediate -> true. } asDictionary' ]
]

{ #category : #accessing }
GtPharoLinkCoderModel >> variableBindings: aGtSnippetBindings [

	^ self pharoBindings: aGtSnippetBindings
]
