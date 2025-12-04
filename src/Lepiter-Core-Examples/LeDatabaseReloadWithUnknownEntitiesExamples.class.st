Class {
	#name : #LeDatabaseReloadWithUnknownEntitiesExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #examples }
LeDatabaseReloadWithUnknownEntitiesExamples >> loadNewPageWithUnknownPageType [
	<gtExample>
	<return: #LeDatabase>
	| memStore database page jsonSnippet pageFile loadedPage loadedSnippet |
	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.

	database := LeLocalStoreLoad current
			loadAndMonitorFrom: memStore
			saveDelay: 0 seconds.
	page := LePage named: 'page1'.
	page addSnippet: (LeTextSnippet string: 'snipept1').
	database addPage: page.

	pageFile := database monitor pageFileReference: page.
	jsonSnippet := STONJSON fromString: pageFile contents.
	(jsonSnippet at: 'pageType') 
		at: '__type'
		put: 'anUnknownPageType'.

	database removePage: page.
	self assert: pageFile exists not.

	pageFile
		writeStreamDo: [ :aStream | STONJSON put: jsonSnippet onStream: aStream ].

	"When reloading the page is added to the database as as a new page"
	database monitor reload.
	self assert: database pages size equals: 1.
	self assert: database pagesByName  size equals: 0.
	self assert: database pagesByUnknownPageType  size equals: 1.
	
	loadedPage := database pages first.
	self assert: loadedPage type isUnknownPageType.
	self assert: loadedPage type map equals: (((GtStringContentDictionary new) 
		add: ('title'->'page1'); 
		add: ('__type'->'anUnknownPageType'); 
		yourself)).
	
	loadedSnippet := loadedPage children first.
	self assert: loadedSnippet class equals: LeTextSnippet.
	self assert: loadedSnippet uid notNil.
	self assert: loadedSnippet createTime notNil.
	self assert: loadedSnippet editTime notNil.

	^ database
]

{ #category : #examples }
LeDatabaseReloadWithUnknownEntitiesExamples >> loadNewPageWithUnknownSnippet [
	<gtExample>
	<return: #LeDatabase>
	| memStore database page jsonSnippet pageFile loadedPage loadedSnippet |
	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.

	database := LeLocalStoreLoad current
			loadAndMonitorFrom: memStore
			saveDelay: 0 seconds.
			
	"We create a first a page on disk with the snippet type changes"
	page := LePage named: 'page1'.
	page addSnippet: (LeTextSnippet string: 'snipept1').
	database addPage: page.

	pageFile := database monitor pageFileReference: page.
	jsonSnippet := STONJSON fromString: pageFile contents.
	((jsonSnippet at: 'children') at: 'items') first
		at: '__type'
		put: 'aSnippetThatIsNotKnow'.

	database removePage: page.
	self assert: pageFile exists not.

	pageFile
		writeStreamDo: [ :aStream | STONJSON put: jsonSnippet onStream: aStream ].

	"When reloading the page is loaded into the database as a new page"
	database monitor reload.

	loadedPage := database pageNamed: 'page1'.
	loadedSnippet := loadedPage children first.
	self assert: loadedSnippet class equals: LeUnknownSnippet.
	self assert: loadedSnippet uid notNil.
	self assert: loadedSnippet createTime notNil.
	self assert: loadedSnippet editTime notNil.

	^ database
]

{ #category : #examples }
LeDatabaseReloadWithUnknownEntitiesExamples >> reloadPageInDatabaseWithResolvingUnknownPageType [
	<gtExample>
	| database page jsonSnippet pageFile loadedPage loadedSnippet |
	
	database := self loadNewPageWithUnknownPageType.
	page := database pages first.
	
	"We resolve the type of the unknown page type on disk"
	pageFile := database monitor pageFileReference: page.
	jsonSnippet := STONJSON fromString: pageFile contents.
	(jsonSnippet at: 'pageType') 
		at: '__type'
		put: 'namedPage'.
	
	pageFile ensureDelete.
	self assert: pageFile exists not.
	
	pageFile writeStreamDo: [ :aStream |
		STONJSON put: jsonSnippet onStream: aStream ].
	
	"When reloading the unknown snippet type should resolve to a known one"
	database monitor reload.
	self assert: database pages size equals: 1.
	self assert: database pagesByName  size equals: 1.
	self assert: database pagesByUnknownPageType  size equals: 0.
	
	loadedPage := database pages first.
	self assert: loadedPage type isNamedPageType.
	self assert: loadedPage type title equals: 'page1'.
	
	loadedSnippet := loadedPage children first.
	self assert: loadedSnippet class equals: LeTextSnippet.
	self assert: loadedSnippet uid notNil.
	self assert: loadedSnippet createTime notNil.
	self assert: loadedSnippet editTime notNil.
	
	^ database
]

{ #category : #examples }
LeDatabaseReloadWithUnknownEntitiesExamples >> reloadPageInDatabaseWithResolvingUnknownSnippetType [
	<gtExample>
	| database page jsonSnippet pageFile loadedPage loadedSnippet |
	
	database := self loadNewPageWithUnknownSnippet.
	page := database pages first.
	
	"We resolve the type of the unknown snippet on disk"
	pageFile := database monitor pageFileReference: page.
	jsonSnippet := STONJSON fromString: pageFile contents.
	((jsonSnippet at: 'children') at: 'items') first 
		at: '__type' 
		put: 'textSnippet'.
	
	pageFile ensureDelete.
	self assert: pageFile exists not.
	
	pageFile writeStreamDo: [ :aStream |
		STONJSON put: jsonSnippet onStream: aStream ].
	
	"When reloading the unknown snippet type should resolve to a known one"
	database monitor reload.
	
	loadedPage := database pageNamed: 'page1'.
	loadedSnippet := loadedPage children first.
	self assert: loadedSnippet class equals: LeTextSnippet.
	self assert: loadedSnippet string equals: 'snipept1'.
	self assert: loadedSnippet uid notNil.
	self assert: loadedSnippet createTime notNil.
	self assert: loadedSnippet editTime notNil.
	
	^ database
]

{ #category : #examples }
LeDatabaseReloadWithUnknownEntitiesExamples >> reloadPageInDatabaseWithUnknownPageTypeChangeOnDisk [
	<gtExample>
	| memStore database page jsonSnippet pageFile loadedPage loadedSnippet |

	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.

	database := LeLocalStoreLoad current 
		loadAndMonitorFrom: memStore 
		saveDelay: 0 seconds.
	page := LePage named: 'page1'.
	page addSnippet: (LeTextSnippet string: 'snipept1').
	database addPage: page.
	
	pageFile := database monitor pageFileReference: page.
	jsonSnippet := STONJSON fromString: pageFile contents.
	(jsonSnippet at: 'pageType') 
		at: '__type'
		put: 'anUnknownPageType'.
	
	pageFile ensureDelete.
	self assert: pageFile exists not.
	
	pageFile writeStreamDo: [ :aStream |
		STONJSON put: jsonSnippet onStream: aStream ].
	
	database monitor reload.
	self assert: database pages size equals: 1.
	self assert: database pagesByName  size equals: 0.
	self assert: database pagesByUnknownPageType  size equals: 1.
	
	loadedPage := database pages first.
	self assert: loadedPage type isUnknownPageType.
	self assert: loadedPage type map equals: (((GtStringContentDictionary new) 
		add: ('title'->'page1'); 
		add: ('__type'->'anUnknownPageType'); 
		yourself)).
	
	loadedSnippet := loadedPage children first.
	self assert: loadedSnippet class equals: LeTextSnippet.
	self assert: loadedSnippet uid notNil.
	self assert: loadedSnippet createTime notNil.
	self assert: loadedSnippet editTime notNil.
	
	^ database
]

{ #category : #examples }
LeDatabaseReloadWithUnknownEntitiesExamples >> reloadPageInDatabaseWithUnknownSnippetChangeOnDisk [
	<gtExample>
	<noTest>
	| memStore database page jsonSnippet pageFile loadedPage loadedSnippet |

	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.

	database := LeLocalStoreLoad current 
		loadAndMonitorFrom: memStore 
		saveDelay: 0 seconds.
	page := LePage named: 'page1'.
	page addSnippet: (LeTextSnippet string: 'snipept1').
	database addPage: page.
	
	pageFile := database monitor pageFileReference: page.
	jsonSnippet := STONJSON fromString: pageFile contents.
	((jsonSnippet at: 'children') at: 'items') first 
		at: '__type' 
		put: 'aSnippetThatIsNotKnow'.
	
	pageFile ensureDelete.
	self assert: pageFile exists not.
	
	pageFile writeStreamDo: [ :aStream |
		STONJSON put: jsonSnippet onStream: aStream ].
	
	database monitor reload.
	
	loadedPage := database pageNamed: 'page1'.
	loadedSnippet := loadedPage children first.
	self assert: loadedSnippet class equals: LeUnknownSnippet.
	self assert: loadedSnippet uid notNil.
	self assert: loadedSnippet createTime notNil.
	self assert: loadedSnippet editTime notNil.
	
	^ database
]
