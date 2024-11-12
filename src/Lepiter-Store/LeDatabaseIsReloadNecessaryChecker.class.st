Class {
	#name : #LeDatabaseIsReloadNecessaryChecker,
	#superclass : #Object,
	#instVars : [
		'database'
	],
	#classVars : [
		'ReloadAlways'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #evaluation }
LeDatabaseIsReloadNecessaryChecker class >> alwaysReloadDuring: aBlock [
	| oldValue |
	oldValue := ReloadAlways.
	self reloadAlways.
	^ aBlock ensure: [ ReloadAlways := oldValue ]
]

{ #category : #initialization }
LeDatabaseIsReloadNecessaryChecker class >> initialize [
	self reloadAsNeeded
]

{ #category : #testing }
LeDatabaseIsReloadNecessaryChecker class >> isReloadAlways [
	^ ReloadAlways ifNil: [ false ]
]

{ #category : #configuration }
LeDatabaseIsReloadNecessaryChecker class >> reloadAlways [
	ReloadAlways := true
]

{ #category : #configuration }
LeDatabaseIsReloadNecessaryChecker class >> reloadAsNeeded [
	ReloadAlways := false
]

{ #category : #checking }
LeDatabaseIsReloadNecessaryChecker >> check [
	"Return true if a given database needs to be reloaded, false otherwise.
	Notice that it currently checks only page files. There are other files
	that can change, e.g., external links, attachments, and db properties."

	<return: #Boolean>
	self isReloadAlways ifTrue: [ ^ true ].
	
	self database pagesDo: [ :aPage | 
		aPage storageHash 
			ifNil: [ ^ true ]
			ifNotNil: [ :aHash |
				| aFile |
				aFile := self database monitor pageFileReference: aPage.
				aFile exists ifTrue: [
					(aHash isSameAsFileReference: aFile) ifFalse: [
						^ true ] ] ] ].
	^ false
]

{ #category : #accessing }
LeDatabaseIsReloadNecessaryChecker >> database [
	<return: #LeDatabase>
	^ database
]

{ #category : #accessing }
LeDatabaseIsReloadNecessaryChecker >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #checking }
LeDatabaseIsReloadNecessaryChecker >> ifUpToDate: anUpdatedBlock ifOutOfDate: anOutOfDateBlock [
	^ self check ifFalse: anUpdatedBlock ifTrue: anOutOfDateBlock
]

{ #category : #testing }
LeDatabaseIsReloadNecessaryChecker >> isReloadAlways [
	^ self class isReloadAlways
]
