Class {
	#name : 'GtGemStoneCoderModel',
	#superclass : 'GtSourceCoder',
	#instVars : [
		'pharoBindings',
		'applicationStrategy',
		'remoteScript',
		'remoteBindings'
	],
	#category : 'Lepiter-Snippet-GemStone-Coder'
}

{ #category : 'accessing' }
GtGemStoneCoderModel >> applicationStrategy [
	^ applicationStrategy
]

{ #category : 'accessing' }
GtGemStoneCoderModel >> applicationStrategy: anObject [
	applicationStrategy := anObject
]

{ #category : 'converting' }
GtGemStoneCoderModel >> asCoderUIModel [

	^ GtSourceCoderViewModel new coder: self
]

{ #category : 'api - ast' }
GtGemStoneCoderModel >> computeAst: theSourceString [
	^ GtPharoParser
		parseWithErrors: theSourceString
		startingAt: GtPharoParser startingStateForMethodSequence
]

{ #category : 'initialize' }
GtGemStoneCoderModel >> initializeAddOns: addOns [
	super initializeAddOns: addOns.
	
	addOns addStyler: (GtCoderAstSmaCCParserStyler new smaccStyler: StParser gtStyler)
]

{ #category : 'initialize' }
GtGemStoneCoderModel >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderDoItShortcut new;
		addShortcut: GtSourceCoderDoItAndInspectShortcut new
]

{ #category : 'private - execution' }
GtGemStoneCoderModel >> insert: varNames asTemporariesIn: trimmedSource leftBarPosition: leftBar [
	| temporaries index |

	temporaries := String streamContents: [ :stream |
		leftBar 
			ifNil: [ stream << '| ' ]
			ifNotNil: [ stream space ].
		varNames do: [ :name |
			stream 
				<< name;
				space ].
		(varNames includes: #snippetResult) ifFalse:
			[ stream << 'snippetResult ' ].
		leftBar ifNil: 
			[ stream 
				<< '|';
				cr ] ].

	index := leftBar
		ifNil: [ 1 ]
		ifNotNil: [ leftBar + 1 ].
	trimmedSource insert: temporaries at: index.
]

{ #category : 'instance creation' }
GtGemStoneCoderModel >> newCompletionStrategy [
	^ GtCompletionStrategy new
]

{ #category : 'accessing' }
GtGemStoneCoderModel >> pharoBindings [
	^ pharoBindings
]

{ #category : 'accessing' }
GtGemStoneCoderModel >> pharoBindings: anObject [
	pharoBindings := anObject
]

{ #category : 'private - execution' }
GtGemStoneCoderModel >> pharoBindingsFrom: visitor [
	"Answer a collection of bindings for variables that aren't declared in the source and are in the snippet's bindings"
	| bindings |

	bindings := Dictionary new.
	visitor globalVariableNames do: [ :name |
		(pharoBindings hasBindingOf: name) ifTrue: 
			[ bindings at: name put: (pharoBindings bindingOf: name) value ] ].
	(pharoBindings hasBindingOf: #snippetResult) ifTrue: 
			[ bindings at: #snippetResult put: (pharoBindings bindingOf: #snippetResult) value ].
	^ bindings
]

{ #category : 'private - actions' }
GtGemStoneCoderModel >> primitiveDebug: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	self flag: #TODO.
]

{ #category : 'private - actions' }
GtGemStoneCoderModel >> primitiveEvaluate: aSourceString inContext: aGtSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| result gemstoneClient|

	self updateRemoteFrom: aSourceString.
	gemstoneClient := applicationStrategy applicationServer.
	gemstoneClient isRunning ifFalse: [ gemstoneClient connect ].

	result := gemstoneClient evaluateAndWait: remoteScript for: nil bindings: remoteBindings.
	result associationsDo: [ :binding |
		pharoBindings at: binding key asSymbol put: binding value ].

	^ result
		at: 'snippetResult'
		ifAbsent: anEvaluationFailBlock
]

{ #category : 'accessing' }
GtGemStoneCoderModel >> remoteBindings [
	^ remoteBindings
]

{ #category : 'accessing' }
GtGemStoneCoderModel >> remoteScript [
	^ remoteScript
]

{ #category : 'private - execution' }
GtGemStoneCoderModel >> returnExpressionWithNames: varNames [
	"Answer return expression for the remote script"

	^ String streamContents: [ :stream |
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
		stream
			<< ' #snippetResult -> snippetResult. } asDictionary' ]
]

{ #category : 'private - execution' }
GtGemStoneCoderModel >> updateRemoteFrom: sourceString [
	"Update remoteScript and remoteBindings based on the supplied source code and the prebuild AST (newAstCache)"
	| trimmedString trimmedSource visitor lastStatement varNames leftBar |

	trimmedString := sourceString trimRight.
	trimmedSource := SmaCCString on: trimmedString.
	trimmedString last = $. ifFalse: 
		[ trimmedSource append: '.' ].
	visitor := LeGemStoneVarNodeVisitor new.
	self astAwaitDo: [ :ast |
		visitor acceptNode: ast.
		lastStatement := ast statements last.
		leftBar := ast leftBar ifNotNil: [ ast leftBar startPosition ] ].
	varNames := visitor undeclaredVariableNames.
	pharoBindings ifNotNil:
		[ pharoBindings allNames do: [ :name |
			varNames remove: name ifAbsent: [] ] ].

	"Construct the script to be evaluated on the remote (GemStone server):
	1. Add any undeclared variables names to the script's list of tempararies"
	self insert: varNames asTemporariesIn: trimmedSource leftBarPosition: leftBar.
	"2. Assign the final statement to snippetResult"
	trimmedSource 
		insert: 'snippetResult := ' 
		at: lastStatement startPosition.
	"3. Answer a dictionary containing the returned variables"
	trimmedSource append: (self returnExpressionWithNames: visitor undeclaredVariableNames).
	remoteScript := trimmedSource asString.

	"Assign the current value to any variables that:
	1. aren't declared,
	2. aren't assigned before use and,
	3. are currently bound in the receiver"
	remoteBindings := self pharoBindingsFrom: visitor.

]

{ #category : 'accessing' }
GtGemStoneCoderModel >> variableBindings: aGtSnippetBindings [

	^ self pharoBindings: aGtSnippetBindings
]
