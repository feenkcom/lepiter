Class {
	#name : #LePageIsReloadNecessaryChecker,
	#superclass : #Object,
	#instVars : [
		'existingPage',
		'loadedPage'
	],
	#category : #'Lepiter-Store-Reload - Optimizations'
}

{ #category : #checking }
LePageIsReloadNecessaryChecker >> check [
	"Return true if a given database needs to be reloaded, false otherwise.
	Notice that it currently checks only page files. There are other files
	that can change, e.g., external links, attachments, and db properties."

	<return: #Boolean>
	| anExistingHash aLoadedHash |
	self isReloadAlways ifTrue: [ ^ true ].
	
	anExistingHash := self existingPage storageHash ifNil: [ ^ true ].
	aLoadedHash := self loadedPage storageHash ifNil: [ ^ true ].

	^ (anExistingHash = aLoadedHash) not
]

{ #category : #accessing }
LePageIsReloadNecessaryChecker >> existingPage [
	^ existingPage
]

{ #category : #accessing }
LePageIsReloadNecessaryChecker >> existingPage: anObject [
	existingPage := anObject
]

{ #category : #checking }
LePageIsReloadNecessaryChecker >> ifUpToDate: anUpToDateBlock ifOutOfDate: anOutOfDateBlock [
	^ self check ifFalse: anUpToDateBlock ifTrue: anOutOfDateBlock
]

{ #category : #testing }
LePageIsReloadNecessaryChecker >> isReloadAlways [
	^ LeReloadOptimization 
		ifEnabled: [ false ]
		ifDisabled: [ true ]
]

{ #category : #accessing }
LePageIsReloadNecessaryChecker >> loadedPage [
	^ loadedPage
]

{ #category : #accessing }
LePageIsReloadNecessaryChecker >> loadedPage: anObject [
	loadedPage := anObject
]
