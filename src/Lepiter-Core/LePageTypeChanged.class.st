Class {
	#name : #LePageTypeChanged,
	#superclass : #LePageAnnouncement,
	#instVars : [
		'oldType',
		'newType',
		'newDatabaseKey',
		'oldDatabaseKey'
	],
	#category : #'Lepiter-Core-Announcements'
}

{ #category : #'api - testing' }
LePageTypeChanged >> isChangedToDailyNote [
	^ self wasDailyNote not and: [ self isDailyNote ]
]

{ #category : #'api - testing' }
LePageTypeChanged >> isChangedToNormalPage [
	^ self wasDailyNote and: [ self isDailyNote not ]
]

{ #category : #'api - testing' }
LePageTypeChanged >> isDailyNote [
	^ self newType isDailyNote
]

{ #category : #accessing }
LePageTypeChanged >> newDatabaseKey [
	^ newDatabaseKey
]

{ #category : #accessing }
LePageTypeChanged >> newDatabaseKey: anObject [
	newDatabaseKey := anObject
]

{ #category : #accessing }
LePageTypeChanged >> newType [
	^ newType
]

{ #category : #accessing }
LePageTypeChanged >> newType: anObject [
	newType := anObject
]

{ #category : #accessing }
LePageTypeChanged >> oldDatabaseKey [
	^ oldDatabaseKey
]

{ #category : #accessing }
LePageTypeChanged >> oldDatabaseKey: anObject [
	oldDatabaseKey := anObject
]

{ #category : #accessing }
LePageTypeChanged >> oldType [
	^ oldType
]

{ #category : #accessing }
LePageTypeChanged >> oldType: anObject [
	oldType := anObject
]

{ #category : #'api - testing' }
LePageTypeChanged >> wasDailyNote [
	^ self oldType isDailyNote
]

{ #category : #'api - testing' }
LePageTypeChanged >> wasUnnamedPage [
	^ self oldType isUnnamedPageType
]
