Class {
	#name : #LeDuplicatePageIdError,
	#superclass : #Error,
	#instVars : [
		'page',
		'file'
	],
	#category : 'Lepiter-Core-Exceptions'
}

{ #category : #accessing }
LeDuplicatePageIdError >> file [
	^ file
]

{ #category : #accessing }
LeDuplicatePageIdError >> file: anObject [
	file := anObject
]

{ #category : #private }
LeDuplicatePageIdError >> isResumable [
	"Determine whether an exception is resumable."

	^ true
]

{ #category : #accessing }
LeDuplicatePageIdError >> page [
	^ page
]

{ #category : #accessing }
LeDuplicatePageIdError >> page: anObject [
	page := anObject
]
