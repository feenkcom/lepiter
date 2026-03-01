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

{ #category : #accessing }
LePragmaAnnotationCompletionVisitor >> composite [
	^ composite
]

{ #category : #accessing }
LePragmaAnnotationCompletionVisitor >> composite: aCompositeVisitor [
	composite := aCompositeVisitor
]

{ #category : #accessing }
LePragmaAnnotationCompletionVisitor >> position [
	^ self composite position
]

{ #category : #accessing }
LePragmaAnnotationCompletionVisitor >> pragmaCandidates [
	| candidates |
	candidates := GtPrefixTree new.
	GtPragmaType all
		do: [ :each | each keyword ifNotNil: [ :keyword | candidates add: keyword asString ] ].
	^ candidates
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> visitPragmaAnnotation: aPragmaAnnotation [
	| parent candidates prefix |
	parent := aPragmaAnnotation parent.
	(aPragmaAnnotation pragmaNameNode isNil
		and: [ parent notNil
		and: [ parent respondsTo: #colon ]
		and: [ self position >= parent colon stopPosition ] ])
		ifTrue: [
			candidates := self pragmaCandidates.
			prefix := ''.
			candidates notEmpty ifTrue: [ ^ self addStreamFor: candidates startingWith: prefix ] ].
	^ self visitPragmaParse: aPragmaAnnotation
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> visitPragmaArgument: aPragmaArgument [
	^ self visitPragmaParse: aPragmaArgument
]

{ #category : #visiting }
LePragmaAnnotationCompletionVisitor >> visitPragmaName: aPragmaName [
	(aPragmaName value stopPosition = self position
		and: [ aPragmaName parent pragmaNameNode = aPragmaName ])
		ifTrue: [ | candidates |
			candidates := self pragmaCandidates.
			candidates notEmpty ifTrue: [ ^ self addStreamFor: candidates startingWith: aPragmaName value source ] ].
	^ self visitPragmaArgument: aPragmaName
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
