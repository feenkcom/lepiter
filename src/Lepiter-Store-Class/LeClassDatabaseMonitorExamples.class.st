Class {
	#name : #LeClassDatabaseMonitorExamples,
	#superclass : #LeClassDatabaseExamples,
	#instVars : [
		'monitor'
	],
	#category : #'Lepiter-Store-Class-Examples'
}

{ #category : #private }
LeClassDatabaseMonitorExamples >> createDatabase [
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

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> databaseRoundTrip [
	<gtExample>
	| page1 page2 page4 snippet imported link links |

	imported := self importedDatabase.

	self assert: imported size equals: 4.
	self assert: imported linksCount equals: 1.
	page1 := imported pageNamed: 'Page 1'.
	page2 := imported pageNamed: 'Page 2'.
	links := imported scanForLinksTo: page1.
	self assert: links size equals: 1.
	link := links first.
	self assert: link origin equals: page2 children items second.
	self assert: link target equals: page1.
	self assert: page1 incomingLinks size equals: 1.

	page4 := imported pageNamed: 'Page 4'.
	self assert: page4 childrenCount equals: 2.
	snippet := page4 children at: 2.
	self assert: snippet code equals: '42 inspect'.

	^ database
]

{ #category : #private }
LeClassDatabaseMonitorExamples >> dbClassName [

	^ #LeClassDatabaseMonitorExamplesDb
]

{ #category : #private }
LeClassDatabaseMonitorExamples >> dbPackageName [

	^ 'LepiterExamples-Temporary'
]

{ #category : #private }
LeClassDatabaseMonitorExamples >> exportedDatabase [
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
LeClassDatabaseMonitorExamples >> importedDatabase [
	"Answer the sample database as imported"

	self exportedDatabase.
	database := nil.
	^ database := LeDatabaseClassStoreLoad current loadFrom: self dbClassName package: self dbPackageName
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorBlockAdded [
	<gtExample>
	| page3 page3FromFile |

	self monitorWithDuration: Duration zero.
	page3 := database pageNamed: 'Page 3'.
	self assert: page3 children size equals: 1.
	page3 snippetBuilder string: 'Page 3 Added Paragraph 1'; add.
	page3FromFile := monitor reloadPage: page3.
	self assert: page3FromFile children size equals: 2.
	self assert: page3FromFile children items second string
			equals: 'Page 3 Added Paragraph 1'.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorBlockModified [
	<gtExample>
	| page3 page3FromFile block31 |

	self monitorWithDuration: Duration zero.
	page3 := database pageNamed: 'Page 3'.
	self assert: page3 children size equals: 1.
	block31 := page3 children first.
	block31 updateText: (block31 text copy append: '. Append 1.' asRopedText).
	page3FromFile := monitor reloadPage: page3.
	self assert: page3FromFile children size equals: 1.
	self assert: page3FromFile children items first string
			equals: 'Page 3 Paragraph 1. Append 1.'.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorBlockRemoved [
	<gtExample>
	| page2 page2FromFile block21 |

	self monitorWithDuration: Duration zero.
	page2 := database pageNamed: 'Page 2'.
	self assert: page2 children size equals: 2.
	block21 := page2 children first.
	block21 removeSelf.
	self assert: page2 children size equals: 1.
	page2FromFile := monitor reloadPage: page2.
	self assert: page2FromFile children size equals: 1.
	self assert: page2FromFile children items first string
			equals: 'Page 2 link to [[Page 1]]'.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorExplicitLinkBetweenPagesAdded [
	<gtExample>
	| page1 page2 explicitLink explicitLinks explicitLinksReloaded |
	
	self monitorWithDuration: Duration zero.
	page1 := database pageNamed: 'Page 1'.
	page2 := database pageNamed: 'Page 2'.
	
	explicitLink := LeAttachedLink new 
		originReference: (LeLinkPageUidReference forPage: page1);
		targetReference: (LeLinkPageUidReference forPage: page2).
	
	explicitLinks := monitor explicitLinksOrNil.
	self assert: explicitLinks isNil.
	
	database addExplicitLink: explicitLink.
	
	explicitLinksReloaded := monitor explicitLinksOrNil.
	self assert: explicitLinksReloaded title equals: database explicitLinks title.
	self assert: explicitLinksReloaded size equals: 1.
	
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorExplicitLinkBetweenPagesRemoved [
	<gtExample>
	| explicitLink explicitLinksFile explicitLinksFromFile |
	
	self monitorExplicitLinkBetweenPagesAdded.
	
	monitor startMonitoring. 
	explicitLink := database explicitLinks items detect: [ :each | each isAttachedLink ].
	
	database removeExplicitLinks: { explicitLink }.
	
	explicitLinksFile := monitor explicitLinksOrNil.
	self assert: explicitLinksFile isNotNil.
	
	explicitLinksFromFile := monitor explicitLinksOrNil.
	self assert: explicitLinksFromFile title equals: database explicitLinks title.
	self assert: explicitLinksFromFile size equals: 0.
	
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorNamedPageEmptied [
	"Removing all content from a named page should leave it on disk (with no content)"
	<gtExample>
	| page1 |

	self monitorWithDuration: Duration zero.
	page1 := database pageNamed: 'Page 1'.
	self assert: page1 childrenCount equals: 1.
	page1 children first removeSelf.
	self assert: page1 isEmpty.
	self assert: (monitor hasPageStored: page1).
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorPageAdded [
	<gtExample>
	| page title mpaReloaded |

	title := 'Monitor Page Added'.
	self monitorWithDuration: Duration zero.
	page := LePage named: title.
	page addSnippet: (LeTextSnippet string: #snippet).
	self deny: (monitor hasPageStored: page).
	database addPage: page.
	mpaReloaded := monitor reloadPage: page.
	self assert: mpaReloaded title equals: page title.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorPageRemoved [
	<gtExample>
	| page3 |

	self monitorWithDuration: Duration zero.
	page3 := database pageNamed: 'Page 3'.
	self assert: (monitor hasPageStored: page3).
	database removePage: page3.
	self deny: (monitor hasPageStored: page3).
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorPageTitleChanged [
	<gtExample>
	| page3 newPage3 |

	self monitorWithDuration: Duration zero.
	page3 := database pageNamed: 'Page 3'.
	self assert: (monitor hasPageStored: page3).
	page3 updateTitle: 'Page 3a'.
	self assert: (monitor hasPageStored: page3).
	newPage3 := monitor reloadPage: page3.
	self assert: page3 title equals: newPage3 title.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorPharoClassPageEmptied [
	"Removing all content from a pharo class page should remove it from disk"
	<gtExample>
	| classPage |

	self monitorWithDuration: Duration zero.
	classPage := LePage pharoClassName: self class name.
	classPage addSnippet: (LeTextSnippet string: #snippet).
	database addPage: classPage.

	"Since the pharo class page has been added and has content, it should be in the DB"
	self assert: (monitor hasPageStored: classPage).

	classPage children first removeSelf.
	self assert: classPage isEmpty.
	"Once the page is empty, it should be removed"
	self deny: (monitor hasPageStored: classPage).
	^ monitor
]

{ #category : #'examples - monitor' }
LeClassDatabaseMonitorExamples >> monitorSaveDelay [
	"Do a check that multiple updates are queued and processed."
	<gtExample>
	<noTest>
	| page3 page3FromFile count |

	self monitorWithDuration: 0.1 seconds.
	page3 := database pageNamed: 'Page 3'.
	self assert: page3 children size equals: 1.

	page3 snippetBuilder
		string: 'Page 3 Added Paragraph 1';
		add.
	count := 0.
	[ monitor hasChanges and: [ count < 600 ] ]
		whileTrue: [ 0.1 seconds wait.
			count := count + 1 ].
	monitor hasChanges ifTrue: 
		[ self reportMonitorSaveDelayError: 'Paragraph 1' count: count ].
	page3FromFile := monitor reloadPage: page3.
	self assert: page3FromFile children size equals: 2.

	page3 snippetBuilder
		string: 'Page 3 Added Paragraph 2';
		add.
	count := 0.
	[ monitor hasChanges and: [ count < 600 ] ]
		whileTrue: [ 0.1 seconds wait.
			count := count + 1 ].
	monitor hasChanges ifTrue: 
		[ self reportMonitorSaveDelayError: 'Paragraph 2' count: count ].
	page3FromFile := monitor reloadPage: page3.
	self assert: page3FromFile children size equals: 3.

	monitor stopMonitoring.
	^ monitor.
]

{ #category : #private }
LeClassDatabaseMonitorExamples >> monitorWithDuration: aDuration [
	self exportedDatabase.
	database := nil.
	database := LeDatabaseClassStoreLoad current 
		loadFrom: self dbClassName 
		package: self dbPackageName
		saveDelay: aDuration.
	monitor := database monitor.
	^ monitor
]

{ #category : #private }
LeClassDatabaseMonitorExamples >> reportMonitorSaveDelayError: title count: count [
	| errorMessage |

	errorMessage := String streamContents: [ :stream |
		stream
			<< title; cr;
			<< 'SaveDelay: ';
				print: monitor saveDelay; cr;
			<< 'UpdatePromise: ';
				print: monitor updatePromise; cr;
			<< 'Count: ';
				print: count ].
	self error: errorMessage.
]

{ #category : #private }
LeClassDatabaseMonitorExamples >> reset [ 

	memStore := nil.
	database := nil.
	monitor := nil.
]
