Class {
	#name : #LeMethodAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeMethodAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitMethodAnnotation: self
]

{ #category : #testing }
LeMethodAnnotationNode >> doesReferenceExist [
	^ self nameNode 
		ifNil: [ false ]
		ifNotNil: [ :aNameNode |
			aNameNode doesReferenceExist ]
]
