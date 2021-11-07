Class {
	#name : #LePageAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LePageAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPageAnnotation: self
]

{ #category : #'api - accessing' }
LePageAnnotationNode >> dbUuidString [

	items size < 2 ifTrue: [ ^ nil ].
	^ items second value value
]

{ #category : #'api - accessing' }
LePageAnnotationNode >> linkUID [

	^ items first value value
]

{ #category : #accessing }
LePageAnnotationNode >> nameNode [

	^ items first
]
