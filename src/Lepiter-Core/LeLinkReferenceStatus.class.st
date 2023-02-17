Class {
	#name : #LeLinkReferenceStatus,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Core-Links'
}

{ #category : #'api - factory' }
LeLinkReferenceStatus class >> exists [
	^ LeLinkReferenceExistsStatus default
]

{ #category : #'api - factory' }
LeLinkReferenceStatus class >> indecisive [
	^ LeLinkReferenceIndecisiveStatus default
]

{ #category : #'api - factory' }
LeLinkReferenceStatus class >> notFound [
	^ LeLinkReferenceNotFoundStatus default
]

{ #category : #accessing }
LeLinkReferenceStatus >> color [
	^ BrGlamorousColors disabledButtonTextColor
]

{ #category : #accessing }
LeLinkReferenceStatus >> label [
	^ 'label'
]
