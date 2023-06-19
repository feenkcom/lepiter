Class {
	#name : #LeDuplicatePageIdError,
	#superclass : #Error,
	#instVars : [
		'page',
		'file'
	],
	#category : #'Lepiter-Core-Exceptions'
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
LeDuplicatePageIdError >> messageText [

	^ messageText 
		ifNil: [ self page
			ifNil: [ 'DuplicatePageIdError for unknown page.']
			ifNotNil: [ :aPage |
				'DuplicatePageIdError for page "{1}" with uid {2}' 
					format: {
						page gtDisplayString.
						page uidString} ] ]
]

{ #category : #accessing }
LeDuplicatePageIdError >> page [
	^ page
]

{ #category : #accessing }
LeDuplicatePageIdError >> page: anObject [
	page := anObject
]
