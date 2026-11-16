Class {
	#name : #LeWordValueNode,
	#superclass : #LeWordArgumentNode,
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #generated }
LeWordValueNode >> acceptVisitor: aWordParseVisitor [
	^ aWordParseVisitor visitWordValue: self
]
