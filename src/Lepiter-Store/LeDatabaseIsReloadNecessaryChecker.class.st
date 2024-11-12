Class {
	#name : #LeDatabaseIsReloadNecessaryChecker,
	#superclass : #Object,
	#instVars : [
		'database'
	],
	#classVars : [
		'ReloadAlways'
	],
	#category : #'Lepiter-Store-Reload - Optimizations'
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
	"Return reload reason.
	Notice that it currently checks only page files. There are other files
	that can change, e.g., external links, attachments, and db properties."

	<return: #LeDatabaseReloadReason>
	self isReloadAlways ifTrue: [ 
		^ LeDatabaseAlwaysReloadReason new
			database: self database ].
	
	self database explicitLinks ifNotNil: [ :aModel | 
		| aFile |
		aFile := self database monitor explicitLinksFileReference.
		(self checkModel: aModel file: aFile)
			ifNotNil: [ :aReason | ^ aReason ] ].
	
	self database pagesDo: [ :aPage | 
		| aFile |
		aFile := self database monitor pageFileReference: aPage.
		(self checkModel: aPage file: aFile)
			ifNotNil: [ :aReason | ^ aReason ] ].
	
	^ LeDatabaseUpToDateReloadReason new
		database: self database
]

{ #category : #checking }
LeDatabaseIsReloadNecessaryChecker >> checkModel: aModel file: aFile [
	aFile ifNil: [ ^ nil ].
	aFile exists ifFalse: [ ^ nil ].

	aModel storageHash
		ifNil: [ 
			^ LeDatabaseMissingHashReloadReason new
				database: self database;
				model: aModel ]
		ifNotNil: [ :aHash | 
			| aFileHash |
			aFileHash := LeBinaryContentsHash fromFileReference: aFile.
			aHash = aFileHash ifFalse: [ 
				^ LeDatabaseFileChangedReloadReason new
					database: self database;
					model: aModel;
					modelHash: aHash;
					file: aFile;
					fileHash: aFileHash ] ].

	^ nil
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
LeDatabaseIsReloadNecessaryChecker >> ifUpToDate: anUpToDateBlock ifOutOfDate: anOutOfDateBlock [
	^ self check
		ifUpToDate: [ :aReason | 
			LeReloadUpToDateReasonSignal new
				reason: aReason;
				emit. 
			anUpToDateBlock cull: aReason ] 
		ifOutOfDate: [ :aReason | 
			LeReloadOutOfDateReasonSignal new
				reason: aReason;
				emit.
			anOutOfDateBlock cull: aReason ]
]

{ #category : #testing }
LeDatabaseIsReloadNecessaryChecker >> isReloadAlways [
	^ LeReloadOptimization 
		ifEnabled: [ false ]
		ifDisabled: [ true ]
		ifUndefiend: [ self class isReloadAlways ]
]
