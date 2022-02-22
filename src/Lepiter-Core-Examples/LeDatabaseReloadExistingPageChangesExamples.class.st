Class {
	#name : #LeDatabaseReloadExistingPageChangesExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #'examples - children snippets order' }
LeDatabaseReloadExistingPageChangesExamples >> changedChildrenSnippetsOrderInStorage [
	"The initial page has three snippets:
	  A
	   A1
	   A2
	   A3
	  B
	
	We change this to:
	  B
	  A
		A3
	   A1
	   A2"
	<gtExample>
	| database secondDatabase targetPage  firstSnippet |
	database := self createDatabaseWithChildrenSnippetStructure.
	
	secondDatabase := self createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target Page'.
	firstSnippet := targetPage children first.
	
	firstSnippet children third
		moveUp;
		moveUp.
	targetPage children first moveDown.

	self assert: targetPage children size equals: 2.
	self assert: targetPage children first string equals: 'B'.
	self assert: targetPage children second string equals: 'A'.
	
	self assert: firstSnippet children size equals: 3.
	self assert: firstSnippet children first string equals: 'A3'.
	self assert: firstSnippet children second string equals: 'A1'.
	self assert: firstSnippet children third string equals: 'A2'.
	
	secondDatabase stopMonitoring.
	
	^ database
]

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

{ #category : #'examples - flat snippet order' }
LeDatabaseReloadExistingPageChangesExamples >> changedFlatSnippetsOrderWithSnippetAdditionInStorage [
	"The initial page has three snippets:
	  A
	  B
	  C
	
	We change this to:
	  E
	  C
	  B
	  F
	  A"
	<gtExample>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFlatSnippetStructure.
	
	secondDatabase := self createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target Page'.
	
	targetPage children first 
		moveDown;
		moveDown.
	targetPage children first 
		moveDown.
	targetPage 
		addSnippet: (LeTextSnippet string: 'E')  
		before: targetPage children first.
	targetPage 
		addSnippet: (LeTextSnippet string: 'F')  
		after: targetPage children third.

	self assert: targetPage children size equals: 5.
	self assert: targetPage children first string equals: 'E'.
	self assert: targetPage children second string equals: 'C'.
	self assert: targetPage children third string equals: 'B'.
	self assert: targetPage children fourth string equals: 'F'.
	self assert: targetPage children fifth string equals: 'A'.
	
	secondDatabase stopMonitoring.
	
	^ database
]

{ #category : #'examples - flat snippet order' }
LeDatabaseReloadExistingPageChangesExamples >> changedFlatSnippetsOrderWithSnippetDeletionInStorage [
	"The initial page has three snippets:
	  A
	  B
	  C
	
	We change this to:
	  C
     B"
	<gtExample>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFlatSnippetStructure.
	
	secondDatabase := self createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target Page'.
	
	targetPage children first removeSelf.
	targetPage children first moveDown.

	self assert: targetPage children size equals: 2.
	self assert: targetPage children first string equals: 'C'.
	self assert: targetPage children second string equals: 'B'.
	
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

{ #category : #'examples - children snippets order' }
LeDatabaseReloadExistingPageChangesExamples >> createDatabaseWithChildrenSnippetStructure [
	<gtExample>
	| database page |
	database := self databaseWithMockedStorage.
	
	page := LePage named: 'Target Page'.
	page addSnippet: (LeTextSnippet string: 'A').
	page addSnippet: (LeTextSnippet string: 'B').
	
	page children first
		addSnippet: (LeTextSnippet string: 'A1');
		addSnippet: (LeTextSnippet string: 'A2');
		addSnippet: (LeTextSnippet string: 'A3').
	
	self assert:  page children size equals: 2.
	self assert:  page children first children size equals: 3.
	database addPage: page.
	
	^ database
]

{ #category : #'examples - flat snippet structure' }
LeDatabaseReloadExistingPageChangesExamples >> createDatabaseWithFlatSnippetStructure [
	<gtExample>
	| database page |
	database := self databaseWithMockedStorage.
	
	page := LePage named: 'Target Page'.
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

{ #category : #'examples - children snippets order' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedChildrenSnippetsOrderInStorage [
	<gtExample>
	
	| database targetPage targetSnippet |
	database := self changedChildrenSnippetsOrderInStorage.

	database reload.
	
	targetPage := database pageNamed: 'Target Page'.

	self assert: targetPage children size equals: 2.
	self assert: targetPage children first string equals: 'B'.
	self assert: targetPage children second string equals: 'A'.
	
	targetSnippet := targetPage children second.
	self assert: targetSnippet children size equals: 3.
	self assert: targetSnippet children first string equals: 'A3'.
	self assert: targetSnippet children second string equals: 'A1'.
	self assert: targetSnippet children third string equals: 'A2'.
	
	^ database
]

{ #category : #'examples - children snippets order' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedChildrenSnippetsOrderInStorage_hasSameIdentity [
	<gtExample>
	
	| database targetPage targetSnippet snippetOne snippetTwo snippetThree |
	database := self changedChildrenSnippetsOrderInStorage.
	targetPage := database pageNamed: 'Target Page'.
	targetSnippet := targetPage children first.
	
	snippetOne := targetSnippet children first.
	snippetTwo := targetSnippet children second.
	snippetThree := targetSnippet children third.
	
	database reload.
	
	self assert: targetSnippet children first == snippetThree.
	self assert: targetSnippet children second == snippetOne.
	self assert: targetSnippet children third == snippetTwo.
	
	^ database
]

{ #category : #'examples - flat snippet order' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedFlatSnippetsOrderWithSnippetAdditionInStorage [
	<gtExample>
	
	| database targetPage |
	database := self changedFlatSnippetsOrderWithSnippetAdditionInStorage.

	database reload.
	
	targetPage := database pageNamed: 'Target Page'.

	self assert: targetPage children size equals: 5.
	self assert: targetPage children first string equals: 'E'.
	self assert: targetPage children second string equals: 'C'.
	self assert: targetPage children third string equals: 'B'.
	self assert: targetPage children fourth string equals: 'F'.
	self assert: targetPage children fifth string equals: 'A'.
	
	^ database
]

{ #category : #'examples - flat snippet order' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedFlatSnippetsOrderWithSnippetAdditionInStorage_hasSameIdentity [
	<gtExample>
	
	| database targetPage snippetOne snippetTwo snippetThree |
	database := self changedFlatSnippetsOrderWithSnippetAdditionInStorage.
	targetPage := database pageNamed: 'Target Page'.
	
	snippetOne := targetPage children first.
	snippetTwo := targetPage children second.
	snippetThree := targetPage children third.
	
	database reload.

	self assert: targetPage children second == snippetThree.
	self assert: targetPage children third == snippetTwo.
	self assert: targetPage children fifth == snippetOne.
	
	^ database
]

{ #category : #'examples - flat snippet order' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedFlatSnippetsOrderWithSnippetDeletionInStorage [
	<gtExample>
	
	| database targetPage |
	database := self changedFlatSnippetsOrderWithSnippetDeletionInStorage.
	
	database reload.
	
	targetPage := database pageNamed: 'Target Page'.

	self assert: targetPage children size equals: 2.
	self assert: targetPage children first string equals: 'C'.
	self assert: targetPage children second string equals: 'B'.
	
	^ database
]

{ #category : #'examples - flat snippet order' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedFlatSnippetsOrderWithSnippetDeletionInStorage_hasSameIdentity [
	<gtExample>
	
	| database targetPage snippetTwo snippetThree |
	database := self changedFlatSnippetsOrderWithSnippetDeletionInStorage.
	targetPage := database pageNamed: 'Target Page'.
	
	snippetTwo := targetPage children second.
	snippetThree := targetPage children third.
	
	database reload.

	self assert: targetPage children first == snippetThree.
	self assert: targetPage children second == snippetTwo.
	
	^ database
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

{ #category : #'examples - flat snippet order' }
LeDatabaseReloadExistingPageChangesExamples >> reloadModifiedFlatSnippetsOrderFromStorage_hasSameIdentity [
	<gtExample>
	
	| database targetPage snippetOne snippetTwo snippetThree |
	database := self changedFlatSnippetsOrderInStorage.
	targetPage := database pageNamed: 'Target Page'.
	snippetOne := targetPage children first.
	snippetTwo := targetPage children second.
	snippetThree := targetPage children third.
	
	database reload.

	self assert: targetPage children first == snippetTwo.
	self assert: targetPage children second == snippetThree.
	self assert: targetPage children third == snippetOne.
	
	^ database
]
