Extension { #name : #LeLocalMonitorExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeLocalMonitorExamples >> monitorPageAdded [
	<gtExample>
	<after: #stopMonitor>
	<return: #LeLocalStoreMonitor>
	| page title mpaFilename mpaFromFile |
	title := 'Monitor Page Added'.
	self monitorWithDuration: Duration zero.
	page := LePage named: title.
	page addSnippet: (LeTextSnippet string: #snippet).
	mpaFilename := monitor pageFileReference: page.
	self deny: mpaFilename exists.
	database addPage: page.
	mpaFromFile := monitor reloadPage: page.
	self assert: mpaFromFile title equals: page title.
	monitor stopMonitoring.
	^ monitor
]

{ #category : #'*Lepiter-Snippet-Text' }
LeLocalMonitorExamples >> monitorPharoClassPageEmptied [
	"Removing all content from a pharo class page should remove it from disk"

	<gtExample>
	<after: #stopMonitor>
	<return: #LeLocalStoreMonitor>
	| classPage pageFilename |
	self monitorWithDuration: Duration zero.
	classPage := LePage pharoClassName: self class name.
	classPage addSnippet: (LeTextSnippet string: #snippet).
	database addPage: classPage.
	pageFilename := monitor pageFileReference: classPage.	"Since the pharo class page has been added and has content, it should be in the DB"
	self assert: pageFilename exists.

	classPage children first removeSelf.
	self assert: classPage isEmpty.	"Once the page is empty, it should be removed"
	self deny: pageFilename exists.
	^ monitor
]
