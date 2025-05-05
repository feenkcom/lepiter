Class {
	#name : #LeLogicalDatabaseWithDatabaseClassMonitorReloadExamples,
	#superclass : #Object,
	#instVars : [
		'classMonitorExamples',
		'temporaryDirectory'
	],
	#category : #'Lepiter-Store-Class-Examples'
}

{ #category : #after }
LeLogicalDatabaseWithDatabaseClassMonitorReloadExamples >> cleanObjects [
	classMonitorExamples stopMonitor.
	temporaryDirectory ifNotNil: 	
		[ temporaryDirectory ensureDeleteAll ].
]

{ #category : #initialization }
LeLogicalDatabaseWithDatabaseClassMonitorReloadExamples >> initialize [
	super initialize.
	classMonitorExamples := LeDatabaseClassMonitorExamples new.
	temporaryDirectory := FileReference 
		gtNewTempFileLocatorPrefix: self class name, '-' suffix: '-testDbs'.
	temporaryDirectory ensureCreateDirectory.
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseWithDatabaseClassMonitorReloadExamples >> logicalDatabaseWithDatabaseClassMonitorReload [
	"This tests the basic scenario of reloading the primary database and a registered databases when the individual databases use a file locator. This should not create a new instance for any of the existing databases on reload. This example exists as we had bug where were using both file references and file locators to the same folder that were causing databases to be recreated instead of being updated."

	<gtExample>
	<after: #cleanObjects>
	<return: #LeLogicalDatabase>
	| logicalDB primaryDB announcements |
	"Store all the received announcements"
	announcements := OrderedCollection new.

	primaryDB := (classMonitorExamples monitorWithDuration: Duration zero) database.
	primaryDB databaseName: #primary.

	logicalDB := LeLogicalDatabase new.
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB primaryDB: primaryDB.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseUrl: ('class:///{1}/{2}'
						format: {primaryDB monitor dbPackage.
								primaryDB monitor dbClassName}) asZnUrl).	"Confirm that each DB is in the expected state"
	self
		assert: (primaryDB pageNamed: #'Page 1') children first string
		equals: #'Page 1 Paragraph 1'.	"Reload the logical database in place without any changes"
	LeReloadOptimization disableDuring: [ logicalDB primaryDB reload ].	"Confirm that each DB has been reloaded correctly"	"Confirm that each DB has the same page"
	self
		assert: (primaryDB pageNamed: #'Page 1') children first string
		equals: #'Page 1 Paragraph 1'.	"Confirm that each DB has the logical DB as its parent"
	self assert: primaryDB parent equals: logicalDB.

	self assert: announcements size equals: 5.
	self assert: announcements first class equals: LeDatabasesAddedAnnouncement.
	self assert: announcements first database equals: primaryDB.
	self assert: (announcements at: 2) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 3) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 3) database equals: primaryDB.
	self assert: (announcements at: 4) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 4) database equals: primaryDB.
	self assert: (announcements at: 5) class equals: LeLogicalDatabaseReloaded.
	self assert: (announcements at: 5) database equals: logicalDB.	"Ensure that after reload the identity of individual databases did not changed.
	The update should just reload them."
	self
		assert: logicalDB primaryDB == primaryDB
		description: 'The logical database should preserve identity'.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseWithDatabaseClassMonitorReloadExamples >> logicalDatabaseWithDatabaseClassMonitorReload_OptimizedReload [
	"This tests the basic scenario of reloading the primary database and a registered databases when the individual databases use a file locator. This should not create a new instance for any of the existing databases on reload. This example exists as we had bug where were using both file references and file locators to the same folder that were causing databases to be recreated instead of being updated."

	<gtExample>
	<after: #cleanObjects>
	<return: #LeLogicalDatabase>
	| logicalDB primaryDB announcements |
	"Store all the received announcements"
	announcements := OrderedCollection new.

	primaryDB := (classMonitorExamples monitorWithDuration: Duration zero) database.
	primaryDB databaseName: #primary.

	logicalDB := LeLogicalDatabase new.
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB primaryDB: primaryDB.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseUrl: ('class:///{1}/{2}'
						format: {primaryDB monitor dbPackage.
								primaryDB monitor dbClassName}) asZnUrl).	"Confirm that each DB is in the expected state"
	self
		assert: (primaryDB pageNamed: #'Page 1') children first string
		equals: #'Page 1 Paragraph 1'.	"Reload the logical database in place without any changes"
	LeReloadOptimization enableDuring: [ logicalDB primaryDB reload ].	"Confirm that each DB has been reloaded correctly"	"Confirm that each DB has the same page"
	self
		assert: (primaryDB pageNamed: #'Page 1') children first string
		equals: #'Page 1 Paragraph 1'.	"Confirm that each DB has the logical DB as its parent"
	self assert: primaryDB parent equals: logicalDB.

	self assert: announcements size equals: 3.
	self assert: announcements first class equals: LeDatabasesAddedAnnouncement.
	self assert: announcements first database equals: primaryDB.
	self assert: (announcements at: 2) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 3) class equals: LeLogicalDatabaseReloaded.
	self assert: (announcements at: 3) database equals: logicalDB.	"Ensure that after reload the identity of individual databases did not changed.
	The update should just reload them."
	self
		assert: logicalDB primaryDB == primaryDB
		description: 'The logical database should preserve identity'.

	^ logicalDB
]
