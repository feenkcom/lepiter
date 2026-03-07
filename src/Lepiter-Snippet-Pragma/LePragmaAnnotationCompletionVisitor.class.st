"
Completion visitor for gtPragma annotations.
"
Class {
	#name : #LePragmaAnnotationCompletionVisitor,
	#superclass : #Object,
	#traits : 'TLePragmaParseNodeVisitor',
	#classTraits : 'TLePragmaParseNodeVisitor classTrait',
	#instVars : [
		'composite'
	],
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #initialization }
LePragmaAnnotationCompletionVisitor class >> initialize [
	LeContentCompletionVisitor additionalCompletionVisitors add: self
]

{ #category : #initialization }
LePragmaAnnotationCompletionVisitor class >> obsolete [
	LeContentCompletionVisitor additionalCompletionVisitors remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> acceptNode: aSmaCCParseNode [
	aSmaCCParseNode isNil ifTrue: [ ^ nil ].
	^ composite notNil
		ifTrue: [ composite acceptNode: aSmaCCParseNode ]
		ifFalse: [ aSmaCCParseNode acceptVisitor: self ]
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> acceptNodes: aCollection [
	aCollection do: [ :each | self acceptNode: each ]
]

{ #category : #private }
LePragmaAnnotationCompletionVisitor >> addStreamFor: candidates startingWith: prefix [
	^ self composite
		addStream: ((candidates asyncStreamStartingWith: prefix)
			collect: [ :each |
				GtInsertTextCompletionAction
					labeled: (self composite strategy labelFor: each withSearch: prefix)
					completion: (each allButFirst: prefix size)
					position: self position ])
]

{ #category : #private }
LePragmaAnnotationCompletionVisitor >> booleanValueCompletionFor: aPragmaArgument [
	| prefix words |
	prefix := self pragmaPrefixFor: (aPragmaArgument value ifNil: [ aPragmaArgument equals ]).
	words := GtPrefixTree new.
	words add: 'true'.
	words add: 'false'.
	^ self addStreamFor: words startingWith: prefix
]

{ #category : #private }
LePragmaAnnotationCompletionVisitor >> completionAtArgumentValue: aPragmaArgument [
	| token |
	token := aPragmaArgument value.
	token ifNotNil: [ ^ self isPosition: self position insideToken: token ].
	^ aPragmaArgument equals
		ifNil: [ false ]
		ifNotNil: [ self position >= aPragmaArgument equals stopPosition ]
]

{ #category : #testing }
LePragmaAnnotationCompletionVisitor >> completionAtPragmaName: aPragmaName [
	| token |
	token := aPragmaName value.
	token ifNil: [ ^ false ].
	^ self isPosition: self position insideToken: token
]

{ #category : #accessing }
LePragmaAnnotationCompletionVisitor >> composite [
	^ composite
]

{ #category : #accessing }
LePragmaAnnotationCompletionVisitor >> composite: aCompositeVisitor [
	composite := aCompositeVisitor
]

{ #category : #testing }
LePragmaAnnotationCompletionVisitor >> isCompletionAtAnnotationStart [
	| source prefix start next pos |
	source := self composite text asString.
	prefix := 'gtPragma:'.
	start := 0.
	next := source findString: prefix startingAt: 1.
	[ next > 0 ] whileTrue: [
		start := next.
		next := source findString: prefix startingAt: next + 1 ].
	start = 0 ifTrue: [ ^ false ].
	pos := self position.
	^ (pos >= (start + prefix size - 1)) and: [ pos <= (start + prefix size) ]
]

{ #category : #testing }
LePragmaAnnotationCompletionVisitor >> isPosition: aPosition insideToken: aToken [
	^ aPosition >= aToken startPosition
		and: [ aPosition <= (aToken stopPosition + 1) ]
]

{ #category : #accessing }
LePragmaAnnotationCompletionVisitor >> position [
	^ self composite position
]

{ #category : #private }
LePragmaAnnotationCompletionVisitor >> pragmaAttributesFor: aPragmaAnnotation [
	| words |
	words := GtPrefixTree new.
	aPragmaAnnotation hasExpandedSpecified ifFalse: [ words add: 'expanded' ].
	^ words
]

{ #category : #accessing }
LePragmaAnnotationCompletionVisitor >> pragmaCandidates [
	| candidates |
	candidates := GtPrefixTree new.
	GtPragmaType all
		do: [ :each | each keyword ifNotNil: [ :keyword | candidates add: keyword asString ] ].
	^ candidates
]

{ #category : #private }
LePragmaAnnotationCompletionVisitor >> pragmaPrefixFor: aToken [
	| source start stop |
	source := self composite text asString.
	start := aToken startPosition.
	stop := self position min: aToken stopPosition.
	stop < start ifTrue: [ ^ '' ].
	^ source copyFrom: start to: stop
]

{ #category : #accessing }
LePragmaAnnotationCompletionVisitor >> text [
	^ self composite text
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> visitPragmaAnnotation: aPragmaAnnotation [
	| parent candidates prefix |
	parent := aPragmaAnnotation parent.
	(aPragmaAnnotation pragmaNameNode isNil
		and: [ parent notNil
				and: [ (parent respondsTo: #colon)
						and: [ self position >= parent colon stopPosition ] ] ])
		ifTrue: [ candidates := self pragmaCandidates.
			prefix := ''.
			candidates notEmpty
				ifTrue: [ ^ self addStreamFor: candidates startingWith: prefix ] ].
	(aPragmaAnnotation bars notEmpty
		and: [ aPragmaAnnotation bars last stopPosition = self position ])
		ifTrue: [
			candidates := self pragmaAttributesFor: aPragmaAnnotation.
			candidates notEmpty ifTrue: [ ^ self addStreamFor: candidates startingWith: '' ] ].
	^ self visitPragmaParse: aPragmaAnnotation
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> visitPragmaArgument: aPragmaArgument [
	^ self visitPragmaParse: aPragmaArgument
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> visitPragmaExpanded: aPragmaExpanded [
	| valueToken prefix words source start stop |
	valueToken := aPragmaExpanded value.
	valueToken ifNotNil: [
		(self isPosition: self position insideToken: valueToken)
			ifFalse: [ ^ self visitPragmaArgument: aPragmaExpanded ].
		prefix := self pragmaPrefixFor: valueToken.
		words := GtPrefixTree new.
		words add: 'true'.
		words add: 'false'.
		^ self addStreamFor: words startingWith: prefix ].
	
	aPragmaExpanded equals ifNil: [ ^ self visitPragmaArgument: aPragmaExpanded ].
	(self position < aPragmaExpanded equals stopPosition)
		ifTrue: [ ^ self visitPragmaArgument: aPragmaExpanded ].
	start := aPragmaExpanded equals stopPosition + 1.
	source := self composite text asString.
	stop := self position min: source size.
	prefix := stop < start
		ifTrue: [ '' ]
		ifFalse: [ source copyFrom: start to: stop ].
	words := GtPrefixTree new.
	words add: 'true'.
	words add: 'false'.
	^ self addStreamFor: words startingWith: prefix
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> visitPragmaName: aPragmaName [
	| arg prefix candidates |
	(self completionAtPragmaName: aPragmaName)
		ifTrue: [
			prefix := aPragmaName value ifNil: [ '' ] ifNotNil: [ :token | token value ].
			candidates := self pragmaCandidates.
			candidates notEmpty ifTrue: [ ^ self addStreamFor: candidates startingWith: prefix ] ].
	arg := aPragmaName parent.
	(arg isKindOf: LePragmaArgumentNode)
		ifTrue: [
			((arg nameString ifNil: [ '' ]) sameAs: 'expanded')
				ifTrue: [
					(self completionAtArgumentValue: arg)
						ifTrue: [ ^ self booleanValueCompletionFor: arg ] ] ].
	^ TLePragmaParseNodeVisitor >> #visitPragmaName:
		valueWithReceiver: self
		arguments: { aPragmaName }
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> visitSmaCCError: aSmaCCError [
	| parent prefix candidates |
	parent := aSmaCCError parent.
	((parent isKindOf: LeDocumenterAnnotationNode)
		and: [ parent name source = 'gtPragma'
		and: [ self position >= parent colon stopPosition ] ])
		ifTrue: [
			prefix := aSmaCCError errorToken ifNotNil: [ :token | token value ] ifNil: [ '' ].
			candidates := self pragmaCandidates.
			candidates notEmpty ifTrue: [ ^ self addStreamFor: candidates startingWith: prefix ] ].
	^ self visitSmaCCParseNode: aSmaCCError
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> visitSmaCCParseNode: aSmaCCParseNode [
	self acceptNodes: aSmaCCParseNode sortedChildren.
	^ aSmaCCParseNode
]
