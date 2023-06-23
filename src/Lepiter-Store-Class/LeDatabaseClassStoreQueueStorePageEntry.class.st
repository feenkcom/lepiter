Class {
	#name : #LeDatabaseClassStoreQueueStorePageEntry,
	#superclass : #LeDatabaseClassStoreQueueEntry,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #actions }
LeDatabaseClassStoreQueueStorePageEntry >> apply [
	"Apply the receiver's changes"

	monitor storage
		savePage: page
		inClass: monitor dbClass
]

{ #category : #accessing }
LeDatabaseClassStoreQueueStorePageEntry >> page [
	^ page
]

{ #category : #accessing }
LeDatabaseClassStoreQueueStorePageEntry >> page: aLePage [

	self assert: (aLePage isPage or: [ aLePage isExplicitLinks ]).
	page := aLePage.
]

{ #category : #accessing }
LeDatabaseClassStoreQueueStorePageEntry >> pageSelector [

	^ page database monitor storage pageSelectorFor: page
]
