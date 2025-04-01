Class {
	#name : #LePictureParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #generated }
LePictureParseNode >> acceptVisitor: aPictureParseVisitor [
	^ aPictureParseVisitor visitPictureParse: self
]
