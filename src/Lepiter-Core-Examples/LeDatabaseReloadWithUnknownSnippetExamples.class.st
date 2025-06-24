Class {
	#name : #LeDatabaseReloadWithUnknownSnippetExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #examples }
LeDatabaseReloadWithUnknownSnippetExamples >> reloadPageInDatabaseWithUnknownSnippetChangeOnDisk [
	<gtExample>
	<noTest>
	| memStore database page jsonSnippet pageFile loadedPage loadedSnippet |

	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.

	database := LeLocalStoreLoad current 
		loadAndMonitorFrom: memStore 
		saveDelay: 0 seconds.
	page := LePage named: #page1.
	page addSnippet: (LeTextSnippet string: #snipept1).
	database addPage: page.
	
	pageFile := database monitor pageFileReference: page.
	jsonSnippet := STONJSON fromString: pageFile contents.
	((jsonSnippet at: #children) at: #items) first 
		at: '__type' 
		put: 'aSnippetThatIsNotKnow'.
	
	pageFile ensureDelete.
	self assert: pageFile exists not.
	
	pageFile writeStreamDo: [ :aStream |
		STONJSON put: jsonSnippet onStream: aStream ].
	
	database monitor reload.
	
	loadedPage := database pageNamed: #page1.
	loadedSnippet := loadedPage children first.
	self assert: loadedSnippet class equals: LeUnknownSnippet.
	self assert: loadedSnippet uid notNil.
	self assert: loadedSnippet createTime notNil.
	self assert: loadedSnippet editTime notNil.
	
	^ database
]

{ #category : #examples }
LeDatabaseReloadWithUnknownSnippetExamples >> reloadPageWithUnknownSnippet [
	"Confirm that attachment properties don't include personal information when saved to disk"

	<gtExample>
	<return: #LeDatabase>
	| memStore database page jsonSnippet pageFile loadedPage loadedSnippet |
	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.

	database := LeLocalStoreLoad current
			loadAndMonitorFrom: memStore
			saveDelay: 0 seconds.
	page := LePage named: #page1.
	page addSnippet: (LeTextSnippet string: #snipept1).
	database addPage: page.

	pageFile := database monitor pageFileReference: page.
	jsonSnippet := STONJSON fromString: pageFile contents.
	((jsonSnippet at: #children) at: #items) first
		at: '__type'
		put: 'aSnippetThatIsNotKnow'.

	database removePage: page.
	self assert: pageFile exists not.

	pageFile
		writeStreamDo: [ :aStream | STONJSON put: jsonSnippet onStream: aStream ].

	database monitor reload.

	loadedPage := database pageNamed: #page1.
	loadedSnippet := loadedPage children first.
	self assert: loadedSnippet class equals: LeUnknownSnippet.
	self assert: loadedSnippet uid notNil.
	self assert: loadedSnippet createTime notNil.
	self assert: loadedSnippet editTime notNil.

	^ database
]
