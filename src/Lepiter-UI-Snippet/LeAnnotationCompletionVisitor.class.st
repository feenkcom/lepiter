Class {
	#name : #LeAnnotationCompletionVisitor,
	#superclass : #LeAnnotationParseNodeVisitor,
	#traits : 'TSmaCCComponentVisitor + (TLeAnnotationParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeAnnotationParseNodeVisitor classTrait',
	#category : #'Lepiter-UI-Snippet-Text completion'
}

{ #category : #private }
LeAnnotationCompletionVisitor >> addAction: aString prefixLength: anInteger [
	self composite
		addAction:
			(GtInsertTextCompletionAction
				labeled: aString
				completion: (aString allButFirst: anInteger)
				position: self position)
]

{ #category : #private }
LeAnnotationCompletionVisitor >> classesStartingWith: name [
	self strategy allClasses
		do: [ :each | self addAction: each prefixLength: name size ]
		startingWith: name
]

{ #category : #private }
LeAnnotationCompletionVisitor >> completeShowArgument: anArgument [
	| selector |
	anArgument value stopPosition = self position
		ifTrue: [ selector := anArgument value source.
			selector first = $#
				ifTrue: [ selector := selector allButFirst ].
			(self strategy gtViewSelectors first: 100 startingWith: selector)
				do: [ :each | self addAction: each prefixLength: selector size ] ]
]

{ #category : #private }
LeAnnotationCompletionVisitor >> optionsFor: annotationType startingWith: aString ignoring: aCollection [
	| values |
	values := #().
	annotationType = 'gtClass'
		ifTrue: [ values := #(name label full expanded show height) ].
	annotationType = 'gtMethod'
		ifTrue: [ values := #(name label expanded show height) ].
	annotationType = 'gtExample'
		ifTrue:
			[ values := #(name label expanded codeExpanded noCode previewHeight previewExpanded alignment return) ].
	values
		do: [ :each | 
			((aString isEmpty or: [ each beginsWith: aString ])
				and: [ (aCollection includes: each asString) not ])
				ifTrue: [ self addAction: each , '=' prefixLength: aString size ] ]
]

{ #category : #accessing }
LeAnnotationCompletionVisitor >> position [
	^ self composite position
]

{ #category : #private }
LeAnnotationCompletionVisitor >> previousOptionsFor: aSmaCCErrorNode [
	aSmaCCErrorNode stackContents
		do: [ :each | 
			(each isKindOf: LeAnnotationNode)
				ifTrue: [ ^ each items
						collect:
							[ :item | item name ifNil: [ 'name' ] ifNotNil: [ :node | node value ] ] ] ].
	^ #()
]

{ #category : #private }
LeAnnotationCompletionVisitor >> selectorCompletionsFor: aClass startingWith: aString isExample: aBoolean [
	| selectors name |
	aClass isNil
		ifTrue: [ ^ self ].
	name := aString.
	(name notEmpty and: [ name first = $# ])
		ifTrue: [ name := name allButFirst ].
	selectors := GtPrefixTree new.
	aClass selectors
		do: [ :sel | 
			(name isEmpty or: [ sel beginsWith: name ])
				ifTrue: [ (aBoolean not or: [ aClass >> sel hasPragmaNamed: #gtExample ])
						ifTrue: [ selectors add: sel ] ] ].
	selectors do: [ :sel | self addAction: sel prefixLength: name size ]
]

{ #category : #accessing }
LeAnnotationCompletionVisitor >> strategy [
	^ self composite strategy
]

{ #category : #private }
LeAnnotationCompletionVisitor >> valueForOption: optionName startingWith: aString [
	(#('expanded' 'codeExpanded' 'noCode' 'previewExpanded')
		includes: optionName)
		ifTrue: [ #('true' 'false')
				do: [ :each | 
					(aString isEmpty or: [ each beginsWith: aString ])
						ifTrue: [ self addAction: each prefixLength: aString size ] ] ]
]

{ #category : #generated }
LeAnnotationCompletionVisitor >> visitArgument: anArgument [
	(anArgument equals notNil
		and: [ self position = anArgument equals stopPosition ])
		ifTrue:
			[ self valueForOption: anArgument name source startingWith: '' ].
	^ self visitAnnotationParse: anArgument
]

{ #category : #visiting }
LeAnnotationCompletionVisitor >> visitMethodNameArgument: aMethodNameArgument [
	aMethodNameArgument selector stopPosition = self position
		ifTrue: [ aMethodNameArgument behavior
				ifNotNil: [ :cls | 
					self
						selectorCompletionsFor: cls
						startingWith: aMethodNameArgument selector source
						isExample: aMethodNameArgument parent parent name source = 'gtExample' ] ].
	^ super visitMethodNameArgument: aMethodNameArgument
]

{ #category : #visiting }
LeAnnotationCompletionVisitor >> visitNameArgument: aNameArgument [
	self position = aNameArgument value stopPosition
		ifTrue: [ | name |
			name := aNameArgument value source.
			self classesStartingWith: name ].
	^ super visitNameArgument: aNameArgument
]

{ #category : #visiting }
LeAnnotationCompletionVisitor >> visitPreviewShowArgument: aPreviewShowArgument [
	self completeShowArgument: aPreviewShowArgument.
	^ self visitArgument: aPreviewShowArgument
]

{ #category : #visiting }
LeAnnotationCompletionVisitor >> visitShowArgument: aShowArgument [
	self completeShowArgument: aShowArgument.
	^ self visitArgument: aShowArgument
]

{ #category : #visiting }
LeAnnotationCompletionVisitor >> visitSmaCCError: aSmaCCError [
	| index token annotationType class className isMeta |
	index := (1 to: aSmaCCError dismissedTokens size)
		detect:
			[ :i | (aSmaCCError dismissedTokens at: i) stopPosition = self position ]
		ifNone: [ 0 ].
	annotationType := aSmaCCError parent name source.
	index > 0
		ifTrue: [ token := (aSmaCCError dismissedTokens at: index) value.
			token = '|'
				ifTrue: [ ^ self
						optionsFor: annotationType
						startingWith: ''
						ignoring: (self previousOptionsFor: aSmaCCError) ].
			token = '='
				ifTrue: [ ^ index > 1
						ifTrue: [ self
								valueForOption: (aSmaCCError dismissedTokens at: index - 1) value
								startingWith: '' ]
						ifFalse: [ self
								valueForOption: aSmaCCError stackContents last items last name value
								startingWith: '' ] ].
			index > 1
				ifTrue: [ (aSmaCCError dismissedTokens at: index - 1) value = '|'
						ifTrue: [ ^ self
								optionsFor: annotationType
								startingWith: token
								ignoring: (self previousOptionsFor: aSmaCCError) ].
					(aSmaCCError dismissedTokens at: index - 1) value = '='
						ifTrue: [ ^ index > 2
								ifTrue: [ self
										valueForOption: (aSmaCCError dismissedTokens at: index - 2) value
										startingWith: token ]
								ifFalse: [ self
										valueForOption: aSmaCCError stackContents last items last name value
										startingWith: token ] ] ].
			(('class' beginsWith: token)
				and: [ aSmaCCError stackContents notEmpty
						and: [ aSmaCCError stackContents last isKindOf: LeClassAnnotationNode ] ])
				ifTrue: [ ^ self addAction: 'class' prefixLength: token size ] ].
	index = 0
		ifTrue: [ aSmaCCError stackContents isEmpty
				ifTrue: [ ^ aSmaCCError parent colon stopPosition = self position
						ifTrue: [ self optionsFor: annotationType startingWith: '' ignoring: #() ]
						ifFalse: [ aSmaCCError errorToken stopPosition = self position
								ifTrue: [ self
										optionsFor: annotationType
										startingWith: aSmaCCError errorToken value
										ignoring: #() ] ] ].
			(aSmaCCError stackContents last isKindOf: SmaCCToken)
				ifTrue: [ aSmaCCError stackContents last stopPosition = self position
						ifTrue: [ token := aSmaCCError stackContents last value.
							token = '>>'
								ifTrue: [ className := (aSmaCCError stackContents
										at: aSmaCCError stackContents size - 1) value.
									isMeta := className = 'class'.
									isMeta
										ifTrue: [ className := (aSmaCCError stackContents
												at: aSmaCCError stackContents size - 2) value ].
									Smalltalk
										at: className asSymbol
										ifPresent: [ :cls | 
											class := isMeta
												ifTrue: [ cls class ]
												ifFalse: [ cls ] ].
									^ self
										selectorCompletionsFor: class
										startingWith: ''
										isExample: aSmaCCError parent name source = 'gtExample' ].
							(token = '='
								and: [ (aSmaCCError stackContents at: aSmaCCError stackContents size - 1)
										value = 'name' ])
								ifTrue: [ ^ self classesStartingWith: '' ].
							token first isUppercase
								ifTrue: [ ^ self classesStartingWith: token ] ] ] ].
	^ self visitSmaCCParseNode: aSmaCCError
]
