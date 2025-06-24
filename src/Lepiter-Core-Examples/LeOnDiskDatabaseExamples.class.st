Class {
	#name : #LeOnDiskDatabaseExamples,
	#superclass : #LeInMemoryDatabaseExamples,
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #after }
LeOnDiskDatabaseExamples >> cleanUpDirectory: aDir [
	aDir ensureDeleteAll
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneAndTwoFromProperties [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo |
	aResult := self twoDatabasesWithPageLinks.

	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aProperties := LeLogicalDatabaseProperties new
			primaryDatabaseDirectory: aDatabaseOne monitor localRoot;
			playgroundDatabaseDirectory: aDatabaseOne monitor localRoot;
			addRegisteredDirectory: aDatabaseTwo monitor localRoot;
			localFile: self propertiesFileReference;
			save.
	aLogicalDatabase := LeLogicalDatabase withProperties: aProperties.

	self assert: aLogicalDatabase databases size equals: 2.
	self registerDatabase: aLogicalDatabase.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	self assert: aNewDatabaseOne monitor isRunning.
	self assert: aNewDatabaseTwo monitor isRunning.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aNewDatabaseOne;
		databaseTwo: aNewDatabaseTwo;
		pageOne: (aNewDatabaseOne pageNamed: self pageOneName);
		pageTwo: (aNewDatabaseTwo pageNamed: self pageTwoName);
		pageTwoSnippet: (aNewDatabaseTwo pageNamed: self pageTwoName) children first;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneAndTwoFromPropertiesThenReload [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aLogicalDatabase aDatabaseOne aDatabaseTwo |
	aResult := self logicalDatabaseWithPageLinks_DbOneAndTwoFromProperties.

	aLogicalDatabase := aResult logicalDatabase.

	self assert: aLogicalDatabase databases size equals: 2.

	aLogicalDatabase reload.

	self assert: aLogicalDatabase databases size equals: 2.

	aDatabaseOne := aLogicalDatabase databaseWithID: aResult databaseOne uuidString.
	aDatabaseTwo := aLogicalDatabase databaseWithID: aResult databaseTwo uuidString.

	self assert: aDatabaseOne == aResult databaseOne.
	self assert: aDatabaseTwo == aResult databaseTwo.

	self assert: aDatabaseOne explicitLinks size equals: 0.
	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved.

	self assert: aDatabaseOne monitor isRunning.
	self assert: aDatabaseTwo monitor isRunning.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: (aDatabaseOne pageNamed: self pageOneName);
		pageTwo: (aDatabaseTwo pageNamed: self pageTwoName);
		pageTwoSnippet: (aDatabaseTwo pageNamed: self pageTwoName) children first;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneAndTwoFromProperties_ShuffleTwoAsPlaygroundAndReload [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo aDirOne aDirTwo |
	aResult := self logicalDatabaseWithPageLinks_DbOneAndTwoFromProperties.

	aLogicalDatabase := aResult logicalDatabase.
	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.
	aDirOne := aDatabaseOne monitor localRoot.
	aDirTwo := aDatabaseTwo monitor localRoot.

	aProperties := aLogicalDatabase properties
			primaryDatabaseDirectory: aDirOne;
			playgroundDatabaseDirectory: aDirTwo;
			registeredDatabaseDirectories: #();
			save.

	aLogicalDatabase reload.

	self assert: aLogicalDatabase databases size equals: 2.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseOne == aDatabaseOne.
	self assert: aNewDatabaseTwo == aDatabaseTwo.
	self assert: aLogicalDatabase primaryDB equals: aDatabaseOne.
	self assert: aLogicalDatabase playgroundDB equals: aDatabaseTwo.
	self assert: aDatabaseOne monitor isRunning.
	self assert: aDatabaseTwo monitor isRunning.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneAndTwoFromProperties_ShuffleTwoAsPrimaryAndReload [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo aDirOne aDirTwo |
	aResult := self logicalDatabaseWithPageLinks_DbOneAndTwoFromProperties.

	aLogicalDatabase := aResult logicalDatabase.
	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.
	aDirOne := aDatabaseOne monitor localRoot.
	aDirTwo := aDatabaseTwo monitor localRoot.

	aProperties := aLogicalDatabase properties
			primaryDatabaseDirectory: aDirTwo;
			playgroundDatabaseDirectory: aDirOne;
			registeredDatabaseDirectories: #();
			save.

	aLogicalDatabase reload.

	self assert: aLogicalDatabase databases size equals: 2.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseOne == aDatabaseOne.
	self assert: aNewDatabaseTwo == aDatabaseTwo.
	self assert: aLogicalDatabase primaryDB equals: aDatabaseTwo.
	self assert: aLogicalDatabase playgroundDB equals: aDatabaseOne.

	self assert: aDatabaseOne monitor isRunning.
	self assert: aDatabaseTwo monitor isRunning.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneFromPropertiesThenAddDbTwo [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase |
	aResult := self twoDatabasesWithPageLinks.

	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aProperties := LeLogicalDatabaseProperties new
			primaryDatabaseDirectory: aDatabaseOne monitor localRoot;
			playgroundDatabaseDirectory: aDatabaseOne monitor localRoot;
			localFile: self propertiesFileReference;
			save.
	aLogicalDatabase := LeLogicalDatabase withProperties: aProperties.

	self registerDatabase: aLogicalDatabase.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved not.

	aLogicalDatabase addDB: aDatabaseTwo.

	self assert: aDatabaseOne explicitLinks size equals: 0.
	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneFromPropertiesThenAddDbTwoPropertyAndReload [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo |
	aResult := self twoDatabasesWithPageLinks.

	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aProperties := LeLogicalDatabaseProperties new
			primaryDatabaseDirectory: aDatabaseOne monitor localRoot;
			playgroundDatabaseDirectory: aDatabaseOne monitor localRoot;
			localFile: self propertiesFileReference;
			save.
	aLogicalDatabase := LeLogicalDatabase withProperties: aProperties.

	self assert: aLogicalDatabase databases size equals: 1.
	self registerDatabase: aLogicalDatabase.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved not.

	aProperties
		addRegisteredDirectory: aDatabaseTwo monitor localRoot;
		save.
	aLogicalDatabase reload.

	self assert: aLogicalDatabase databases size equals: 2.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	self assert: aNewDatabaseOne monitor isRunning.
	self assert: aNewDatabaseTwo monitor isRunning.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aNewDatabaseOne;
		databaseTwo: aNewDatabaseTwo;
		pageOne: (aNewDatabaseOne pageNamed: self pageOneName);
		pageTwo: (aNewDatabaseTwo pageNamed: self pageTwoName);
		pageTwoSnippet: (aNewDatabaseTwo pageNamed: self pageTwoName) children first;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneIsPrimaryAndTwoIsPlaygroundFromProperties [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo |
	aResult := self twoDatabasesWithPageLinks.

	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aProperties := LeLogicalDatabaseProperties new
			primaryDatabaseDirectory: aDatabaseOne monitor localRoot;
			playgroundDatabaseDirectory: aDatabaseTwo monitor localRoot;
			localFile: self propertiesFileReference;
			save.
	aLogicalDatabase := LeLogicalDatabase withProperties: aProperties.

	self assert: aLogicalDatabase databases size equals: 2.
	self registerDatabase: aLogicalDatabase.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: (aNewDatabaseOne == aDatabaseOne) not.
	self assert: (aNewDatabaseTwo == aDatabaseTwo) not.
	self assert: (aNewDatabaseOne == aDatabaseTwo) not.
	self assert: (aNewDatabaseTwo == aDatabaseOne) not.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	self assert: aNewDatabaseOne monitor isRunning.
	self assert: aNewDatabaseTwo monitor isRunning.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aNewDatabaseOne;
		databaseTwo: aNewDatabaseTwo;
		pageOne: (aNewDatabaseOne pageNamed: self pageOneName);
		pageTwo: (aNewDatabaseTwo pageNamed: self pageTwoName);
		pageTwoSnippet: (aNewDatabaseTwo pageNamed: self pageTwoName) children first;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneIsPrimaryAndTwoIsPlaygroundFromProperties_ShuffleAndReload [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo aDirOne aDirTwo |
	aResult := self
			logicalDatabaseWithPageLinks_DbOneIsPrimaryAndTwoIsPlaygroundFromProperties.

	aLogicalDatabase := aResult logicalDatabase.
	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.
	aDirOne := aDatabaseOne monitor localRoot.
	aDirTwo := aDatabaseTwo monitor localRoot.

	aProperties := aLogicalDatabase properties
			primaryDatabaseDirectory: aDirTwo;
			playgroundDatabaseDirectory: aDirOne;
			save.

	aLogicalDatabase reload.

	self assert: aLogicalDatabase databases size equals: 2.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseOne == aDatabaseOne.
	self assert: aNewDatabaseTwo == aDatabaseTwo.
	self assert: aLogicalDatabase primaryDB equals: aDatabaseTwo.
	self assert: aLogicalDatabase playgroundDB equals: aDatabaseOne.

	self assert: aDatabaseOne monitor isRunning.
	self assert: aDatabaseTwo monitor isRunning.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneIsPrimaryAndTwoIsPlaygroundFromProperties_ShuffleOneAsRegisteredDBAndReload [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo aDirOne aDirTwo |
	aResult := self
			logicalDatabaseWithPageLinks_DbOneIsPrimaryAndTwoIsPlaygroundFromProperties.

	aLogicalDatabase := aResult logicalDatabase.
	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.
	aDirOne := aDatabaseOne monitor localRoot.
	aDirTwo := aDatabaseTwo monitor localRoot.

	aProperties := aLogicalDatabase properties
			primaryDatabaseDirectory: aDirTwo;
			playgroundDatabaseDirectory: aDirTwo;
			registeredDatabaseDirectories: {aDirOne};
			save.

	aLogicalDatabase reload.

	self assert: aLogicalDatabase databases size equals: 2.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseOne == aDatabaseOne.
	self assert: aNewDatabaseTwo == aDatabaseTwo.
	self assert: aLogicalDatabase primaryDB equals: aDatabaseTwo.
	self assert: aLogicalDatabase playgroundDB equals: aDatabaseTwo.
	self assert: aLogicalDatabase registeredDBs size equals: 1.
	self assert: aLogicalDatabase registeredDBs first equals: aDatabaseOne.

	self assert: aDatabaseOne monitor isRunning.
	self assert: aDatabaseTwo monitor isRunning.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbOneIsPrimaryAndTwoIsPlaygroundFromProperties_ShuffleTwoAsRegisteredDBAndReload [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo aDirOne aDirTwo |
	aResult := self
			logicalDatabaseWithPageLinks_DbOneIsPrimaryAndTwoIsPlaygroundFromProperties.

	aLogicalDatabase := aResult logicalDatabase.
	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.
	aDirOne := aDatabaseOne monitor localRoot.
	aDirTwo := aDatabaseTwo monitor localRoot.

	aProperties := aLogicalDatabase properties
			primaryDatabaseDirectory: aDirOne;
			playgroundDatabaseDirectory: aDirOne;
			registeredDatabaseDirectories: {aDirTwo};
			save.

	aLogicalDatabase reload.

	self assert: aLogicalDatabase databases size equals: 2.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseOne == aDatabaseOne.
	self assert: aNewDatabaseTwo == aDatabaseTwo.
	self assert: aLogicalDatabase primaryDB equals: aDatabaseOne.
	self assert: aLogicalDatabase playgroundDB equals: aDatabaseOne.
	self assert: aLogicalDatabase registeredDBs size equals: 1.
	self assert: aLogicalDatabase registeredDBs first equals: aDatabaseTwo.

	self assert: aDatabaseOne monitor isRunning.
	self assert: aDatabaseTwo monitor isRunning.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbTwoAndOneFromProperties [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo |
	aResult := self twoDatabasesWithPageLinks.

	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aProperties := LeLogicalDatabaseProperties new
			primaryDatabaseDirectory: aDatabaseTwo monitor localRoot;
			playgroundDatabaseDirectory: aDatabaseTwo monitor localRoot;
			addRegisteredDirectory: aDatabaseOne monitor localRoot;
			localFile: self propertiesFileReference;
			save.
	aLogicalDatabase := LeLogicalDatabase withProperties: aProperties.

	self assert: aLogicalDatabase databases size equals: 2.
	self registerDatabase: aLogicalDatabase.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aNewDatabaseOne;
		databaseTwo: aNewDatabaseTwo;
		pageOne: (aNewDatabaseOne pageNamed: self pageOneName);
		pageTwo: (aNewDatabaseTwo pageNamed: self pageTwoName);
		pageTwoSnippet: (aNewDatabaseTwo pageNamed: self pageTwoName) children first;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbTwoAndOneFromPropertiesThenReload [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aLogicalDatabase aDatabaseOne aDatabaseTwo |
	aResult := self logicalDatabaseWithPageLinks_DbTwoAndOneFromProperties.

	aLogicalDatabase := aResult logicalDatabase.

	self assert: aLogicalDatabase databases size equals: 2.

	aLogicalDatabase reload.

	self assert: aLogicalDatabase databases size equals: 2.

	aDatabaseOne := aLogicalDatabase databaseWithID: aResult databaseOne uuidString.
	aDatabaseTwo := aLogicalDatabase databaseWithID: aResult databaseTwo uuidString.

	self assert: aDatabaseOne == aResult databaseOne.
	self assert: aDatabaseTwo == aResult databaseTwo.

	self assert: aDatabaseOne explicitLinks size equals: 0.
	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: (aDatabaseOne pageNamed: self pageOneName);
		pageTwo: (aDatabaseTwo pageNamed: self pageTwoName);
		pageTwoSnippet: (aDatabaseTwo pageNamed: self pageTwoName) children first;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbTwoFromPropertiesThenAddDbOne [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseTwo |
	aResult := self twoDatabasesWithPageLinks.

	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aProperties := LeLogicalDatabaseProperties new
			primaryDatabaseDirectory: aDatabaseTwo monitor localRoot;
			playgroundDatabaseDirectory: aDatabaseTwo monitor localRoot;
			localFile: self propertiesFileReference.
	aLogicalDatabase := LeLogicalDatabase withProperties: aProperties.

	self registerDatabase: aLogicalDatabase.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved not.

	aLogicalDatabase addDB: aDatabaseOne.

	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aDatabaseOne;
		databaseTwo: aNewDatabaseTwo;
		pageOne: (aDatabaseOne pageNamed: self pageOneName);
		pageTwo: (aNewDatabaseTwo pageNamed: self pageTwoName);
		pageTwoSnippet: (aNewDatabaseTwo pageNamed: self pageTwoName) children first;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> logicalDatabaseWithPageLinks_DbTwoFromPropertiesThenAddDbOnePropertyAndReload [
	<gtExample>
	<after: #cleanUp>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aProperties aLogicalDatabase aNewDatabaseOne aNewDatabaseTwo |
	aResult := self twoDatabasesWithPageLinks.

	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aProperties := LeLogicalDatabaseProperties new
			primaryDatabaseDirectory: aDatabaseTwo monitor localRoot;
			playgroundDatabaseDirectory: aDatabaseTwo monitor localRoot;
			localFile: self propertiesFileReference;
			save.
	aLogicalDatabase := LeLogicalDatabase withProperties: aProperties.

	self assert: aLogicalDatabase databases size equals: 1.
	self registerDatabase: aLogicalDatabase.

	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved not.

	aProperties
		addRegisteredDirectory: aDatabaseOne monitor localRoot;
		save.
	aLogicalDatabase reload.

	self assert: aLogicalDatabase databases size equals: 2.

	aNewDatabaseOne := aLogicalDatabase databaseWithID: aDatabaseOne uuidString.
	aNewDatabaseTwo := aLogicalDatabase databaseWithID: aDatabaseTwo uuidString.

	self assert: aNewDatabaseOne explicitLinks size equals: 0.
	self assert: aNewDatabaseTwo explicitLinks size equals: 1.
	self assert: aNewDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		previousResult: aResult;
		databaseOne: aNewDatabaseOne;
		databaseTwo: aNewDatabaseTwo;
		pageOne: (aNewDatabaseOne pageNamed: self pageOneName);
		pageTwo: (aNewDatabaseTwo pageNamed: self pageTwoName);
		pageTwoSnippet: (aNewDatabaseTwo pageNamed: self pageTwoName) children first;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeOnDiskDatabaseExamples >> propertiesFileReference [
	<gtExample>
	<return: #FileReference>
	^ self storeRootDirectory
		/ LepiterCoreDefaults logicalDatabasePropertiesBasename
]

{ #category : #'examples - storage' }
LeOnDiskDatabaseExamples >> storeRootDirectory [
	<gtExample>
	<after: #cleanUp>
	<return: #FileReference>
	^ storeRootDirectory
		ifNil: [ storeRootDirectory := FileReference
					newTempFilePrefix: self className , '--'
					suffix: '--lepiter-test' ]
]
