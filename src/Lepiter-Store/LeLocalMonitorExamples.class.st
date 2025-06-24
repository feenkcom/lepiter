"
Confirm that the Lepiter DB Monitor saves pages as expected.


"
Class {
	#name : #LeLocalMonitorExamples,
	#superclass : #LeLocalExamples,
	#instVars : [
		'monitor'
	],
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #'examples - monitor' }
LeLocalMonitorExamples >> databaseRoundTrip [
	<gtExample>
	<return: #LeDatabase>
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
LeLocalMonitorExamples >> exportedDatabase [
	"Create and export the database"

	self createDatabase.
	memStore := FileSystem memory root / 'db'.
	LeLocalStoreExport current export: database to: memStore.
	^ database
]

{ #category : #private }
LeLocalMonitorExamples >> importedDatabase [
	"Answer the sample database as imported"

	self exportedDatabase.
	database := nil.
	^ database := LeLocalStoreLoad current loadFrom: memStore
]

{ #category : #'examples - monitor' }
LeLocalMonitorExamples >> monitorBlockAdded [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeLocalStoreMonitor>
	| page3 page3FromFile |
	self monitorWithDuration: Duration zero.
	page3 := database pageNamed: 'Page 3'.
	self assert: page3 children size equals: 1.
	page3 snippetBuilder
		string: 'Page 3 Added Paragraph 1';
		add.
	page3FromFile := monitor reloadPage: page3.
	self assert: page3FromFile children size equals: 2.
	self
		assert: page3FromFile children items second string
		equals: 'Page 3 Added Paragraph 1'.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeLocalMonitorExamples >> monitorBlockModified [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeLocalStoreMonitor>
	| page3 page3FromFile block31 |
	self monitorWithDuration: Duration zero.
	page3 := database pageNamed: 'Page 3'.
	self assert: page3 children size equals: 1.
	block31 := page3 children first.
	block31 updateText: (block31 text copy append: '. Append 1.' asRopedText).
	page3FromFile := monitor reloadPage: page3.
	self assert: page3FromFile children size equals: 1.
	self
		assert: page3FromFile children items first string
		equals: 'Page 3 Paragraph 1. Append 1.'.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeLocalMonitorExamples >> monitorBlockRemoved [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeLocalStoreMonitor>
	| page2 page2FromFile block21 |
	self monitorWithDuration: Duration zero.
	page2 := database pageNamed: 'Page 2'.
	self assert: page2 children size equals: 2.
	block21 := page2 children first.
	block21 removeSelf.
	self assert: page2 children size equals: 1.
	page2FromFile := monitor reloadPage: page2.
	self assert: page2FromFile children size equals: 1.
	self
		assert: page2FromFile children items first string
		equals: 'Page 2 link to [[Page 1]]'.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeLocalMonitorExamples >> monitorExplicitLinkBetweenPagesAdded [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeLocalStoreMonitor>
	| page1 page2 explicitLink explicitLinksFile explicitLinksFromFile |
	self monitorWithDuration: Duration zero.
	page1 := database pageNamed: 'Page 1'.
	page2 := database pageNamed: 'Page 2'.

	explicitLink := LeAttachedLink new
			originReference: (LeLinkPageUidReference forPage: page1);
			targetReference: (LeLinkPageUidReference forPage: page2).

	explicitLinksFile := monitor storage
			explicitLinksFileOrNilIn: monitor localRoot.
	self assert: explicitLinksFile isNil.

	database addExplicitLink: explicitLink.

	explicitLinksFromFile := monitor reloadExplicitLinks: database explicitLinks.
	self assert: explicitLinksFromFile title equals: database explicitLinks title.
	self assert: explicitLinksFromFile size equals: 1.

	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeLocalMonitorExamples >> monitorExplicitLinkBetweenPagesRemoved [
	<gtExample>
	<return: #LeLocalStoreMonitor>
	| explicitLink explicitLinksFile explicitLinksFromFile |
	self monitorExplicitLinkBetweenPagesAdded.

	monitor startMonitoring.
	explicitLink := database explicitLinks items
			detect: [ :each | each isAttachedLink ].

	database removeExplicitLinks: {explicitLink}.

	explicitLinksFile := monitor storage
			explicitLinksFileOrNilIn: monitor localRoot.
	self assert: explicitLinksFile isNotNil.

	explicitLinksFromFile := monitor reloadExplicitLinks: database explicitLinks.
	self assert: explicitLinksFromFile title equals: database explicitLinks title.
	self assert: explicitLinksFromFile size equals: 0.

	monitor stopMonitoring.
	^ monitor
]

{ #category : #'as yet unclassified' }
LeLocalMonitorExamples >> monitorNamedPageEmptied [
	"Removing all content from a named page should leave it on disk (with no content)"

	<gtExample>
	<after: #stopMonitor>
	<return: #LeLocalStoreMonitor>
	| page1 |
	self monitorWithDuration: Duration zero.
	page1 := database pageNamed: 'Page 1'.
	self assert: page1 childrenCount equals: 1.
	page1 children first removeSelf.
	self assert: page1 isEmpty.
	self assert: (monitor pageFileReference: page1) exists.
	^ monitor
]

{ #category : #'examples - monitor' }
LeLocalMonitorExamples >> monitorPageRemoved [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeLocalStoreMonitor>
	| page3 page3Filename |
	self monitorWithDuration: Duration zero.
	page3 := database pageNamed: 'Page 3'.
	page3Filename := memStore / (monitor pageFilename: page3).
	self assert: page3Filename exists.
	database removePage: page3.
	self deny: page3Filename exists.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeLocalMonitorExamples >> monitorPageTitleChanged [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeLocalStoreMonitor>
	| page3 page3Filename newPage3 |
	self monitorWithDuration: Duration zero.
	page3 := database pageNamed: 'Page 3'.
	page3Filename := memStore / (monitor pageFilename: page3).
	self assert: page3Filename exists.
	page3 updateTitle: 'Page 3a'.
	self assert: page3Filename exists.
	newPage3 := monitor reloadPage: page3.
	self assert: page3 title equals: newPage3 title.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeLocalMonitorExamples >> monitorSaveDelay [
	"Do a check that multiple updates are queued and processed."
	<gtExample>
	<after: #stopMonitor>
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
LeLocalMonitorExamples >> monitorWithDuration: aDuration [
	self exportedDatabase.
	database := nil.
	database := LeLocalStoreLoad current loadAndMonitorFrom: memStore saveDelay: aDuration.
	monitor := database monitor.
	^ monitor
]

{ #category : #private }
LeLocalMonitorExamples >> reportMonitorSaveDelayError: title count: count [
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
LeLocalMonitorExamples >> reset [ 

	memStore := nil.
	database := nil.
	monitor := nil.
]

{ #category : #after }
LeLocalMonitorExamples >> stopMonitor [
	monitor ifNotNil: [ :aMonitor |
		aMonitor stopMonitoring ]
]
