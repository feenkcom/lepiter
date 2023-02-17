"
I am {{gtClass: LeLinkReferenceStatus}}.
My meaning is that an object referenced by {{gtClass: LeLinkReference}}  *may* exist.
"
Class {
	#name : #LeLinkReferenceIndecisiveStatus,
	#superclass : #LeLinkReferenceStatus,
	#category : #'Lepiter-Core-Links'
}

{ #category : #accessing }
LeLinkReferenceIndecisiveStatus >> color [
	^ BrGlamorousColors disabledButtonTextColor
]

{ #category : #accessing }
LeLinkReferenceIndecisiveStatus >> label [
	^ 'indecisive'
]
