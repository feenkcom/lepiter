Class {
	#name : #LePictureReferenceNode,
	#superclass : #LePictureArgumentNode,
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #generated }
LePictureReferenceNode >> acceptVisitor: aPictureParseVisitor [
	^ aPictureParseVisitor visitPictureReference: self
]
