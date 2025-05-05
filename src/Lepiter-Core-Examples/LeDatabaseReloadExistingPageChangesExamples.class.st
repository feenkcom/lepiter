Class {
	#name : #LeDatabaseReloadExistingPageChangesExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #'asserting - structure' }
LeDatabaseReloadExistingPageChangesExamples >> assertLocalPageStructureChange: aStructureChange inDatabase: aDatabase [
	<gtExample>
	| initialPage secondDatabase modifiedPage structureChange |
	initialPage := aDatabase pageNamed: 'Target Page'.

	secondDatabase := self createDatabaseFromFolder: aDatabase localStoreRootDirectory.
	modifiedPage := secondDatabase pageNamed: 'Target Page'.
	
	structureChange := initialPage detectStructureChangeTypeToPage: modifiedPage.
	self assert: structureChange equals: aStructureChange.
]

{ #category : #'examples - children snippets order' }
LeDatabaseReloadExistingPageChangesExamples >> changedChildrenSnippetsOrderInStorage [
	"The initial page has these snippets:
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
	<return: #LeDatabase>
	| database secondDatabase targetPage firstSnippet |
	database := self createDatabaseWithChildrenSnippetStructure.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
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

{ #category : #'examples - children snippets order' }
LeDatabaseReloadExistingPageChangesExamples >> changedChildrenSnippetsOrderInStorage_hasPageStructureChange [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changedChildrenSnippetsOrderInStorage.
	self
		assertLocalPageStructureChange: LePageComplexStructureChange
		inDatabase: database.

	^ database
]

{ #category : #'examples - nested snippets' }
LeDatabaseReloadExistingPageChangesExamples >> changedDatabaseWithFourNestedSnippetToTwoInStorage [
	"The initial page has three snippets:
	  A
	    B
	      C
	        D
	
	We change this to:
	  D
       B"

	<gtExample>
	<return: #LeDatabase>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFourNestedSnippetStructure.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target Page'.

	targetPage children first children first unindent.
	targetPage children first removeSelf.
	targetPage children first children first unindent.
	targetPage children second children first unindent.
	targetPage children second removeSelf.

	targetPage children second moveUp.
	targetPage children second indent.

	self assert: targetPage children size equals: 1.
	self assert: targetPage children first string equals: 'D'.
	self assert: targetPage children first children first string equals: 'B'.

	secondDatabase stopMonitoring.

	^ database
]

{ #category : #'examples - flat snippet structure change' }
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
	<return: #LeDatabase>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFlatSnippetStructure.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
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

{ #category : #'examples - flat snippet structure change' }
LeDatabaseReloadExistingPageChangesExamples >> changedFlatSnippetStructureInStorage_explicitPageReloadWorks [
	<gtExample>
	<return: #LeDatabase>
	| database secondDatabase targetPage referencePage pageAsseambler |
	database := self changedFlatSnippetStructureInStorage.
	targetPage := database pageNamed: 'Target Page'.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
	referencePage := secondDatabase pageNamed: 'Target Page'.

	pageAsseambler := LePageStructureAsseambler new targetPage: targetPage.
	pageAsseambler rebuildStructureBasedOnPage: referencePage.

	self assert: targetPage children size equals: 3.
	self assert: targetPage children first string equals: 'A'.
	self assert: targetPage children second string equals: 'B1'.
	self assert: targetPage children third string equals: 'C'.
	self assert: targetPage children second children first string equals: 'B'.

	^ database
]

{ #category : #'examples - flat snippet order change' }
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
	<return: #LeDatabase>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFlatSnippetStructure.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
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

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> changedFlatSnippetsOrderInStorage_hasPageStructureChange [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changedFlatSnippetsOrderInStorage.
	self
		assertLocalPageStructureChange: LePageComplexStructureChange
		inDatabase: database.

	^ database
]

{ #category : #'examples - flat snippet order change' }
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
	<return: #LeDatabase>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFlatSnippetStructure.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target Page'.

	targetPage children first
		moveDown;
		moveDown.
	targetPage children first moveDown.
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

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> changedFlatSnippetsOrderWithSnippetAdditionInStorage_hasPageStructureChange [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changedFlatSnippetsOrderWithSnippetAdditionInStorage.
	self
		assertLocalPageStructureChange: LePageComplexStructureChange
		inDatabase: database.

	^ database
]

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> changedFlatSnippetsOrderWithSnippetDeletionInStorage [
	"The initial page has three snippets:
	  A
	  B
	  C
	
	We change this to:
	  C
     B"

	<gtExample>
	<return: #LeDatabase>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFlatSnippetStructure.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target Page'.

	targetPage children first removeSelf.
	targetPage children first moveDown.

	self assert: targetPage children size equals: 2.
	self assert: targetPage children first string equals: 'C'.
	self assert: targetPage children second string equals: 'B'.

	secondDatabase stopMonitoring.

	^ database
]

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> changedFlatSnippetsOrderWithSnippetDeletionInStorage_hasPageStructureChange [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changedFlatSnippetsOrderWithSnippetDeletionInStorage.
	self
		assertLocalPageStructureChange: LePageComplexStructureChange
		inDatabase: database.

	^ database
]

{ #category : #'examples - no structure change' }
LeDatabaseReloadExistingPageChangesExamples >> changedSnippetContentInStorage [
	"The initial page has three snippets:
	  A
	  B
	  C
	
	We change this to:
	  A
	  BB (same identiy as B)
	  C"

	<gtExample>
	<return: #LeDatabase>
	| database secondDatabase targetPage |
	database := self createDatabaseWithFlatSnippetStructure.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target Page'.
	targetPage children second updateString: 'BB'.
	secondDatabase stopMonitoring.

	^ database
]

{ #category : #'examples - no structure change' }
LeDatabaseReloadExistingPageChangesExamples >> changedSnippetContentInStorage_hasNoPageStructureChange [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changedSnippetContentInStorage.
	self
		assertLocalPageStructureChange: LePageNoStructureChange
		inDatabase: database.

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
	<return: #LeDatabase>
	| database page |
	database := self databaseWithMockedStorage.

	page := LePage named: 'Target Page'.
	page addSnippet: (LeTextSnippet string: 'A').
	page addSnippet: (LeTextSnippet string: 'B').

	page children first
		addSnippet: (LeTextSnippet string: 'A1');
		addSnippet: (LeTextSnippet string: 'A2');
		addSnippet: (LeTextSnippet string: 'A3').

	self assert: page children size equals: 2.
	self assert: page children first children size equals: 3.
	database addPage: page.

	^ database
]

{ #category : #'examples - flat snippet structure change' }
LeDatabaseReloadExistingPageChangesExamples >> createDatabaseWithFlatSnippetStructure [
	<gtExample>
	<return: #LeDatabase>
	| database page |
	database := self databaseWithMockedStorage.

	page := LePage named: 'Target Page'.
	page addSnippet: (LeTextSnippet string: 'A').
	page addSnippet: (LeTextSnippet string: 'B').
	page addSnippet: (LeTextSnippet string: 'C').

	self assert: page children size equals: 3.
	database addPage: page.
	self assert: database snippetsCount equals: 3.

	^ database
]

{ #category : #'examples - no structure change' }
LeDatabaseReloadExistingPageChangesExamples >> createDatabaseWithFlatSnippetStructure_hasNoPageStructureChange [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self createDatabaseWithFlatSnippetStructure.
	self
		assertLocalPageStructureChange: LePageNoStructureChange
		inDatabase: database.

	^ database
]

{ #category : #'examples - nested snippets' }
LeDatabaseReloadExistingPageChangesExamples >> createDatabaseWithFourNestedSnippetStructure [
	<gtExample>
	<return: #LeDatabase>
	| database page |
	database := self databaseWithMockedStorage.

	page := LePage named: 'Target Page'.
	page
		addSnippet: ((LeTextSnippet string: 'A')
				addSnippet: ((LeTextSnippet string: 'B')
						addSnippet: ((LeTextSnippet string: 'C')
								addSnippet: (LeTextSnippet string: 'D');
								yourself);
						yourself);
				yourself).

	self assert: page children size equals: 1.
	database addPage: page.
	self assert: database snippetsCount equals: 4.

	^ database
]

{ #category : #'examples - page rename' }
LeDatabaseReloadExistingPageChangesExamples >> createDatabaseWithNamedPageA [
	<gtExample>
	<return: #LeDatabase>
	| database page |
	database := self databaseWithMockedStorage.

	page := LePage named: 'Target PageA'.
	page addSnippet: (LeTextSnippet string: 'Snippet A').

	database addPage: page.
	self assert: database snippetsCount equals: 1.
	self assert: database pageCount equals: 1.

	^ database
]

{ #category : #'examples - page rename' }
LeDatabaseReloadExistingPageChangesExamples >> createDatabaseWithUnnamedPage [
	<gtExample>
	<return: #LeDatabase>
	| database page |
	database := self databaseWithMockedStorage.

	page := LePage unnamedPage.
	page addSnippet: (LeTextSnippet string: 'Snippet A').

	database addPage: page.
	self assert: database snippetsCount equals: 1.
	self assert: database pageCount equals: 1.

	^ database
]

{ #category : #examples }
LeDatabaseReloadExistingPageChangesExamples >> databaseWithMockedStorage [
	<gtExample>
	<return: #LeDatabase>
	| folderReference localStore |
	folderReference := FileSystem memory / 'storage'.
	folderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad new
			storage: LeMockLocalJsonV4StorageWithFilesOrder new.
	localStore localRoot: folderReference.
	^ localStore loadAndMonitorFrom: folderReference saveDelay: Duration zero
]

{ #category : #'examples - children snippets order' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedChildrenSnippetsOrderInStorage [
	<gtExample>
	<return: #LeDatabase>
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
	<return: #LeDatabase>
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

{ #category : #'examples - nested snippets' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedDatabaseWithFourNestedSnippetToTwoInStorage [
	<gtExample>
	<return: #LeDatabase>
	| database targetPage |
	database := self changedDatabaseWithFourNestedSnippetToTwoInStorage.

	database reload.

	targetPage := database pageNamed: 'Target Page'.

	self assert: database snippetsCount equals: 2.
	self assert: targetPage children size equals: 1.
	self assert: targetPage children first string equals: 'D'.
	self assert: targetPage children first children first string equals: 'B'.

	^ database
]

{ #category : #'examples - nested snippets' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedDatabaseWithFourNestedSnippetToTwoInStorage_hasSameIdentity [
	<gtExample>
	<return: #LeDatabase>
	| database targetPage snippetA snippetB snippetC snippetD |
	database := self changedDatabaseWithFourNestedSnippetToTwoInStorage.

	targetPage := database pageNamed: 'Target Page'.
	snippetA := targetPage children first.
	snippetB := snippetA children first.
	snippetC := snippetB children first.
	snippetD := snippetC children first.

	database reload.

	self assert: targetPage children first == snippetD.
	self assert: targetPage children first children first == snippetB.

	^ database
]

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedFlatSnippetsOrderWithSnippetAdditionInStorage [
	<gtExample>
	<return: #LeDatabase>
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

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedFlatSnippetsOrderWithSnippetAdditionInStorage_hasSameIdentity [
	<gtExample>
	<return: #LeDatabase>
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

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedFlatSnippetsOrderWithSnippetDeletionInStorage [
	<gtExample>
	<return: #LeDatabase>
	| database targetPage |
	database := self changedFlatSnippetsOrderWithSnippetDeletionInStorage.

	database reload.

	targetPage := database pageNamed: 'Target Page'.

	self assert: targetPage children size equals: 2.
	self assert: targetPage children first string equals: 'C'.
	self assert: targetPage children second string equals: 'B'.

	^ database
]

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadChangedFlatSnippetsOrderWithSnippetDeletionInStorage_hasSameIdentity [
	<gtExample>
	<return: #LeDatabase>
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

{ #category : #'examples - no structure change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadDatabaseWithNoChange [
	<gtExample>
	<return: #LeDatabase>
	| database targetPage |
	database := self createDatabaseWithFlatSnippetStructure.

	targetPage := database pageNamed: 'Target Page'.
	database reload.

	self assert: targetPage children size equals: 3.
	self assert: targetPage children first string equals: 'A'.
	self assert: targetPage children second string equals: 'B'.
	self assert: targetPage children third string equals: 'C'.

	^ database
]

{ #category : #'examples - no structure change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadDatabaseWithSnippetContentChange [
	<gtExample>
	<return: #LeDatabase>
	| database targetPage |
	database := self changedSnippetContentInStorage.

	targetPage := database pageNamed: 'Target Page'.
	database reload.

	self assert: targetPage children size equals: 3.
	self assert: targetPage children first string equals: 'A'.
	self assert: targetPage children second string equals: 'BB'.
	self assert: targetPage children third string equals: 'C'.

	^ database
]

{ #category : #'examples - flat snippet structure change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadModifiedFlatSnippetStructureFromStorage [
	<gtExample>
	<return: #LeDatabase>
	| database targetPage |
	database := self changedFlatSnippetStructureInStorage.

	database reload.

	targetPage := database pageNamed: 'Target Page'.

	self assert: database snippetsCount equals: 4.
	self assert: targetPage children size equals: 3.
	self assert: targetPage children first string equals: 'A'.
	self assert: targetPage children second string equals: 'B1'.
	self assert: targetPage children second children first string equals: 'B'.
	self assert: targetPage children third string equals: 'C'.

	^ database
]

{ #category : #'examples - flat snippet structure change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadModifiedFlatSnippetStructureFromStorage_hasPageStructureChange [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changedFlatSnippetStructureInStorage.
	self
		assertLocalPageStructureChange: LePageComplexStructureChange
		inDatabase: database.

	^ database
]

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadModifiedFlatSnippetsOrderFromStorage [
	<gtExample>
	<return: #LeDatabase>
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

{ #category : #'examples - flat snippet order change' }
LeDatabaseReloadExistingPageChangesExamples >> reloadModifiedFlatSnippetsOrderFromStorage_hasSameIdentity [
	<gtExample>
	<return: #LeDatabase>
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

{ #category : #'examples - page rename' }
LeDatabaseReloadExistingPageChangesExamples >> reloadNamedPageAToUnnamedPage [
	<gtExample>
	<return: #LeDatabase>
	| database targetPage |
	database := self renameNamedPageAToUnnamedPage.

	database reload.
	self assert: (database hasPageNamed: 'Target PageA') not.
	self assert: database unnamedPagesByUid isNotEmpty.

	targetPage := database unnamedPagesByUid anyOne.
	self assert: database snippetsCount equals: 1.

	^ database
]

{ #category : #'examples - page rename' }
LeDatabaseReloadExistingPageChangesExamples >> reloadRenamedPageBFromStorage [
	<gtExample>
	<return: #LeDatabase>
	| database targetPage |
	database := self renamePageAToPageB.

	database reload.
	self assert: (database hasPageNamed: 'Target PageB').
	self assert: (database hasPageNamed: 'Target PageA') not.

	targetPage := database pageNamed: 'Target PageB'.
	self assert: database snippetsCount equals: 1.

	^ database
]

{ #category : #'examples - page rename' }
LeDatabaseReloadExistingPageChangesExamples >> reloadUnnamedPageToNamedPageA [
	<gtExample>
	<return: #LeDatabase>
	| database targetPage |
	database := self renameUnnamedPageToNamedPageA.

	database reload.
	self assert: (database hasPageNamed: 'Target PageA').
	self assert: database unnamedPagesByUid isEmpty.

	targetPage := database pageNamed: 'Target PageA'.
	self assert: database snippetsCount equals: 1.

	^ database
]

{ #category : #'examples - page rename' }
LeDatabaseReloadExistingPageChangesExamples >> renameNamedPageAToUnnamedPage [
	"We rename the page in the database to unnamed"

	<gtExample>
	<return: #LeDatabase>
	| database secondDatabase targetPage |
	database := self createDatabaseWithNamedPageA.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pages first.

	targetPage updateTitle: ''.

	self assert: secondDatabase unnamedPagesByUid isNotEmpty.
	self assert: secondDatabase pagesByName isEmpty.
	secondDatabase stopMonitoring.

	^ database
]

{ #category : #'examples - page rename' }
LeDatabaseReloadExistingPageChangesExamples >> renamePageAToPageB [
	"We rename the page in the database"

	<gtExample>
	<return: #LeDatabase>
	| database secondDatabase targetPage |
	database := self createDatabaseWithNamedPageA.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pageNamed: 'Target PageA'.

	targetPage updateTitle: 'Target PageB'.

	self assert: (secondDatabase hasPageNamed: 'Target PageB').
	self assert: (secondDatabase hasPageNamed: 'Target PageA') not.
	secondDatabase stopMonitoring.

	^ database
]

{ #category : #'examples - page rename' }
LeDatabaseReloadExistingPageChangesExamples >> renameUnnamedPageToNamedPageA [
	"We rename the page in the database"

	<gtExample>
	<return: #LeDatabase>
	| database secondDatabase targetPage |
	database := self createDatabaseWithUnnamedPage.

	secondDatabase := self
			createDatabaseFromFolder: database localStoreRootDirectory.
	targetPage := secondDatabase pages first.

	targetPage updateTitle: 'Target PageA'.

	self assert: (secondDatabase hasPageNamed: 'Target PageA').
	self assert: secondDatabase unnamedPagesByUid isEmpty.
	secondDatabase stopMonitoring.

	^ database
]
