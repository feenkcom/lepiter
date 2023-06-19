"
I am announced by {{gtClass:LeDatabase}}, with the appropriate {{gtClass:LeDatabase}} and {{gtClass:LePage}}, when a {{gtClass:LePage}} change its name.

"
Class {
	#name : #LeDatabaseResorted,
	#superclass : #LeDatabaseAnnouncement,
	#instVars : [
		'page',
		'isChangedToNormalPage',
		'isChangedToDailyNote'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #'api - accessing' }
LeDatabaseResorted >> isChangedToDailyNote [
	^ isChangedToDailyNote
]

{ #category : #'api - accessing' }
LeDatabaseResorted >> isChangedToDailyNote: anObject [
	isChangedToDailyNote := anObject
]

{ #category : #'api - accessing' }
LeDatabaseResorted >> isChangedToNormalPage [
	^ isChangedToNormalPage
]

{ #category : #'api - accessing' }
LeDatabaseResorted >> isChangedToNormalPage: anObject [
	isChangedToNormalPage := anObject
]

{ #category : #'api - accessing' }
LeDatabaseResorted >> page [
	^ page
]

{ #category : #'api - accessing' }
LeDatabaseResorted >> page: anObject [
	page := anObject
]
