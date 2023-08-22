"
I am a simple utility object that holds a {{gtClass:LeDatabase}} object.
The referenced database is stopped and its {{gtMethod: LeDatabase >> localStoreRootDirectory | label=local store}} directory is removed on the object finalization.
I am not supposed to be polymorphic to {{gtClass:LeDatabase}}.
I should rather be used in examples (and similar code).

"
Class {
	#name : #LeTemporaryDatabase,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'database',
		'temporaryDirectory'
	],
	#category : #'Lepiter-Core-Examples-Support'
}

{ #category : #'api - accessing' }
LeTemporaryDatabase >> database [
	<return: #LeDatabase>
	database ifNil: [ self ensureCreateTemporaryDatabase ].
	^ database
]

{ #category : #'api - initialization' }
LeTemporaryDatabase >> database: aDatabase [
	self 
		assert: [ aDatabase isNotNil ] 
		description: [ 'Database must be non-nil' ].
	
	self
		assert: [ (aDatabase localStoreRootDirectory isNotNil and: [ 
			aDatabase localStoreRootDirectory isDirectory ]) ]
		description: [ 'Database store root directory must be an existing directory' ].

	mutex critical: [
		self
			assert: [ database isNil ]
			description: [ 'Database can be set only once' ].
	
		database := aDatabase.
		temporaryDirectory := GtTemporaryDirectory new reference: aDatabase localStoreRootDirectory.
		
		"Remove the directory when the object is not used."
		self class finalizationRegistry add: self ]
]

{ #category : #'private - initialization' }
LeTemporaryDatabase >> ensureCreateTemporaryDatabase [
	^ mutex critical: [
		database ifNil: [
			self ensureCreateTemporaryDirectory.
			
			database := LeLocalStoreLoad current loadAndMonitorFrom: temporaryDirectory reference.
			
			"Remove the database when the object is not used."
			self class finalizationRegistry add: self ].
		
		database ]
]

{ #category : #'private - initialization' }
LeTemporaryDatabase >> ensureCreateTemporaryDirectory [
	^ mutex critical: [
		temporaryDirectory ifNil: [
			| reference |
			
			reference := FileReference
					newTempFilePrefix: 'lepiter-temporary-'
					suffix: '-database-directory'.
			reference ensureCreateDirectory.
			
			temporaryDirectory := GtTemporaryDirectory new reference: reference ].
		
		temporaryDirectory ]
]

{ #category : #finalization }
LeTemporaryDatabase >> finalize [
	database
		ifNotNil: [ :aDatabase | 
			database := nil.
			temporaryDirectory := nil.
			[ aDatabase stopMonitoring. ]
				on: Error
				do: [ :anException | 
					"silently ignore errors"
					anException emit ] ].
	super finalize
]

{ #category : #'gt - extensions' }
LeTemporaryDatabase >> gtDatabaseLiveFor: aView [
	<gtView>
	database ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Database';
		priority: 10;
		object: [ self database ];
		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
LeTemporaryDatabase >> gtPathFor: aView [
	<gtView>
	database ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Path';
		priority: 55;
		object: [ self reference ];
		view: #gtPathFor:
]

{ #category : #'gt - extensions' }
LeTemporaryDatabase >> gtTreeFor: aView [
	<gtView>
	database ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Root directory';
		priority: 15;
		object: [ self reference ];
		view: #gtTreeFor:
]

{ #category : #initialization }
LeTemporaryDatabase >> initialize [
	super initialize.
	
	mutex := Mutex new.
	database := nil.
	temporaryDirectory := nil.
]

{ #category : #printing }
LeTemporaryDatabase >> printOn: aStream [
	super printOn: aStream.

	database ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self database databaseName;
		nextPut: $)
]

{ #category : #'api - accessing' }
LeTemporaryDatabase >> reference [
	<return: #FileReference>
	^ self database localStoreRootDirectory
]

{ #category : #'api - initialization' }
LeTemporaryDatabase >> reference: aDirectory [
	self 
		assert: [ aDirectory isNotNil ] 
		description: [ 'Directory must be non-nil' ].
	
	self
		assert: [ (aDirectory exists and: [ aDirectory isDirectory ]) ]
		description: [ 'Directory must be an existing directory' ].

	mutex critical: [
		self
			assert: [ database isNil ]
			description: [ 'Database can be set only once' ].
		self 
			assert: [ temporaryDirectory isNil ]
			description: [ 'Database store root directory can be set only once' ].
	
		temporaryDirectory := GtTemporaryDirectory new reference: aDirectory. ]
]
