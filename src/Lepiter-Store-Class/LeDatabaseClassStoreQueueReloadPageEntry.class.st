Class {
	#name : #LeDatabaseClassStoreQueueReloadPageEntry,
	#superclass : #LeDatabaseClassStoreQueueEntry,
	#instVars : [
		'pageSelector'
	],
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #actions }
LeDatabaseClassStoreQueueReloadPageEntry >> apply [
	"Apply the receiver's changes"

	LeDatabaseClassStoreReloadPageId
		value: pageSelector
		during: [ monitor reloadPageSelectorNow: pageSelector ]
]

{ #category : #accessing }
LeDatabaseClassStoreQueueReloadPageEntry >> pageSelector [
	^ pageSelector
]

{ #category : #accessing }
LeDatabaseClassStoreQueueReloadPageEntry >> pageSelector: anObject [
	pageSelector := anObject
]
