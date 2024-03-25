Class {
	#name : #LeDuplicatePageIdError,
	#superclass : #Error,
	#instVars : [
		'page',
		'file',
		'pageInDB',
		'database'
	],
	#category : #'Lepiter-Core-Exceptions'
}

{ #category : #'private - adding / removing' }
LeDuplicatePageIdError >> database: aDatabase [ 
	database := aDatabase
]

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
		priority: 0;
		items: {
			'Page already in DB' -> pageInDB . 
			'Page to add' -> page };
		column: 'Page' text: #key;
		column: 'Title' text: [:each | each value title];
		column: 'Uid' text: [:each | each value uidString ];
		column: 'DB key' text: [:each | each value databaseKey ];
		column: 'On disk' text: [:each | (database monitor pageFileReference: each value) exists ];
		contextItemLabel: 'Inspect database key' action: [:anElement :each | anElement phlow spawnObject: each value databaseKey ];
		contextItemLabel: 'Inspect file' action: [:anElement :each | anElement phlow spawnObject: (database monitor pageFileReference: each value) ];
		send: #value
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
			'Page "{1}" with id {2} has the same databaseKey {3} as the existing "{4}" with id {5}.'
				format: {page gtDisplayString.
						page uidString.
						page databaseKey.
						pageInDB gtDisplayString.
						pageInDB uidString} ]
]
