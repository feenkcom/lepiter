"
LeDatabaseReloadExamples demonstrates the scenario where a database is opened, the underlying files are changed and the database reloaded.  The database doesn't monitor the file system.  This scenario arises when an image is saved with the database open, the database is then modified without saving the image and the image is opened again.

"
Class {
	#name : #LeDatabaseReloadExamples,
	#superclass : #LeBasicDatabaseReloadExamples,
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #examples }
LeDatabaseReloadExamples >> addAttachedLink [
	"Demonstrate adding a link and reloading the database.
	Load the database a second time, add a link, reload the first database instance and confirm it contains the new link"

	<gtExample>
	<return: #Array>
	| db1 db2 |
	db1 := self createDatabase.
	self populateAttachedLinksIn: db1.
	db2 := LeLocalStoreLoad current
			loadAndMonitorFrom: db1 monitor localRoot
			saveDelay: 0 seconds.

	db2
		addExplicitLink: (LeAttachedLink new
				originReference: (LeLinkPageUidReference forPageUid: (db2 pageNamed: #Page2) uid);
				targetReference: (LeLinkPageUidReference forPageUid: (db2 pageNamed: #Page1) uid)).
	db2 stopMonitoring.

	self deny: db1 explicitLinks size equals: 2.
	self assert: (db1 pageNamed: #Page1) incomingLinks isEmpty.

	db1 reload.
	self assert: db1 explicitLinks size equals: 2.
	self assert: (db1 pageNamed: #Page1) incomingLinks size equals: 1.

	^ {db1.
		db2}
]

{ #category : #examples }
LeDatabaseReloadExamples >> addPage [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page"

	<gtExample>
	<return: #LeDatabase>
	| page db1 db2 announcements |
	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current
			loadAndMonitorFrom: db1 monitor localRoot
			saveDelay: 0 seconds.
	page := LePage named: #Page3.
	page addSnippet: (LeTextSnippet string: #Page3Snippet1).

	db2 addPage: page.
	db2 stopMonitoring.

	announcements := OrderedCollection new.
	db1 weak
		when: LeAnnouncement
		send: #add:
		to: announcements.
	self deny: (db1 hasPageNamed: #Page3).
	db1 reload.

	self assert: (db1 hasPageNamed: #Page3).
	self
		assert: (db1 pageNamed: #Page3) children first string
		equals: #Page3Snippet1.

	self assert: announcements size equals: 1.
	self assert: announcements first class equals: LeDatabasePageAdded.
	self assert: announcements first page title equals: #Page3.

	^ db1
]

{ #category : #examples }
LeDatabaseReloadExamples >> addSnippets [
	"Demonstrate adding snippets at first and last positions and reloading the database"

	<gtExample>
	<return: #LeDatabase>
	| page db1 db2 announcements |
	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current
			loadAndMonitorFrom: db1 monitor localRoot
			saveDelay: 0 seconds.
	page := db2 pageNamed: #Page2.
	page addSnippet: (LeTextSnippet string: #AddedSnippet).
	page addSnippet: (LeTextSnippet string: #'111') before: page children first.
	db2 stopMonitoring.
	page := db1 pageNamed: #Page2.
	self assert: page childrenCount equals: 2.

	announcements := OrderedCollection new.
	db1 weak
		when: LeAnnouncement
		send: #add:
		to: announcements.
	db1 reload.

	self assert: page childrenCount equals: 4.
	self assert: (page children at: 4) string equals: #AddedSnippet.
	self assert: page children first string equals: #'111'.

	self assert: announcements size equals: 3.
	self
		assert: (announcements collect: #class) asArray
		equals: {LeContentTreeAdded.
				LeContentTreeAdded.
				LeContentTreeChanged}.
	self assert: announcements first content string equals: #'111'.
	self assert: announcements second content string equals: #AddedSnippet.

	^ db1
]

{ #category : #examples }
LeDatabaseReloadExamples >> loadDatabaseFromDiskMaintainsLinksUid [
	"Verify that loading a databae from disk maintains the uid for the explicit links container."

	<gtExample>
	<return: #Array>
	| db1 db2 |
	db1 := self createDatabase.
	self populateAttachedLinksIn: db1.
	self assert: db1 explicitLinks uid notNil.

	db2 := LeLocalStoreLoad current
			loadAndMonitorFrom: db1 monitor localRoot
			saveDelay: 0 seconds.

	self assert: db2 explicitLinks uid notNil.
	self assert: db2 explicitLinks uid equals: db1 explicitLinks uid.
	self assert: db1 explicitLinks size equals: 1.
	self assert: db2 explicitLinks size equals: 1.

	^ {db1.
		db2}
]

{ #category : #examples }
LeDatabaseReloadExamples >> loadDatabaseFromDiskWithNoLinks [
	"Verify that loading a database from disk with no links does not update the container uid."

	<gtExample>
	<return: #Array>
	| db1 db2 |
	db1 := self createDatabase.

	db2 := LeLocalStoreLoad current
			loadAndMonitorFrom: db1 monitor localRoot
			saveDelay: 0 seconds.

	self assert: db1 explicitLinks uid isNil.
	self assert: db2 explicitLinks uid isNil.
	self assert: db1 explicitLinks isEmpty.
	self assert: db2 explicitLinks isEmpty.

	^ {db1.
		db2}
]

{ #category : #examples }
LeDatabaseReloadExamples >> modifySnippet [
	"Demonstrate modifying text snippets and reloading the database"

	<gtExample>
	<return: #LeDatabaseReloadExamples>
	| page db1 db2 announcements |
	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current
			loadAndMonitorFrom: db1 monitor localRoot
			saveDelay: 0 seconds.
	(db2 pageNamed: #Page2) children first updateString: #ModifiedSnippet2.
	((db2 pageNamed: #Page2) children at: 2) updateString: #'4+3+2'.
	db2 stopMonitoring.

	page := db1 pageNamed: #Page2.
	self assert: page children first string equals: #Snippet2.
	self assert: (page children at: 2) string equals: #'4+3'.

	announcements := OrderedCollection new.
	db1 weak
		when: LeAnnouncement
		send: #add:
		to: announcements.
	db1 reload.

	self assert: page children first string equals: #ModifiedSnippet2.
	self assert: (page children at: 2) string equals: #'4+3+2'.

	self assert: announcements size equals: 2.
	self
		assert: (announcements collect: #class) asArray
		equals: {LeSnippetTextChanged.
				LeSnippetTextChanged}.
	self assert: announcements first snippet string equals: #ModifiedSnippet2.
	self assert: announcements second snippet string equals: #'4+3+2'
]

{ #category : #private }
LeDatabaseReloadExamples >> populateAttachedLinksIn: aLeDatabase [
	| pageOne pageTwo |
	pageOne := aLeDatabase pageNamed: #Page1.
	pageTwo := aLeDatabase pageNamed: #Page2.
	
	pageOne addExplicitLinkTo: (LeLinkPageUidReference forPageUid: pageTwo uid).
	^ aLeDatabase
]

{ #category : #examples }
LeDatabaseReloadExamples >> reloadUpdatesUserEmail [
	"Confirm that reloading a database updates the userEmail from the lepiter.properties"

	<gtExample>
	<return: #LeDatabaseReloadExamples>
	| db1 properties announcements |
	db1 := self createDatabase.	"Modify the properties so that it doesn't affect db1's instances"
	properties := db1 monitor dbProperties copy.
	properties at: #userEmail put: 'db1-2@example.com'.
	db1 monitor savePropertiesDictionary: properties.	"db1 userEmail should be unchanged"
	self assert: db1 userEmail email equals: 'db1@example.com'.

	announcements := OrderedCollection new.
	db1 weak
		when: LeAnnouncement
		send: #add:
		to: announcements.
	db1 reload.

	self assert: db1 userEmail email equals: 'db1-2@example.com'.

	self assert: announcements size equals: 0
]

{ #category : #examples }
LeDatabaseReloadExamples >> removePage [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page.
	While DB reload doesn't delete pages this test doesn't provide any value.
	It should be re-enabled once the reload has been fixed.  See {{gtClass:LeDatabaseReload}} for additional information."
	"<gtExample>"
	| db1 db2 |

	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current loadAndMonitorFrom: db1 monitor localRoot saveDelay: 0 seconds.
	db2 removePage: (db2 pageNamed: #Page1).
	db2 stopMonitoring.

	self assert: (db1 hasPageNamed: #Page1).
	self assert: (db1 pageNamed: #Page1) children first string equals: #Snippet1.
	db1 reload.
	self deny: (db1 hasPageNamed: #Page1).

]

{ #category : #examples }
LeDatabaseReloadExamples >> removeSnippet [
	"Demonstrate modifying text & pharo snippets and reloading the database"

	<gtExample>
	<return: #LeDatabase>
	| page db1 db2 announcements |
	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current
			loadAndMonitorFrom: db1 monitor localRoot
			saveDelay: 0 seconds.
	page := db2 pageNamed: #Page2.
	page removeSnippet: page children first.
	db2 stopMonitoring.

	page := db1 pageNamed: #Page2.
	self assert: page childrenCount equals: 2.
	self assert: page children first string equals: #Snippet2.
	self assert: (page children at: 2) string equals: #'4+3'.

	announcements := OrderedCollection new.
	db1 weak
		when: LeAnnouncement
		send: #add:
		to: announcements.
	db1 reload.

	self assert: page childrenCount equals: 1.
	self assert: page children first string equals: #'4+3'.

	self assert: announcements size equals: 2.
	self
		assert: (announcements collect: #class) asArray
		equals: {LeContentTreeRemoved.
				LeContentTreeChanged}.
	self assert: announcements first content string equals: #Snippet2.

	^ db1
]

{ #category : #'examples - setup' }
LeDatabaseReloadExamples >> setPageUpdatesPageProperties [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page"

	<gtExample>
	<return: #LeDatabaseReloadExamples>
	| page db1 |
	db1 := self createDatabase.
	page := LePage named: #Page3.
	page addSnippet: (LeTextSnippet string: #Page3Snippet1).
	db1 setPage: page.
	self assert: page uid isNotNil.
	self assert: page createTime isNotNil.
	self assert: page editTime isNotNil.
	self assert: page createEmail equals: db1 userEmail.
	self assert: page editEmail equals: db1 userEmail
]

{ #category : #'examples - setup' }
LeDatabaseReloadExamples >> setPageUpdatesSnippetProperties [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page"

	<gtExample>
	<return: #LeDatabaseReloadExamples>
	| page snippet db1 |
	db1 := self createDatabase.
	page := LePage named: #Page3.
	snippet := page addSnippet: (LeTextSnippet string: #Page3Snippet1).
	db1 setPage: page.
	self assert: snippet uid isNotNil.
	self assert: snippet createTime isNotNil.
	self assert: snippet editTime isNotNil.
	self assert: snippet createEmail equals: db1 userEmail.
	self assert: snippet editEmail equals: db1 userEmail
]

{ #category : #'examples - setup' }
LeDatabaseReloadExamples >> setSnippetUpdatesSnippetProperties [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page"

	<gtExample>
	<return: #LeDatabaseReloadExamples>
	| page newSnippet db1 |
	db1 := self createDatabase.
	page := LePage named: #Page3.
	page addSnippet: (LeTextSnippet string: #Page3Snippet1).
	db1 addPage: page.
	newSnippet := LeTextSnippet string: #Page3Snippet2.
	page addSnippet: newSnippet.
	self assert: newSnippet uid isNotNil.
	self assert: newSnippet createTime isNotNil.
	self assert: newSnippet editTime isNotNil.
	self assert: newSnippet createEmail equals: db1 userEmail.
	self assert: newSnippet editEmail equals: db1 userEmail
]
