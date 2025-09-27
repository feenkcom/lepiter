"
I illustrate usages of `TLeInMemoryDatabaseHolder`.
"
Class {
	#name : #LeInMemoryDatabaseHolderExamples,
	#superclass : #Object,
	#traits : 'TLeInMemoryDatabaseHolder + TGtExampleAssertable',
	#classTraits : 'TLeInMemoryDatabaseHolder classTrait + TGtExampleAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Utility'
}

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> badFolderIsNotADatabase [
	<gtExample>
	| aFolder |
	aFolder := self folderForPath: 'feenkcom'.
	self assert: aFolder isNotNil.
	self assert: aFolder exists.
	self should: [self inMemoryDatabaseFor: aFolder] raise: AssertionFailure.
	^ aFolder
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> gtBookAsAnInMemoryDatabase [
	"Copies all the GT Book files into main memory, so not a test."

	<gtExample>
	<noTest>
	| db |
	db := self inMemoryDatabaseFor: LeDatabase gtBook localStoreRootDirectory.
	self
		assert: (LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
				includes: db) not.
	^ db
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> gtBookIsARealDatabase [
	<gtExample>
	| db |
	db := self databaseNamed: self gtBookName.
	self
		assert: (LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
				includes: db).
	^ db
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> gtBookName [
	<gtExample>
	^ LeDatabase gtBookName
]

{ #category : #accessing }
LeInMemoryDatabaseHolderExamples >> initializationExample [
	"Illustrates how to initialize the name and the database.
	NB: This will activate the `Database` view."

	<gtExample>
	| instance |
	instance := (LeInMemoryDatabaseHolderExamples new
			databaseName: LeInMemoryDatabaseHolderExamples new testDataPath)
			initializeDatabase;
			yourself.
	^ instance
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> junkDatabaseName [
	<gtExample>
	^ 'feenkcom/foobar'
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> junkDatabaseNameFails [
	<gtExample>
	self databaseName: self junkDatabaseName.
	self should: [self renewDatabase] raise: Error.
	^ database
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> junkPathIsNotAFolder [
	<gtExample>
	| aNilValue |
	aNilValue := self folderForPath: 'feenkcom/foobar'.
	self assert: aNilValue isNil.
	^ aNilValue
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> nilDatabaseNameFails [
	<gtExample>
	self databaseName: nil.
	self should: [self renewDatabase] raise: Error.
	^ database
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> testDataNameSucceeds [
	<gtExample>
	self databaseName: self testDataPath.
	self assert: self database isNotNil.
	self assert: self database size equals: self testDatabaseIsTransient size.
	self
		assert: (LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
				includes: self database) not.
	^ self database
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> testDataPath [
	<gtExample>
	^ 'feenkcom/lepiter/test-data/toc'
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> testDatabaseFolder [
	<gtExample>
	| aFolder |
	aFolder := self folderForPath: self testDataPath.
	self assert: aFolder isNotNil.
	self assert: aFolder exists.
	^ aFolder
]

{ #category : #examples }
LeInMemoryDatabaseHolderExamples >> testDatabaseIsTransient [
	<gtExample>
	| db |
	db := self inMemoryDatabaseFor: self testDatabaseFolder.
	self
		assert: (LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
				includes: db) not.
	^ db
]
