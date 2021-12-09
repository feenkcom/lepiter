Class {
	#name : #LeWordHeightNode,
	#superclass : #LeWordArgumentNode,
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #generated }
LeWordHeightNode >> acceptVisitor: aWordParseVisitor [
	^ aWordParseVisitor visitWordHeight: self
]
