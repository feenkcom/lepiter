Class {
	#name : #LeFileNameArgumentNode,
	#superclass : #LeNameArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeFileNameArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitFileNameArgument: self
]

{ #category : #accessing }
LeFileNameArgumentNode >> changes [
	^ self attributeNamed: #changes
]

{ #category : #accessing }
LeFileNameArgumentNode >> changes: aGtEpicea [
	self attributeNamed: #changes put: aGtEpicea
]

{ #category : #accessing }
LeFileNameArgumentNode >> imageObject [
	^ self changes
]
