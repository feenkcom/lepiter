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
				labeled: (self strategy labelFor: aString withSearch: (aString first: anInteger))
				completion: (aString allButFirst: anInteger)
				position: self position)
]

{ #category : #private }
LeAnnotationCompletionVisitor >> classesStartingWith: name [
	self composite
		addStream:
			((self strategy allClasses asyncStreamStartingWith: name)
				collect:
					[ :each | 
					GtInsertTextCompletionAction
						labeled: (self strategy labelFor: each withSearch: name)
						completion: (each allButFirst: name size)
						position: self position ])
]

{ #category : #private }
LeAnnotationCompletionVisitor >> completeShowArgument: anArgument [
	| selector |
	anArgument value stopPosition = self position
		ifTrue:
			[ selector := anArgument value source.
			selector first = $# ifTrue: [ selector := selector allButFirst ].
			self composite
				addStream:
					((self strategy gtViewSelectors asyncStreamStartingWith: selector)
						collect:
							[ :each | 
							GtInsertTextCompletionAction
								labeled: (self strategy labelFor: each withSearch: selector)
								completion: (each allButFirst: selector size)
								position: self position ]) ]
]

{ #category : #private }
LeAnnotationCompletionVisitor >> optionalValues [
	^ #('expanded' 'full' 'previewExpanded' 'noCode' 'codeExpanded')
]

{ #category : #private }
LeAnnotationCompletionVisitor >> optionsFor: annotationType startingWith: aString ignoring: aCollection [
	| values |
	values := #().
	annotationType = 'gtClass' ifTrue: [ values := #(name label full expanded show height) ].
	annotationType = 'gtPackage' ifTrue: [ values := #(name label tag expanded show height) ].
	annotationType = 'gtMethod' ifTrue: [ values := #(name label expanded show height) ].
	annotationType = 'gtExample'
		ifTrue: [ values := #(name label expanded codeExpanded noCode previewHeight previewExpanded previewShow previewSelect alignment return) ].
	annotationType = 'gtTodo' ifTrue: [ values := #(label due completed) ].
	self composite
		addStream:
			((values asAsyncStream
				filter: [ :each | (aString isEmpty or: [ each beginsWith: aString ]) and: [ (aCollection includes: each asString) not ] ])
				collect:
					[ :each | 
					| name hasOptionalValue |
					hasOptionalValue := self optionalValues includes: each.
					name := each , (hasOptionalValue ifTrue: [ '' ] ifFalse: [ '=' ]).
					(GtInsertTextCompletionAction
						labeled: (self strategy labelFor: name withSearch: aString)
						completion: (name allButFirst: aString size)
						position: self position) partial: hasOptionalValue not ])
]

{ #category : #generated }
LeAnnotationCompletionVisitor >> packageCompletionsFor: aString [
	| selectors |
	selectors := GtPrefixTree new.
	RPackageOrganizer default packages
		do: [ :package | 
			(aString isEmpty or: [ package name beginsWith: aString ])
				ifTrue: [ selectors add: package name ] ].
	self composite
		addStream: ((selectors asyncStreamStartingWith: '')
				collect: [ :each | 
					GtInsertTextCompletionAction
						labeled: (self strategy labelFor: each withSearch: aString)
						completion: (each allButFirst: aString size)
						position: self position ])
]

{ #category : #generated }
LeAnnotationCompletionVisitor >> packageTagCompletionsFor: aString with: aPackageAnnotation [
	| selectors |
	(aPackageAnnotation nameNode isNotNil
		and: [ aPackageAnnotation nameNode isDefined ]) ifFalse: [ ^ self ].

	selectors := GtPrefixTree new.
	aPackageAnnotation nameNode imageObject classTags
		do: [ :aTag | 
			(aString isEmpty or: [ aTag name beginsWith: aString ])
				ifTrue: [ selectors add: aTag name ] ].
	self composite
		addStream: ((selectors asyncStreamStartingWith: '')
				collect: [ :each | 
					GtInsertTextCompletionAction
						labeled: (self strategy labelFor: each withSearch: aString)
						completion: (each allButFirst: aString size)
						position: self position ])
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
	aClass isNil ifTrue: [ ^ self ].
	name := aString.
	(name notEmpty and: [ name first = $# ]) ifTrue: [ name := name allButFirst ].
	selectors := GtPrefixTree new.
	aClass selectors
		do:
			[ :sel | 
			(name isEmpty or: [ sel beginsWith: name ])
				ifTrue: [ (aBoolean not or: [ aClass >> sel hasPragmaNamed: #gtExample ]) ifTrue: [ selectors add: sel ] ] ].
	self composite
		addStream:
			((selectors asyncStreamStartingWith: '')
				collect:
					[ :each | 
					GtInsertTextCompletionAction
						labeled: (self strategy labelFor: each withSearch: name)
						completion: (each allButFirst: name size)
						position: self position ])
]

{ #category : #accessing }
LeAnnotationCompletionVisitor >> strategy [
	^ self composite strategy
]

{ #category : #private }
LeAnnotationCompletionVisitor >> valueForOption: optionName startingWith: aString [
	(#('expanded' 'codeExpanded' 'noCode' 'previewExpanded') includes: optionName)
		ifTrue:
			[ self composite
				addStream:
					((#('true' 'false') asAsyncStream filter: [ :each | aString isEmpty or: [ each beginsWith: aString ] ])
						collect:
							[ :each | 
							GtInsertTextCompletionAction
								labeled: (self strategy labelFor: each withSearch: aString)
								completion: (each allButFirst: aString size)
								position: self position ]) ]
]

{ #category : #generated }
LeAnnotationCompletionVisitor >> visitArgument: anArgument [
	(anArgument equals notNil
		and: [ self position = anArgument equals stopPosition ])
		ifTrue:
			[ self valueForOption: anArgument name source startingWith: '' ].
	^ self visitAnnotationParse: anArgument
]

{ #category : #generated }
LeAnnotationCompletionVisitor >> visitDateArgument: aDateArgument [
	| first last |
	first := aDateArgument equals stopPosition.
	last := (aDateArgument value ifNil: [ aDateArgument equals stopPosition ] ifNotNil: [ aDateArgument value stopPosition ])
		+ 1.
	(self position >= first and: [ self position < last ])
		ifTrue:
			[ ^ composite
				completionResult:
					(GtCalendarCompletionResult forDate: (aDateArgument date ifNil: [ Date today ]) andInterval: (first + 1 to: last)) ].
	^ self visitArgument: aDateArgument
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

{ #category : #generated }
LeAnnotationCompletionVisitor >> visitPackageNameArgument: aPackageNameArgument [
	aPackageNameArgument value stopPosition = self position
		ifTrue: [ self
						packageCompletionsFor: aPackageNameArgument value value] .
]

{ #category : #generated }
LeAnnotationCompletionVisitor >> visitPackageTagArgument: aPackageTagArgument [
	aPackageTagArgument value stopPosition = self position
		ifTrue: [ self
				packageTagCompletionsFor: aPackageTagArgument value value
				with: aPackageTagArgument parent ]
]

{ #category : #generated }
LeAnnotationCompletionVisitor >> visitPreviewSelectArgument: aPreviewSelectArgument [
	self completeShowArgument: aPreviewSelectArgument.
	^ self visitArgument: aPreviewSelectArgument
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
		detect: [ :i | (aSmaCCError dismissedTokens at: i) stopPosition = self position ]
		ifNone: [ 0 ].
	annotationType := aSmaCCError parent name source.
	index > 0
		ifTrue:
			[ token := (aSmaCCError dismissedTokens at: index) value.
			token = '|'
				ifTrue:
					[ ^ self
						optionsFor: annotationType
						startingWith: ''
						ignoring: (self previousOptionsFor: aSmaCCError) ].
			token = '='
				ifTrue:
					[ ^ index > 1
						ifTrue: [ self valueForOption: (aSmaCCError dismissedTokens at: index - 1) value startingWith: '' ]
						ifFalse: [ self valueForOption: aSmaCCError stackContents last items last name value startingWith: '' ] ].
			index > 1
				ifTrue:
					[ (aSmaCCError dismissedTokens at: index - 1) value = '|'
						ifTrue:
							[ ^ self
								optionsFor: annotationType
								startingWith: token
								ignoring: (self previousOptionsFor: aSmaCCError) ].
					(aSmaCCError dismissedTokens at: index - 1) value = '='
						ifTrue:
							[ ^ index > 2
								ifTrue: [ self valueForOption: (aSmaCCError dismissedTokens at: index - 2) value startingWith: token ]
								ifFalse: [ self valueForOption: aSmaCCError stackContents last items last name value startingWith: token ] ] ].
			(('class' beginsWith: token)
				and: [ aSmaCCError stackContents notEmpty and: [ aSmaCCError stackContents last isKindOf: LeClassAnnotationNode ] ])
				ifTrue:
					[ ^ self composite
						addStream:
							{GtInsertTextCompletionAction
									labeled: (self strategy labelFor: 'class' withSearch: token)
									completion: ('class' allButFirst: token size)
									position: self position} asAsyncStream ] ].
	index = 0
		ifTrue:
			[ aSmaCCError stackContents isEmpty
				ifTrue:
					[ ^ aSmaCCError parent colon stopPosition = self position
						ifTrue:
							[ self
								optionsFor: annotationType
								startingWith: ''
								ignoring: #() ]
						ifFalse:
							[ aSmaCCError errorToken stopPosition = self position
								ifTrue:
									[ self
										optionsFor: annotationType
										startingWith: aSmaCCError errorToken value
										ignoring: #() ] ] ].
			(aSmaCCError stackContents last isKindOf: SmaCCToken)
				ifTrue:
					[ aSmaCCError stackContents last stopPosition = self position
						ifTrue:
							[ token := aSmaCCError stackContents last value.
							token = '>>'
								ifTrue:
									[ className := (aSmaCCError stackContents at: aSmaCCError stackContents size - 1) value.
									isMeta := className = 'class'.
									isMeta ifTrue: [ className := (aSmaCCError stackContents at: aSmaCCError stackContents size - 2) value ].
									Smalltalk at: className asSymbol ifPresent: [ :cls | class := isMeta ifTrue: [ cls class ] ifFalse: [ cls ] ].
									^ self
										selectorCompletionsFor: class
										startingWith: ''
										isExample: aSmaCCError parent name source = 'gtExample' ].
							(token = '=' and: [ (aSmaCCError stackContents at: aSmaCCError stackContents size - 1) value = 'name' ])
								ifTrue: [ ^ self classesStartingWith: '' ].
							token first isUppercase ifTrue: [ ^ self classesStartingWith: token ] ] ] ].
	^ self visitSmaCCParseNode: aSmaCCError
]
