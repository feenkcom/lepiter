"
I exemplify {{gtClass: LeTemporaryDatabase}}. 
"
Class {
	#name : #LeTemporaryDatabaseExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Support'
}

{ #category : #accessing }
LeTemporaryDatabaseExamples >> explicitDatabase [
	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase reference database |
	reference := FileReference
			newTempFilePrefix: 'lepiter-temporary-'
			suffix: '-example-directory'.
	reference ensureCreateDirectory.

	database := LeLocalStoreLoad current loadAndMonitorFrom: reference.

	temporaryDatabase := LeTemporaryDatabase new.
	temporaryDatabase database: database.

	self assert: database isNotNil.
	self assert: database hasMonitor.
	self assert: database monitor isRunning.

	self assert: temporaryDatabase database == database.
	self assert: temporaryDatabase database == temporaryDatabase database.

	self assert: temporaryDatabase reference == reference.
	self assert: temporaryDatabase reference == temporaryDatabase reference.
	self assert: temporaryDatabase reference exists.
	self assert: temporaryDatabase reference isDirectory.

	^ temporaryDatabase
]

{ #category : #accessing }
LeTemporaryDatabaseExamples >> explicitDatabaseIsGarbageCollected [
	<gtExample>
	<return: #FileReference>
	| temporaryDatabase reference database |
	temporaryDatabase := self explicitDatabase.
	reference := temporaryDatabase reference.
	database := temporaryDatabase database.

	self assert: reference exists.
	self assert: database hasMonitor.
	self assert: database monitor isRunning.

	temporaryDatabase := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].

	self assert: reference exists not.
	self assert: database hasMonitor.
	self assert: database monitor isRunning not.

	^ reference
]

{ #category : #accessing }
LeTemporaryDatabaseExamples >> explicitReference [
	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase reference database |
	reference := FileReference
			newTempFilePrefix: 'lepiter-temporary-'
			suffix: '-example-directory'.
	reference ensureCreateDirectory.

	temporaryDatabase := LeTemporaryDatabase new.
	temporaryDatabase reference: reference.

	database := temporaryDatabase database.

	self assert: database isNotNil.
	self assert: database hasMonitor.
	self assert: database monitor isRunning.

	self assert: temporaryDatabase reference == reference.
	self assert: temporaryDatabase reference == temporaryDatabase reference.
	self assert: temporaryDatabase reference exists.
	self assert: temporaryDatabase reference isDirectory.

	^ temporaryDatabase
]

{ #category : #accessing }
LeTemporaryDatabaseExamples >> explicitReferenceIsGarbageCollected [
	<gtExample>
	<return: #FileReference>
	| temporaryDatabase reference database |
	temporaryDatabase := self explicitReference.
	reference := temporaryDatabase reference.
	database := temporaryDatabase database.

	self assert: reference exists.
	self assert: database hasMonitor.
	self assert: database monitor isRunning.

	temporaryDatabase := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].

	self assert: reference exists not.
	self assert: database hasMonitor.
	self assert: database monitor isRunning not.

	^ reference
]

{ #category : #accessing }
LeTemporaryDatabaseExamples >> implicitDatabase [
	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase reference database |
	temporaryDatabase := LeTemporaryDatabase new.

	database := temporaryDatabase database.
	reference := temporaryDatabase reference.

	self assert: database isNotNil.
	self assert: database hasMonitor.
	self assert: database monitor isRunning.

	self assert: reference == temporaryDatabase reference.
	self assert: reference exists.
	self assert: reference isDirectory.

	^ temporaryDatabase
]

{ #category : #accessing }
LeTemporaryDatabaseExamples >> implicitDatabaseIsGarbageCollected [
	<gtExample>
	<return: #FileReference>
	| temporaryDatabase reference database |
	temporaryDatabase := self implicitDatabase.
	reference := temporaryDatabase reference.
	database := temporaryDatabase database.

	self assert: reference exists.
	self assert: database hasMonitor.
	self assert: database monitor isRunning.

	temporaryDatabase := nil.

	2 timesRepeat: [ Smalltalk garbageCollect ].

	self assert: reference exists not.
	self assert: database hasMonitor.
	self assert: database monitor isRunning not.

	^ reference
]
