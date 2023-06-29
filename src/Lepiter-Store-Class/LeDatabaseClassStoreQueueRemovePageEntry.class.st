Class {
	#name : #LeDatabaseClassStoreQueueRemovePageEntry,
	#superclass : #LeDatabaseClassStoreQueueEntry,
	#instVars : [
		'pageSelector'
	],
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #actions }
LeDatabaseClassStoreQueueRemovePageEntry >> apply [
	"Apply the receiver's changes"

	monitor removePageSelectorNow: pageSelector
]

{ #category : #accessing }
LeDatabaseClassStoreQueueRemovePageEntry >> pageSelector [
	^ pageSelector
]

{ #category : #accessing }
LeDatabaseClassStoreQueueRemovePageEntry >> pageSelector: aSymbol [

	self assert: aSymbol isSymbol.
	pageSelector := aSymbol
]
