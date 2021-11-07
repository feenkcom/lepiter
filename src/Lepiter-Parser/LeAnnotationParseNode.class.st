Class {
	#name : #LeAnnotationParseNode,
	#superclass : #SmaCCParseNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeAnnotationParseNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitAnnotationParse: self
]
