Class {
	#name : #LeWordExpandedNode,
	#superclass : #LeWordArgumentNode,
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #generated }
LeWordExpandedNode >> acceptVisitor: aWordParseVisitor [
	^ aWordParseVisitor visitWordExpanded: self
]
