Class {
	#name : #LePageTitleChanged,
	#superclass : #LePageAnnouncement,
	#instVars : [
		'oldTitle',
		'newTitle',
		'oldType',
		'newType',
		'oldDatabaseKey',
		'newDatabaseKey'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #'api - testing' }
LePageTitleChanged >> isChangedToDailyNote [
	^ self wasDailyNote not and: [ self isDailyNote ]
]

{ #category : #'api - testing' }
LePageTitleChanged >> isChangedToNormalPage [
	^ self wasDailyNote and: [ self isDailyNote not ]
]

{ #category : #'api - testing' }
LePageTitleChanged >> isDailyNote [
	^ self newType isDailyNote
]

{ #category : #accessing }
LePageTitleChanged >> newDatabaseKey [
	^ newDatabaseKey
]

{ #category : #accessing }
LePageTitleChanged >> newDatabaseKey: anObject [
	newDatabaseKey := anObject
]

{ #category : #'api - accessing' }
LePageTitleChanged >> newTitle [
	^ newTitle
]

{ #category : #'api - accessing' }
LePageTitleChanged >> newTitle: anObject [
	newTitle := anObject
]

{ #category : #accessing }
LePageTitleChanged >> newType [
	^ newType
]

{ #category : #accessing }
LePageTitleChanged >> newType: aPageType [
	newType := aPageType
]

{ #category : #accessing }
LePageTitleChanged >> oldDatabaseKey [
	^ oldDatabaseKey
]

{ #category : #accessing }
LePageTitleChanged >> oldDatabaseKey: anObject [
	oldDatabaseKey := anObject
]

{ #category : #'api - accessing' }
LePageTitleChanged >> oldTitle [
	^ oldTitle
]

{ #category : #'api - accessing' }
LePageTitleChanged >> oldTitle: anObject [
	oldTitle := anObject
]

{ #category : #accessing }
LePageTitleChanged >> oldType [
	^ oldType
]

{ #category : #accessing }
LePageTitleChanged >> oldType: aPageType [
	oldType := aPageType
]

{ #category : #'api - accessing' }
LePageTitleChanged >> title [
	^ self newTitle
]

{ #category : #'api - testing' }
LePageTitleChanged >> wasDailyNote [
	^ self oldType isDailyNote
]

{ #category : #'api - testing' }
LePageTitleChanged >> wasUnnamedPage [
	^ self oldType isUnnamedPageType
]
