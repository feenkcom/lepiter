"
I inform that ${method:LeDatabase>>#LeDatabase>>#tableOfContents|label=Table of Contents}$ ${class:LePage}$ has been changed.
"
Class {
	#name : #LeDatabaseTableOfContentsUUIDChanged,
	#superclass : #LeDatabaseAnnouncement,
	#instVars : [
		'oldId',
		'oldPage',
		'newId',
		'newPage'
	],
	#category : #'Lepiter-Core-Announcements'
}

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> newId [
	^ newId
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> newId: anObject [
	newId := anObject
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> newPage [
	^ newPage
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> newPage: anObject [
	newPage := anObject
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> newPageDo: aBlock [
	self newPage ifNotNil: aBlock
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> oldId [
	^ oldId
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> oldId: anObject [
	oldId := anObject
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> oldPage [
	^ oldPage
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> oldPage: anObject [
	oldPage := anObject
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsUUIDChanged >> oldPageDo: aBlock [
	self oldPage ifNotNil: aBlock
]
