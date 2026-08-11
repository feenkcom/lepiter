Class {
	#name : #LeObjectReferenceAnnotationNode,
	#superclass : #LeObjectReferenceParseNode,
	#instVars : [
		'items',
		'bars'
	],
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #visiting }
LeObjectReferenceAnnotationNode >> acceptVisitor: anObjectReferenceParseVisitor [
	^anObjectReferenceParseVisitor visitObjectReferenceAnnotation: self
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> bars [
	^bars
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> bars: anOrderedCollection [
	bars := anOrderedCollection
]

{ #category : #generated }
LeObjectReferenceAnnotationNode >> compositeNodeVariables [
	^#(#items)
]

{ #category : #generated }
LeObjectReferenceAnnotationNode >> compositeTokenVariables [
	^#(#bars)
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> expandedArgument [
	^items detect: [:each | each isKindOf: LeObjectReferenceExpandedNode] ifNone: []
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> expandedValue [
	| arg |
	arg := self expandedArgument.
	arg ifNil: [^nil].
	arg value ifNil: [^true].
	^arg value source sameAs: 'true'
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> fallbackLabel [
	^self fallbackLabelNode ifNotNil: [:node | node value source]
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> fallbackLabelNode [
	^items detect: [:each | each isKindOf: LeObjectReferenceFallbackLabelNode]
		ifNone: []
]

{ #category : #testing }
LeObjectReferenceAnnotationNode >> hasExpandedSpecified [
	^self expandedArgument notNil
]

{ #category : #testing }
LeObjectReferenceAnnotationNode >> hasFallbackLabelSpecified [
	^self fallbackLabelNode notNil
]

{ #category : #testing }
LeObjectReferenceAnnotationNode >> hasHeightSpecified [
	^self heightNode notNil
]

{ #category : #testing }
LeObjectReferenceAnnotationNode >> hasLabelSpecified [
	^self labelNode notNil
]

{ #category : #testing }
LeObjectReferenceAnnotationNode >> hasShowSpecified [
	^self showNode notNil
]

{ #category : #testing }
LeObjectReferenceAnnotationNode >> hasUuidSpecified [
	^self uuidNode notNil
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> heightNode [
	^items detect: [:each | each isKindOf: LeObjectReferenceHeightNode]
		ifNone: []
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> heightValue [
	^self heightNode ifNotNil: [:node | node value source asInteger]
]

{ #category : #'generated-initialize-release' }
LeObjectReferenceAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #testing }
LeObjectReferenceAnnotationNode >> isDefined [
	^self hasUuidSpecified
]

{ #category : #generated }
LeObjectReferenceAnnotationNode >> items [
	^items
]

{ #category : #generated }
LeObjectReferenceAnnotationNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> labelNode [
	^items detect: [:each | each isKindOf: LeObjectReferenceLabelNode] ifNone: []
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> labelSelector [
	^self labelNode ifNotNil: [:node | node value source]
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> showNode [
	^items detect: [:each | each isKindOf: LeObjectReferenceShowNode]
		ifNone: []
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> showSelector [
	^self showNode ifNotNil: [ :node | node selectorValue ]
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> uuid [
	^self uuidNode ifNotNil: [:node | node value source]
]

{ #category : #accessing }
LeObjectReferenceAnnotationNode >> uuidNode [
	^items detect: [:each | each isKindOf: LeObjectReferenceIdNode] ifNone: []
]
