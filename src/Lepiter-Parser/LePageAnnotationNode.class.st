Class {
	#name : #LePageAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePageAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPageAnnotation: self
]

{ #category : #'api - accessing' }
LePageAnnotationNode >> dbUuidString [
	^ self dbNode ifNotNil: [ :node | node value source ]
]

{ #category : #testing }
LePageAnnotationNode >> isDefined [
	^ (self nameNode ifNil: [ self pageUidNode ]) 
		ifNil: [ false ] 
		ifNotNil: [ :node | node isDefined ]
]

{ #category : #'api - accessing' }
LePageAnnotationNode >> isLinkByName [
	"Answer a boolean indicating whether the receiver references the target page by name.
	Or by UID if false."

	^ self nameNode isNotNil
]

{ #category : #'api - accessing' }
LePageAnnotationNode >> linkLabel [
	^ self pageName ifEmpty: [ self labelNode
		ifNil: [ self linkUID ]
		ifNotNil: [ :node | node value source ] ]
]

{ #category : #'api - accessing' }
LePageAnnotationNode >> linkLabelInDatabase: aLeDatabase [

	self isLinkByName ifTrue: [ self pageName ].

	^ aLeDatabase 
		pageWithID: self pageUidString
		ifPresent: [ :thePage | thePage title ]
		ifAbsent: [ self linkUID ]

]

{ #category : #'api - accessing' }
LePageAnnotationNode >> linkUID [
	^ self nameNode
		ifNil: [ '' ]
		ifNotNil: [ :node | node value source ]
]

{ #category : #'api - accessing' }
LePageAnnotationNode >> pageName [
	^ self nameNode
		ifNil: [ '' ]
		ifNotNil: [ :node | node value source ]
]

{ #category : #accessing }
LePageAnnotationNode >> pageUidNode [

	^ items 
		detect: [ :node | node isId ] 
		ifNone: [ nil ]
]

{ #category : #'api - accessing' }
LePageAnnotationNode >> pageUidString [

	^ self pageUidNode ifNotNil:
		[ :node | node value source ]
]
