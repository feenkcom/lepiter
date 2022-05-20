Class {
	#name : #LeAnnotationNode,
	#superclass : #LeAnnotationParseNode,
	#instVars : [
		'separators',
		'items'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitAnnotation: self
]

{ #category : #generated }
LeAnnotationNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #generated }
LeAnnotationNode >> compositeTokenVariables [
	^ #(#separators)
]

{ #category : #accessing }
LeAnnotationNode >> dbNode [
	^ self items detect: [ :each | each isDb ] ifNone: [  ]
]

{ #category : #testing }
LeAnnotationNode >> doesReferenceExist [
	^ self nameNode 
		ifNil: [ false ]
		ifNotNil: [ :aNameNode |
			aNameNode doesReferenceExist ]
]

{ #category : #accessing }
LeAnnotationNode >> expanded [
	items
		do: [ :each | 
			each isExpanded
				ifTrue: [ ^ each booleanValue ] ].
	^ self expandedDefault
]

{ #category : #testing }
LeAnnotationNode >> expandedDefault [
	^ false
]

{ #category : #testing }
LeAnnotationNode >> hasLabel [
	^ self labelNode notNil
]

{ #category : #accessing }
LeAnnotationNode >> height [
	^ self heightNode ifNotNil: [ :node | node integerValue ]
]

{ #category : #accessing }
LeAnnotationNode >> heightNode [
	^ self items detect: [ :each | each isHeight ] ifNone: [  ]
]

{ #category : #accessing }
LeAnnotationNode >> idNode [
	^ self items detect: [ :each | each isId ] ifNone: [  ]
]

{ #category : #accessing }
LeAnnotationNode >> imageObject [
	^ self nameNode ifNotNil: [ :node | node imageObject ]
]

{ #category : #'generated-initialize-release' }
LeAnnotationNode >> initialize [
	super initialize.
	separators := OrderedCollection new: 2.
	items := OrderedCollection new: 2.
]

{ #category : #testing }
LeAnnotationNode >> isDefined [
	^ self nameNode ifNil: [ false ] ifNotNil: [ :node | node isDefined ]
]

{ #category : #accessing }
LeAnnotationNode >> isExpanded [
	^ self attributeNamed: #isExpanded ifAbsent: [ self expanded ]
]

{ #category : #accessing }
LeAnnotationNode >> isExpanded: aBoolean [
	^ self attributeNamed: #isExpanded put: aBoolean
]

{ #category : #generated }
LeAnnotationNode >> items [
	^ items
]

{ #category : #generated }
LeAnnotationNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #accessing }
LeAnnotationNode >> label [
	^ self labelNode ifNotNil: [ :node | node stringValue ]
]

{ #category : #accessing }
LeAnnotationNode >> labelNode [
	^ items 
		detect: [ :node | node isLabel ] 
		ifNone: [ nil ]
]

{ #category : #accessing }
LeAnnotationNode >> nameNode [
	^ self items detect: [ :each | each isName ] ifNone: [  ]
]

{ #category : #accessing }
LeAnnotationNode >> previewExpandedNode [
	^ items detect: [ :each | each isPreviewExpanded ] ifNone: [ nil ]
]

{ #category : #generated }
LeAnnotationNode >> separators [
	^ separators
]

{ #category : #generated }
LeAnnotationNode >> separators: anOrderedCollection [
	separators := anOrderedCollection
]

{ #category : #accessing }
LeAnnotationNode >> showNode [
	^ self items detect: [ :each | each isShow ] ifNone: [  ]
]

{ #category : #accessing }
LeAnnotationNode >> showSelector [
	^ self showNode ifNotNil: [ :node | node selectorValue ]
]
