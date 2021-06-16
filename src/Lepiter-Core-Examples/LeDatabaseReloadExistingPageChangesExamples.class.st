Class {
	#name : #LeDatabaseReloadExistingPageChangesExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #'examples - flat snippet structure' }
LeDatabaseReloadExistingPageChangesExamples >> changedFlatSnippetStructureInStorage [
	"The initial page has three snippets:
	  A
	  B
	  C
	
	We change this to:
	  A
	  B1
	     B
	  C"
	<gtExample>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFlatSnippetStructure.
	
	secondDatabase := self createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target Page'.
	
	targetPage 
		addSnippet: (LeTextSnippet string: 'B1')
		after: targetPage children first.
	targetPage children third indent.

	self assert: targetPage children size equals: 3.
	self assert: targetPage children second children size equals: 1.
	secondDatabase stopMonitoring.
	
	^ database
]

{ #category : #'examples - flat snippet order' }
LeDatabaseReloadExistingPageChangesExamples >> changedFlatSnippetsOrderInStorage [
	"The initial page has three snippets:
	  A
	  B
	  C
	
	We change this to:
	  B
	  C
	  A"
	<gtExample>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFlatSnippetStructure.
	
	secondDatabase := self createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target Page'.
	
	targetPage children first 
		moveDown;
		moveDown.

	self assert: targetPage children size equals: 3.
	self assert: targetPage children first string equals: 'B'.
	self assert: targetPage children second string equals: 'C'.
	self assert: targetPage children third string equals: 'A'.
	
	secondDatabase stopMonitoring.
	
	^ database
]

{ #category : #examples }
LeDatabaseReloadExistingPageChangesExamples >> createDatabaseFromFolder: aFolderReference [
	|localStore |
	
	localStore := LeLocalStoreLoad new 
		storage: LeMockLocalJsonV4StorageWithFilesOrder new.
	localStore localRoot: aFolderReference.
	^ localStore 
		loadAndMonitorFrom: aFolderReference 
		saveDelay: Duration zero
]

{ #category : #'examples - flat snippet structure' }
LeDatabaseReloadExistingPageChangesExamples >> createDatabaseWithFlatSnippetStructure [
	<gtExample>
	| database page |
	database := self databaseWithMockedStorage.
	
	page := LePage named: 'Target Page'..
	page addSnippet: (LeTextSnippet string: 'A').
	page addSnippet: (LeTextSnippet string: 'B').
	page addSnippet: (LeTextSnippet string: 'C').
	
	self assert:  page children size equals: 3.
	database addPage: page.
	
	^ database
]

{ #category : #examples }
LeDatabaseReloadExistingPageChangesExamples >> databaseWithMockedStorage [
	<gtExample>
	| folderReference localStore |
	folderReference := FileSystem memory / 'storage'.
	folderReference ensureCreateDirectory.
	
	localStore := LeLocalStoreLoad new storage: LeMockLocalJsonV4StorageWithFilesOrder new.
	localStore localRoot: folderReference.
	^ localStore loadAndMonitorFrom: folderReference saveDelay: Duration zero
]

{ #category : #'examples - flat snippet structure' }
LeDatabaseReloadExistingPageChangesExamples >> reloadModifiedFlatSnippetStructureFromStorage [
	<gtExample>
	<noTest>
	| database targetPage |
	database := self changedFlatSnippetStructureInStorage.

	database reload.
	
	targetPage := database pageNamed: 'Target Page'.

	self assert: targetPage children size equals: 3.
	
	^ database
]

{ #category : #'examples - flat snippet order' }
LeDatabaseReloadExistingPageChangesExamples >> reloadModifiedFlatSnippetsOrderFromStorage [
	<gtExample>
	<noTest>
	| database targetPage |
	database := self changedFlatSnippetsOrderInStorage.

	database reload.
	
	targetPage := database pageNamed: 'Target Page'.

	self assert: targetPage children size equals: 3.
	self assert: targetPage children first string equals: 'B'.
	self assert: targetPage children second string equals: 'C'.
	self assert: targetPage children third string equals: 'A'.
	
	^ database
]
