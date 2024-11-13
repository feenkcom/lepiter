Class {
	#name : #LeDatabaseClassExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'database',
		'monitor'
	],
	#category : #'Lepiter-Store-Class-Examples'
}

{ #category : #accessing }
LeDatabaseClassExamples class >> testDataLocation [
	"Answer the location of the test data based on the git repository"
	| fileReference |
	
	fileReference := (GtResourceReference path: Path 
		* 'feenkcom' 
		/ 'lepiter' 
		/ 'test-data') fileReference.
	self assert: fileReference exists.
	^ fileReference.
]

{ #category : #private }
LeDatabaseClassExamples >> createDatabase [
	"Reset the receiver and create a sample database"
	| page1 page2 page3 page4 |

	database := LeDatabase new.
	page1 := database pageBuilder
		title: 'Page 1';
		add.
	page1 snippetBuilder
		string: 'Page 1 Paragraph 1';
		add.
	page2 := database pageBuilder
		title: 'Page 2';
		add.
	page2 snippetBuilder
		string: 'Page 2 Paragraph 1';
		add.
	page2 snippetBuilder
		string: 'Page 2 link to [[Page 1]]';
		add.
	page3 := database pageBuilder
		title: 'Page 3';
		add.
	page3 snippetBuilder
		string: 'Page 3 Paragraph 1';
		add.
	page4 := database pageBuilder
		title: 'Page 4';
		add.
	page4 snippetBuilder
		string: 'Pharo snippet follows';
		add.
	page4 addSnippet: (LePharoSnippet new code: '42 inspect').
	^ database
]

{ #category : #private }
LeDatabaseClassExamples >> dbClassName [

	^ #LeClassDatabaseMonitorExamplesDb
]

{ #category : #private }
LeDatabaseClassExamples >> dbPackageName [

	^ 'LepiterExamples-Temporary'
]

{ #category : #private }
LeDatabaseClassExamples >> exportedDatabase [
	"Create and export the database"

	self class environment
		at: self dbClassName
		ifPresent: [ :aClass | aClass removeFromSystem ].
	self createDatabase.
	EpMonitor disableDuring:
		[ LeDatabaseClassStoreExport current 
			database: database;
			dbClassName: self dbClassName package: self dbPackageName;
			export ].
	^ database
]

{ #category : #private }
LeDatabaseClassExamples >> importedDatabase [
	"Answer the sample database as imported"

	self exportedDatabase.
	database := nil.
	^ database := LeDatabaseClassStoreLoad current loadFrom: self dbClassName package: self dbPackageName
]

{ #category : #private }
LeDatabaseClassExamples >> monitorWithDuration: aDuration [
	self exportedDatabase.
	database := nil.
	database := LeDatabaseClassStoreLoad current 
		loadFrom: self dbClassName 
		package: self dbPackageName
		saveDelay: aDuration.
	monitor := database monitor.
	^ monitor
]

{ #category : #after }
LeDatabaseClassExamples >> stopMonitor [
	monitor ifNotNil: [ :aMonitor |
		aMonitor stopMonitoring ]
]

{ #category : #accessing }
LeDatabaseClassExamples >> testDataLocation [

	^ self class testDataLocation
]
