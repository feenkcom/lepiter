Class {
	#name : #LeDatabaseClassMonitorExamples,
	#superclass : #LeDatabaseClassExamples,
	#category : #'Lepiter-Store-Class-Examples'
}

{ #category : #'examples - monitor' }
LeDatabaseClassMonitorExamples >> databaseRoundTrip [
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

{ #category : #'examples - monitor' }
LeDatabaseClassMonitorExamples >> monitorBlockAdded [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
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
LeDatabaseClassMonitorExamples >> monitorBlockModified [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
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
LeDatabaseClassMonitorExamples >> monitorBlockRemoved [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
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
LeDatabaseClassMonitorExamples >> monitorClassRemoved [
	<gtExample>
	<return: #LeDatabaseClassStoreMonitor>
	self monitorPageMethodAdded.
	monitor startMonitoring.
	self assert: (monitor database hasPageNamed: 'Monitor Method Added').
	monitor dbClass removeFromSystem.
	self deny: (monitor database hasPageNamed: 'Monitor Method Added').
	self deny: monitor isRunning.

	^ monitor
]

{ #category : #'examples - monitor' }
LeDatabaseClassMonitorExamples >> monitorExplicitLinkBetweenPagesAdded [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
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
LeDatabaseClassMonitorExamples >> monitorExplicitLinkBetweenPagesRemoved [
	<gtExample>
	<return: #LeDatabaseClassStoreMonitor>
	| explicitLink explicitLinksFile explicitLinksFromFile |
	self monitorExplicitLinkBetweenPagesAdded.

	monitor startMonitoring.
	explicitLink := database explicitLinks items
			detect: [ :each | each isAttachedLink ].

	database removeExplicitLinks: {explicitLink}.

	explicitLinksFile := monitor explicitLinksOrNil.
	self assert: explicitLinksFile isNotNil.

	explicitLinksFromFile := monitor explicitLinksOrNil.
	self assert: explicitLinksFromFile title equals: database explicitLinks title.
	self assert: explicitLinksFromFile size equals: 0.

	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeDatabaseClassMonitorExamples >> monitorNamedPageEmptied [
	"Removing all content from a named page should leave it on disk (with no content)"

	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
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
LeDatabaseClassMonitorExamples >> monitorPageAdded [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
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
LeDatabaseClassMonitorExamples >> monitorPageMethodAdded [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
	self monitorWithDuration: Duration zero.
	self deny: (monitor database hasPageNamed: 'Monitor Method Added').
	monitor dbClass class
		compile: (self class >> #page_f07q3szi3e0xhvi91t359q49q) sourceCode
		classified: #pages.
	self assert: (monitor database hasPageNamed: 'Monitor Method Added').
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeDatabaseClassMonitorExamples >> monitorPageMethodModified [
	<gtExample>
	<return: #LeDatabaseClassStoreMonitor>
	| source |
	self monitorPageMethodAdded.
	monitor startMonitoring.
	self
		assert: (monitor database pageNamed: 'Monitor Method Added') children first
				contentAsString
		equals: 'abcdef'.
	source := (self class >> #page_f07q3szi3e0xhvi91t359q49q) sourceCode.
	source := source copyReplaceAll: 'abcdef' with: 'abc123def'.

	monitor dbClass class compile: source classified: #pages.
	self
		assert: (monitor database pageNamed: 'Monitor Method Added') children first
				contentAsString
		equals: 'abc123def'.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeDatabaseClassMonitorExamples >> monitorPageMethodRemoved [
	<gtExample>
	<return: #LeDatabaseClassStoreMonitor>
	self monitorPageMethodAdded.
	monitor startMonitoring.
	self assert: (monitor database hasPageNamed: 'Monitor Method Added').
	(monitor dbClass class >> #page_f07q3szi3e0xhvi91t359q49q) removeFromSystem.
	self deny: (monitor database hasPageNamed: 'Monitor Method Added').

	monitor stopMonitoring.
	^ monitor
]

{ #category : #'examples - monitor' }
LeDatabaseClassMonitorExamples >> monitorPageRemoved [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
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
LeDatabaseClassMonitorExamples >> monitorPageTitleChanged [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
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
LeDatabaseClassMonitorExamples >> monitorPharoClassPageEmptied [
	"Removing all content from a pharo class page should remove it from disk"

	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassStoreMonitor>
	| classPage |
	self monitorWithDuration: Duration zero.
	classPage := LePage pharoClassName: self class name.
	classPage addSnippet: (LeTextSnippet string: #snippet).
	database addPage: classPage.	"Since the pharo class page has been added and has content, it should be in the DB"
	self assert: (monitor hasPageStored: classPage).

	classPage children first removeSelf.
	self assert: classPage isEmpty.	"Once the page is empty, it should be removed"
	self deny: (monitor hasPageStored: classPage).
	^ monitor
]

{ #category : #'examples - monitor' }
LeDatabaseClassMonitorExamples >> monitorSaveDelay [
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

{ #category : #accessing }
LeDatabaseClassMonitorExamples >> page_f07q3szi3e0xhvi91t359q49q [
"Automatically generated
Monitor Method Added"
"{
	""__schema"" : ""4.1"",
	""__type"" : ""page"",
	""children"" : {
		""__type"" : ""snippets"",
		""items"" : [
			{
				""__type"" : ""textSnippet"",
				""children"" : {
					""__type"" : ""snippets"",
					""items"" : [ ]
				},
				""createEmail"" : {
					""__type"" : ""email"",
					""emailString"" : ""<unknown>""
				},
				""createTime"" : {
					""__type"" : ""time"",
					""time"" : {
						""__type"" : ""dateAndTime"",
						""dateAndTimeString"" : ""2023-06-22T08:00:42.852796+02:00""
					}
				},
				""editEmail"" : {
					""__type"" : ""email"",
					""emailString"" : ""<unknown>""
				},
				""editTime"" : {
					""__type"" : ""time"",
					""time"" : {
						""__type"" : ""dateAndTime"",
						""dateAndTimeString"" : ""2023-06-22T08:00:42.852796+02:00""
					}
				},
				""uid"" : {
					""__type"" : ""uid"",
					""uidString"" : ""lzpuVxO7DQCkeVs3CP13/Q==""
				},
				""paragraphStyle"" : {
					""__type"" : ""textStyle""
				},
				""string"" : ""abcdef""
			}
		]
	},
	""createEmail"" : {
		""__type"" : ""email"",
		""emailString"" : ""<unknown>""
	},
	""createTime"" : {
		""__type"" : ""time"",
		""time"" : {
			""__type"" : ""dateAndTime"",
			""dateAndTimeString"" : ""2023-06-22T08:00:42.852547+02:00""
		}
	},
	""editEmail"" : {
		""__type"" : ""email"",
		""emailString"" : ""<unknown>""
	},
	""editTime"" : {
		""__type"" : ""time"",
		""time"" : {
			""__type"" : ""dateAndTime"",
			""dateAndTimeString"" : ""2023-06-22T08:00:42.852547+02:00""
		}
	},
	""pageType"" : {
		""__type"" : ""namedPage"",
		""title"" : ""Monitor Method Added""
	},
	""uid"" : {
		""__type"" : ""uuid"",
		""uuid"" : ""1ee5cd56-13bb-0d00-a478-643a08fd77fd""
	}
}"
]

{ #category : #private }
LeDatabaseClassMonitorExamples >> reportMonitorSaveDelayError: title count: count [
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
LeDatabaseClassMonitorExamples >> reset [ 

	database := nil.
	monitor := nil.
]
