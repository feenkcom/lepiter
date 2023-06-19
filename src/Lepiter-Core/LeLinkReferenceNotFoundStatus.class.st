"
I am {{gtClass: LeLinkReferenceStatus}}.
My meaning is that an object referenced by {{gtClass: LeLinkReference}}  is not available (not found).
"
Class {
	#name : #LeLinkReferenceNotFoundStatus,
	#superclass : #LeLinkReferenceStatus,
	#category : #'Lepiter-Core-Links'
}

{ #category : #accessing }
LeLinkReferenceNotFoundStatus >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
LeLinkReferenceNotFoundStatus >> label [
	^ 'not found'
]
