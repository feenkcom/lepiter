"
I am {{gtClass: LeLinkReferenceStatus}}.
My meaning is that an object referenced by {{gtClass: LeLinkReference}}  exists.
"
Class {
	#name : #LeLinkReferenceExistsStatus,
	#superclass : #LeLinkReferenceStatus,
	#category : #'Lepiter-Core-Links'
}

{ #category : #accessing }
LeLinkReferenceExistsStatus >> color [
	^ BrGlamorousColors successBackgroundColor
]

{ #category : #accessing }
LeLinkReferenceExistsStatus >> label [
	^ 'exists'
]
