Class {
	#name : #LeContentCompletionVisitor,
	#superclass : #LeContentNodeVisitor,
	#traits : 'TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'strategy',
		'text',
		'position',
		'actionBlock'
	],
	#classVars : [
		'AdditionalCompletionVisitors'
	],
	#category : 'Lepiter-UI-Snippet-Text completion'
}

{ #category : #accessing }
LeContentCompletionVisitor class >> additionalCompletionVisitors [
	^ AdditionalCompletionVisitors
		ifNil: [ AdditionalCompletionVisitors := self defaultCompletionVisitors ]
]

{ #category : #accessing }
LeContentCompletionVisitor class >> defaultCompletionVisitors [
	^ OrderedCollection with: LeAnnotationCompletionVisitor
]

{ #category : #accessing }
LeContentCompletionVisitor >> actionBlock: aBlock [
	actionBlock := aBlock
]

{ #category : #actions }
LeContentCompletionVisitor >> addAction: aCompletionAction [
	actionBlock value: aCompletionAction
]

{ #category : #private }
LeContentCompletionVisitor >> completeStartAnnotation: aNode startingWith: aString [
	| trailing source completions |
	completions := LeParser annotationParsers keys
		select: [ :each | aString isEmpty or: [ each beginsWith: aString ] ].
	completions isEmpty
		ifTrue: [ ^ self ].
	trailing := ':}}'.
	source := aNode completeSource.
	source size > self position
		ifTrue: [ (source at: self position + 1) = $}
				ifTrue: [ trailing := (source size > (self position + 1)
						and: [ (source at: self position + 2) = $} ])
						ifTrue: [ ':' ]
						ifFalse: [ ':}' ] ] ].
	completions asSortedCollection
		do: [ :each | 
			self
				addAction:
					(GtInsertTextAndPositionCursorCompletionAction
						labeled: each
						completion: (each allButFirst: aString size) , trailing
						position: self position
						from: self position
						newPosition: self position + each size - aString size + 1) ]
]

{ #category : #private }
LeContentCompletionVisitor >> hashCompletionActionsWithPrefix: prefix [
	^ (self strategy pageTitles first: 100 startingWith: prefix)
		collect: [ :each | 
			| linkName needsBrackets mainAction |
			needsBrackets := each anySatisfy: [ :c | c isSeparator ].
			linkName := needsBrackets
				ifTrue: [ (prefix isEmpty
						ifTrue: [ '[[' ]
						ifFalse: [ '' ]) , each , ']]' ]
				ifFalse: [ each ].
			mainAction := GtInsertTextCompletionAction
				labeled: linkName
				completion: (linkName allButFirst: prefix size)
				position: self position
				from: self position - prefix size.
			(needsBrackets and: [ prefix notEmpty ])
				ifTrue: [ mainAction := (GtCompositeCompletionAction labeled: '[[' , linkName)
						addAction: mainAction;
						addAction:
							(GtInsertTextCompletionAction
								labeled: '[['
								completion: '[['
								position: self position - prefix size
								from: self position - prefix size);
						yourself ].
			self addAction: mainAction ]
]

{ #category : #initialization }
LeContentCompletionVisitor >> initialize [
	super initialize.
	self class additionalCompletionVisitors
		do: [ :each | self addVisitor: each new ]
]

{ #category : #accessing }
LeContentCompletionVisitor >> position [
	^ position
]

{ #category : #accessing }
LeContentCompletionVisitor >> position: anInteger [
	position := anInteger
]

{ #category : #accessing }
LeContentCompletionVisitor >> strategy [
	^ strategy
]

{ #category : #accessing }
LeContentCompletionVisitor >> strategy: aCompletionStrategy [
	strategy := aCompletionStrategy
]

{ #category : #accessing }
LeContentCompletionVisitor >> text [
	^ text
]

{ #category : #accessing }
LeContentCompletionVisitor >> text: aText [
	text := aText
]

{ #category : #visiting }
LeContentCompletionVisitor >> visitEmptyHashLink: anEmptyHashLink [
	anEmptyHashLink stopPosition = self position
		ifTrue: [ self hashCompletionActionsWithPrefix: '' ].
	^ self visitEmptyLink: anEmptyHashLink
]

{ #category : #visiting }
LeContentCompletionVisitor >> visitShortHashLink: aShortHashLink [
	aShortHashLink stopPosition = self position
		ifTrue: [ self
				hashCompletionActionsWithPrefix: aShortHashLink link source allButFirst ].
	^ self visitHashLink: aShortHashLink
]

{ #category : #visiting }
LeContentCompletionVisitor >> visitSmaCCError: aSmaCCError [
	| token name |
	aSmaCCError stackContents notEmpty
		ifTrue: [ token := aSmaCCError stackContents last.
			((token isKindOf: SmaCCToken)
				and: [ token stopPosition = self position ])
				ifTrue: [ token value = '{{'
						ifTrue: [ self completeStartAnnotation: aSmaCCError startingWith: '' ].
					name := token value.
					(aSmaCCError stackContents size > 2
						and: [ token := aSmaCCError stackContents
								at: aSmaCCError stackContents size - 2.
							(token isKindOf: SmaCCToken) and: [ token value = '{{' ] ])
						ifTrue: [ self completeStartAnnotation: aSmaCCError startingWith: name ] ] ].
	^ super visitSmaCCError: aSmaCCError
]
