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

{ #category : #'api - accessing' }
LePageAnnotationNode >> linkLabel [
	^ self labelNode
		ifNil: [ self linkUID ]
		ifNotNil: [ :node | node value source ]
]

{ #category : #'api - accessing' }
LePageAnnotationNode >> linkUID [
	^ (self nameNode ifNil: [ self dbNode ])
		ifNil: [ '' ]
		ifNotNil: [ :node | node value source ]
]
