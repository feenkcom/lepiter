Trait {
	#name : #TLeExtensibleContentNodeVisitor,
	#classInstVars : [
		'componentVisitorClasses'
	],
	#category : #'Lepiter-Core-Visitor'
}

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> addComponentVisitorClass: aClass [
	self componentVisitorClasses addIfNotPresent: aClass

]

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> componentVisitorClasses [
	^ componentVisitorClasses
		ifNil: [ componentVisitorClasses := OrderedCollection withAll: self defaultComponentVisitorClasses ]
]

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> defaultComponentVisitorClasses [
	^ #()
]

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> new [
	^ super new
		initializeComponentVisitors;
		yourself
]

{ #category : #accessing }
TLeExtensibleContentNodeVisitor classSide >> removeComponentVisitorClass: aClass [
	self componentVisitorClasses remove: aClass ifAbsent: [  ]
]

{ #category : #'visiting - annotations' }
TLeExtensibleContentNodeVisitor >> annotationVisitorFor: anAnnotationNode default: aDefaultVisitor [
	"Answer a visitor for anAnnotationNode, an annotation node created by one of the annotation parsers
	(see LeParser class>>#annotationParsers): a registered component visitor that supports it
	(see #componentVisitorClasses), otherwise aDefaultVisitor if it supports it, otherwise nil."

	(self componentAnnotationVisitorFor: anAnnotationNode)
		ifNotNil: [ :aVisitor | ^ aVisitor ].

	^ (self doesAnnotationVisitor: aDefaultVisitor support: anAnnotationNode)
		ifTrue: [ aDefaultVisitor ]
		ifFalse: [ nil ]

]

{ #category : #'visiting - annotations' }
TLeExtensibleContentNodeVisitor >> componentAnnotationVisitorFor: anAnnotationNode [
	"Answer a registered component visitor (see #componentVisitorClasses) that supports anAnnotationNode, or nil"

	^ (self lookupVisitorFor: anAnnotationNode)
		ifNotNil: [ :aVisitor | 
			aVisitor == self
				ifTrue: [ nil ]
				ifFalse: [ aVisitor ] ]

]

{ #category : #'visiting - annotations' }
TLeExtensibleContentNodeVisitor >> doesAnnotationVisitor: aVisitor support: anAnnotationNode [
	"Answer true if aVisitor can visit anAnnotationNode: aVisitor uses the node's visitor trait,
	or it understands every visit message the node sends in its #acceptVisitor: method
	(for example implemented as extension methods)."

	| theSelectors |
	(aVisitor class allTraits includes: anAnnotationNode visitorTrait)
		ifTrue: [ ^ true ].

	theSelectors := self visitSelectorsOfNode: anAnnotationNode.
	^ theSelectors notEmpty
		and: [ theSelectors allSatisfy: [ :eachSelector | aVisitor respondsTo: eachSelector ] ]

]

{ #category : #initialization }
TLeExtensibleContentNodeVisitor >> initializeComponentVisitors [
	self class componentVisitorClasses
		do: [ :each | self addVisitor: each new ]
]

{ #category : #'visiting - annotations' }
TLeExtensibleContentNodeVisitor >> visitSelectorsOfNode: aSmaCCParseNode [
	"Answer the visit messages aSmaCCParseNode sends to a visitor in its #acceptVisitor: method"

	| aMethod |
	aMethod := aSmaCCParseNode class lookupSelector: #acceptVisitor:.
	aMethod ifNil: [ ^ #() ].

	^ aMethod messages select: [ :eachSelector | eachSelector beginsWith: 'visit' ]

]
