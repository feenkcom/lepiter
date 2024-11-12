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
	"Return reload reason."

	<return: #LeDatabaseReloadReason>
	| aMonitor aCurrentProperties aStorageProperties |
	
	"1. Check whether partial reload is enabled."
	self isReloadAlways ifTrue: [ 
		^ LeDatabaseAlwaysReloadReason new
			database: self database ].
			
	"2. Check whether reload reason was already computed."
	self database reloadReason ifNotNil: [ :aReason | 
		^ aReason ].
		
	"3. Check database properties change status.
		Properties are loaded since it is expected to be a fast action."
	aMonitor := self database monitor.
	aCurrentProperties := aMonitor dbPropertiesOrNil.
	aStorageProperties := aMonitor loadPropertiesDictionary.
	aCurrentProperties = aStorageProperties ifFalse: [ 
		^ LeDatabasePropertiesChangedReloadReason new
			database: self database;
			currentProperties: aCurrentProperties;
			storageProperties: aStorageProperties ].
	
	"4. Check explicit links change status."
	self database explicitLinks ifNotNil: [ :aModel | 
		| aFile |
		aFile := aMonitor explicitLinksFileReference.
		(self checkModel: aModel file: aFile)
			ifNotNil: [ :aReason | ^ aReason ] ].
	
	"5. Check change status of all pages."
	self database pagesDo: [ :aPage | 
		| aFile |
		aFile := aMonitor pageFileReference: aPage.
		(self checkModel: aPage file: aFile)
			ifNotNil: [ :aReason | ^ aReason ] ].
	
	"6. Nothing was changed."
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
