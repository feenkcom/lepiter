"
# Code snippet
{{gtClass:LeCodeSnippet}} is an abstract representation of a snipet of code in any language.
The language support is provided by specialized {{gtClass:GtSourceCoder}}

### Instance Variables
	code:		<String>


### Implementation Points

"
Class {
	#name : #LeCodeSnippet,
	#superclass : #LeTextualSnippet,
	#instVars : [
		'coder'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LeCodeSnippet class >> code: aString [

	^ self new code: aString
]

{ #category : #utils }
LeCodeSnippet class >> createTextAttributeWithValue: aSnippetText [
	^ (super createTextAttributeWithValue: aSnippetText)
		attributeName: #code
]

{ #category : #factory }
LeCodeSnippet class >> empty [ 

	^ self new
]

{ #category : #testing }
LeCodeSnippet class >> isAbstract [
	^ self name = #LeCodeSnippet
]

{ #category : #accesing }
LeCodeSnippet class >> stateAttributes [
	^ self leJsonV4AttributeMapping collect: [ :aMapping |
		aMapping key = #code
			ifTrue: [ LeTextualSnippetStringAttribute named: aMapping key ]
			ifFalse: [ LeGenericSnippetStateAttribute named: aMapping key ] ]
]

{ #category : #references }
LeCodeSnippet >> addParameterTo: oldName using: aRewriter [
	| source ast |
	self isForLocalImage ifFalse: [ ^ nil ].
	source := self coder currentSourceString.
	ast := RBParser parseFaultyExpression: source.
	(aRewriter executeTree: ast)
		ifTrue: [ ^ LeSnippetChange new
				snippet: self;
				newSource: aRewriter tree formattedCode;
				yourself ].
	^ nil
]

{ #category : #'api - editing' }
LeCodeSnippet >> appendText: aText source: anObject [

	coder
		appendText: aText
		with: (GtCoderUpdateStrategy new source: anObject)
]

{ #category : #references }
LeCodeSnippet >> changeToRenameClass: oldName to: newName [
	| modifiedSource |
	self isForLocalImage ifFalse: [ ^ nil ].
	modifiedSource := SmaCCString on: self string.
	self coder ast wait ast
		withAllNodesDo: [ :each | 
			each isErrorNode
				ifFalse: [ each isVariable
						ifTrue: [ each name value = oldName
								ifTrue: [ modifiedSource
										replaceFrom: each startPosition
										to: each stopPosition
										with: newName ] ]
						ifFalse: [ (each isLiteral and: [ each isSymbol ])
								ifTrue: [ each symbol = oldName asSymbol
										ifTrue: [ modifiedSource
												replaceFrom: (each source first = $#
														ifTrue: [ each startPosition + 1 ]
														ifFalse: [ each startPosition ])
												to: each stopPosition
												with: newName ] ] ] ] ]
		andTokensDo: [ :token |  ]
		includesErrors: true.
	modifiedSource isModified ifFalse: [ ^ nil ].
	^ LeSnippetChange new
		snippet: self;
		newSource: modifiedSource asString;
		yourself
]

{ #category : #references }
LeCodeSnippet >> changeToRenameSelector: oldName to: newName using: aRewriter [
	| modifiedSource source ast |
	self isForLocalImage ifFalse: [ ^ nil ].
	aRewriter
		ifNotNil: [ source := self coder currentSourceString.
			ast := RBParser parseFaultyExpression: source.
			(aRewriter executeTree: ast)
				ifTrue: [ ^ LeSnippetChange new
						snippet: self;
						newSource: aRewriter tree formattedCode;
						yourself ].
			^ nil ].
	modifiedSource := SmaCCString on: self string.
	self coder ast wait ast
		withAllNodesDo: [ :each | 
			| parentNode |
			each isErrorNode
				ifFalse: [ (each isKindOf: GtPharoMessageNode)
						ifTrue: [ each selector = oldName asSymbol
								ifTrue: [ each selectorParts
										with: newName keywords
										do: [ :token :string | 
											token source = string
												ifFalse: [ modifiedSource
														replaceFrom: token startPosition
														to: token stopPosition
														with: string ] ].
									(newName isKeyword
										and: [ each selector isBinary
												and: [ ((parentNode := each parent) isKindOf: GtPharoMessageSendNode)
														and: [ parentNode leftParens isEmpty
																and: [ (parentNode parent isKindOf: GtPharoMessageSendNode)
																		or: [ parentNode parent isKindOf: GtPharoMessageSendNode ] ] ] ] ])
										ifTrue: [ modifiedSource
												insert: '(' at: parentNode startPosition;
												insert: ')' at: parentNode stopPosition + 1 ] ] ]
						ifFalse: [ (each isKindOf: GtPharoSymbolLiteralNode)
								ifTrue: [ each symbol = oldName asSymbol
										ifTrue: [ modifiedSource
												replaceFrom: (each source first = $#
														ifTrue: [ each startPosition + 1 ]
														ifFalse: [ each startPosition ])
												to: each stopPosition
												with: newName ] ] ] ] ]
		andTokensDo: [ :token |  ]
		includesErrors: true.
	modifiedSource isModified ifFalse: [ ^ nil ].
	^ LeSnippetChange new
		snippet: self;
		newSource: modifiedSource asString;
		yourself
]

{ #category : #references }
LeCodeSnippet >> classAndSelectorReferencesPromise [
	^ self coder ast
		then: [ :coderAst | 
			| refs vars |
			vars := Set new.
			refs := Set new.
			coderAst ast
				withAllNodesDo: [ :each | 
					(each isKindOf: GtPharoVariableNode)
						ifTrue: [ each name value first isUppercase ifTrue: [ vars add: each name value ] ]
						ifFalse: [ (each isKindOf: GtPharoMessageNode)
								ifTrue: [ refs add: each selector ]
								ifFalse: [ (each isKindOf: GtPharoSymbolLiteralNode)
										ifTrue: [ each symbol
												ifNotNil: [ :symbol | symbol numArgs >= 0 ifTrue: [ refs add: symbol ] ] ] ] ] ]
				andTokensDo: [ :t |  ]
				includesErrors: true.
			{vars.
				refs} ]
]

{ #category : #'api - accessing' }
LeCodeSnippet >> code [
	<return: #String>

	^ coder currentSourceString
]

{ #category : #'api - accessing' }
LeCodeSnippet >> code: aString [ 

	^ self code: aString source: self
]

{ #category : #'api - accessing' }
LeCodeSnippet >> code: aString source: anObject [
	"Set a new source string"

	coder
		sourceCode: (GtCoderExplicitStringSource new source: aString)
		withStrategy: (GtCoderUpdateStrategy new source: anObject)
]

{ #category : #'api - accessing' }
LeCodeSnippet >> coder [
	<return: #GtTextualCoder>

	^ coder
]

{ #category : #'api - accessing' }
LeCodeSnippet >> contentAsString [
	^ self code
]

{ #category : #'private - event handling' }
LeCodeSnippet >> executeWithLoggingAction: aBlock afterChange: aGtCoderSourceCodeChanged [ 
	"Execute the given block by creating a trace event 
	for the given coder change."
	| fakeCommand undoSpecification traceEvent |
	
	aGtCoderSourceCodeChanged textEditCommand 
		ifNil: [
			fakeCommand := self commandBuilder editTextualSnippetCommand
				code: aGtCoderSourceCodeChanged newText asString.
	
			undoSpecification := fakeCommand createUndoCommandSpecification.
			(undoSpecification snippetState 
				attributeNamed: 'code')
					string: aGtCoderSourceCodeChanged previousText asString ]
		ifNotNil: [
			fakeCommand := self commandBuilder editTextValueSnippetCommand
				textEditCommand: aGtCoderSourceCodeChanged textEditCommand.
			undoSpecification := fakeCommand createUndoCommandSpecification ].
	
	traceEvent := LeContentEditTraceEvent new
		mainCommandSpecification: fakeCommand createCommandSpecification
			asSpecificationForLogStorage;
		undoCommandSpecification: undoSpecification 
			asSpecificationForLogStorage.
	
	aBlock value.
	
	self announceTraceableChangeExecutedFor: traceEvent
]

{ #category : #initialization }
LeCodeSnippet >> initialize [ 
	super initialize.

	coder := self newCoder.
	coder weak
		when: GtCoderSourceCodeChanged
			send: #onCoderSourceModified:
			to: self;
		when: GtCoderRenameTemporaryRequestedAnnouncement
			send: #onCoderRenameTemporaryRequested:
			to: self
]

{ #category : #'api - testing' }
LeCodeSnippet >> isCodeSnippet [
	^ true
]

{ #category : #testing }
LeCodeSnippet >> isForLocalImage [
	^ false
]

{ #category : #'as yet unclassified' }
LeCodeSnippet >> markdownOn: stream level: anInteger [
	"Write the receiver as an HTML string on the supplied stream.
	This is currently a simplistic implementation which doesn't handle line breaks within the block properly (they need to be indented)"

	(self hasText or: [ self hasChildren ]) ifFalse: [ ^ self ].
	anInteger * 4 timesRepeat: [ stream nextPut: Character space ].
	stream
		<< (anInteger > 0 ifTrue: [ '- ' ] ifFalse: [ '' ]);
		<< '```';
		<< self class description;
		cr;
		<< self contentAsString trimBoth;
		cr;
		<< '```'.
	self
		childrenDo: [ :child | 
			stream cr.
			child markdownOn: stream level: anInteger + 1 ]
]

{ #category : #initialization }
LeCodeSnippet >> newCoder [
	^ self subclassResponsibility
]

{ #category : #'private - event handling' }
LeCodeSnippet >> onCoderRenameTemporaryRequested: aGtCoderRenameTemporaryRequestedAnnouncement [
	self page
		allChildrenDepthFirstDo:
			[ :each | 
			(each isCodeSnippet
				and: [ each coder hasImplicitVariableReferenceTo: aGtCoderRenameTemporaryRequestedAnnouncement variableName ])
				ifTrue: [ aGtCoderRenameTemporaryRequestedAnnouncement interestedCoders add: each coder ] ]
]

{ #category : #'private - event handling' }
LeCodeSnippet >> onCoderSourceModified: aGtCoderSourceCodeChanged [
	"Is announced by the Coder model when its source code changes"
	
	"In case the source of the event is a command, 
	do not log another trace of the change."
	(self shouldAddTraceEventForChange: aGtCoderSourceCodeChanged) 
		ifFalse: [ ^ self updateAfterChange: aGtCoderSourceCodeChanged ].
	
	self 
		executeWithLoggingAction: [ 
			self updateAfterChange: aGtCoderSourceCodeChanged ]  
		afterChange: aGtCoderSourceCodeChanged
]

{ #category : #printing }
LeCodeSnippet >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: '(';
		nextPutAll: (self code 
			ifNil: [''] ifNotNil: [self code takeFirst: 20]);
		nextPutAll: ')'
]

{ #category : #references }
LeCodeSnippet >> removeParameterFrom: oldName using: aRewriter [
	| source ast |
	self isForLocalImage ifFalse: [ ^ nil ].
	source := self coder currentSourceString.
	ast := RBParser parseFaultyExpression: source.
	(aRewriter executeTree: ast)
		ifTrue: [ ^ LeSnippetChange new
				snippet: self;
				newSource: aRewriter tree formattedCode;
				yourself ].
	^ nil
]

{ #category : #'private - event handling' }
LeCodeSnippet >> shouldAddTraceEventForChange: aGtCoderSourceCodeChanged [ 
	"We only add a trace event if we either have the previous text
	or the basic text edit command, and the change was not the 
	result of another command."
	
	^ (aGtCoderSourceCodeChanged previousText notNil or: [
		aGtCoderSourceCodeChanged textEditCommand  notNil]) and: [
			aGtCoderSourceCodeChanged updateStrategy notNil and: [
				(aGtCoderSourceCodeChanged updateStrategy 
					propertyNamed: #isFromEditCommand ifAbsent: [ false ]) not ]]
]

{ #category : #printing }
LeCodeSnippet >> storeOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new code: '.
	self code storeOn: aStream.
	self childrenDo: [ :snippet | 
		aStream nextPutAll: '; addSnippet: '.
		snippet storeOn: aStream ].
	aStream nextPutAll: '; yourself)'
]

{ #category : #'api - accessing' }
LeCodeSnippet >> text [
	<return: #BlText>

	^ coder currentSourceText
]

{ #category : #'private - event handling' }
LeCodeSnippet >> updateAfterChange: aGtCoderSourceCodeChanged [ 
	"The snippet stores the entire coder model, so after a change 
	in coder, we do not need to modify the code in the snippet.
	We only update metadata and links."
	
	self updateEditTimeAndEmail.
	
	self updateUnlinkedReferences.
	self announceTextChangedBy: aGtCoderSourceCodeChanged source
]

{ #category : #'api - editing' }
LeCodeSnippet >> updateFromCommandText: aText source: anObject [
	coder
		currentSourceText: aText
		with: (GtCoderUpdateStrategy new 
			source: anObject;
			propertyNamed: #isFromEditCommand put: true;
			yourself)
]

{ #category : #'api - editing' }
LeCodeSnippet >> updateFromTextEditCommand: aCommand source: anObject [
	| targetText |
	targetText := self text.
	aCommand applyTextChangeOn: targetText.
	
	self 
		updateFromTextEditCommand: aCommand
		withText: targetText
		source: anObject
]

{ #category : #'api - editing' }
LeCodeSnippet >> updateFromTextEditCommand: aCommand withText: aModifiedText source: anObject [
	coder
		currentSourceText: aModifiedText
		with: (GtCoderUpdateStrategy new 
			source: anObject;
			propertyNamed: #isFromEditCommand put: true;
			textEditCommand: aCommand;
			yourself)
]

{ #category : #'api - editing' }
LeCodeSnippet >> updateText: aText source: anObject [
	"Change the text of the textual snippet to a given one. A source object represent an object that requested a text change"

	coder
		currentSourceText: aText
		with: (GtCoderUpdateStrategy new 
			source: anObject)
]
