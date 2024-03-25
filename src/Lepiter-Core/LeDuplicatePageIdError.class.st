Class {
	#name : #LeDuplicatePageIdError,
	#superclass : #Error,
	#instVars : [
		'page',
		'file',
		'pageInDB'
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

{ #category : #accessing }
LeDuplicatePageIdError >> gtDetailsFor: aView [
	<gtView>
	<gtExceptionDebuggingView>
	^ aView columnedList 
		title: 'Details';
		items: {
			'Page already in DB' -> pageInDB . 
			'Page to add' -> page };
		column: 'Page' text: #key;
		column: 'Title' text: [:each | each value title];
		column: 'Uid' text: [:each | each value uidString ]
]

{ #category : #private }
LeDuplicatePageIdError >> isResumable [
	"Determine whether an exception is resumable."

	^ true
]

{ #category : #accessing }
LeDuplicatePageIdError >> messageText [
	^ messageText ifNil: [ 
		messageText := self standardMessageText ]
]

{ #category : #accessing }
LeDuplicatePageIdError >> page [
	^ page
]

{ #category : #accessing }
LeDuplicatePageIdError >> page: anObject [
	page := anObject
]

{ #category : #'private - adding / removing' }
LeDuplicatePageIdError >> pageInDB: aPage [ 
	pageInDB := aPage
]

{ #category : #'private - adding / removing' }
LeDuplicatePageIdError >> pageToAdd: aLePage [ 
	page := aLePage
]

{ #category : #accessing }
LeDuplicatePageIdError >> standardMessageText [
	^ self page
		ifNil: [ 'DuplicatePageIdError for unknown page.' ]
		ifNotNil: [ :aPage | 
			'Page "{1}" has the same uid {2} as the existing "{3}".'
				format: {page gtDisplayString.
						page uidString.
						pageInDB gtDisplayString} ]
]
