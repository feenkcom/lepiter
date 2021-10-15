Class {
	#name : #LeUnlinkedReferenceMaintenanceExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : 'Lepiter-Utilities-Examples'
}

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> addPageWithIncommingUnlinkedReference [
	"Unlinked reference maintenance only updates as snippets are added, so adding a page currently doesn't have its incoming references updated"
	<gtExample>
	<noTest>
	| database newPage |
	database := self linkedAndUnlinkedReferences.

	BlUseAsyncFeatures disableDuring: [
		newPage := database pageBuilder title: 'Block 1'; add ].

	self assert: newPage incomingUnlinked size equals: 1.

	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> addPageWithOutgoingUnlinkedReference [
	<gtExample>
	| database pageTwo newPage |
	database := self linkedAndUnlinkedReferences.
	pageTwo := database pageNamed: 'Page2'.
	
	newPage := LePage named:'New page'.
	newPage addSnippet: (LeTextSnippet string: 'Page2 new snippet').
	
	BlUseAsyncFeatures disableDuring: [
		database addPage: newPage ].
	
	self assert: pageTwo incomingUnlinked size equals: 4.
	
	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> addSnippetWithIncommingUnlinkedReference [
	<gtExample>
	
	| database pageOne pageTwo |
	database := self linkedAndUnlinkedReferences.
	pageOne := database pageNamed: 'Page1'.
	pageTwo := database pageNamed: 'Page2'.

	self assert: pageTwo incomingUnlinked size equals: 3.
	
	BlUseAsyncFeatures
		disableDuring: [ pageOne addSnippet: (LeTextSnippet string: 'Page2 new snippet') ].
	
	self assert: pageTwo incomingUnlinked size equals: 4.
	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> crossDatabaseUnlinkedReference [
	<gtExample>
	| db1 db2 ldb referencedPage namedPage unnamedPage dailyNote blocks maintainer |
	db1 := LeDatabase new.
	db2 := LeDatabase new.
	ldb := LeLogicalDatabase primaryDB: db1 playgroundDB: db2.
	blocks := OrderedCollection new.
	
	referencedPage := db1 pageBuilder
		title: 'ReferencedPage';
		add.
	namedPage := db2 pageBuilder
		title: 'NamedPage';
		add.
	blocks add: (namedPage
		addSnippet: (LeTextSnippet string: 'NamedPage ref to ReferencedPage.')).
	unnamedPage := db2 addPage: LePage unnamedPage.
	blocks
		add:
			(unnamedPage
				addSnippet: (LeTextSnippet string: 'UnnamedPage ref to ReferencedPage.')).
	dailyNote := db2 addPage: (LePage dailyNoteFor: Date today).
	blocks
		add:
			(dailyNote
				addSnippet: (LeTextSnippet string: 'DailyNote ref to ReferencedPage.')).
	blocks
		do: [ :block | 
			maintainer := LeUnlinkedReferenceMaintenance forBlock: block.
			maintainer run ].
		
	self assert: referencedPage incomingUnlinked size equals: 3.
	^ ldb
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> linkedAndUnlinkedReferences [
	<gtExample>
	| database snippets page1 page2 page3 maintainer link |
	database := LeDatabase new.
	snippets := OrderedCollection new.
	page1 := database pageBuilder
		title: 'Page1';
		add.
	snippets
		add:
			(page1
				addSnippet: (LeTextSnippet string: 'Unlinked reference to Page2 here')).
	snippets add: (page1 addSnippet: (LePharoSnippet code: '42 inspect')).
	page2 := database pageBuilder
		title: 'Page2';
		add.
	snippets
		add: (page2 addSnippet: (LeTextSnippet string: 'Page2 Block 1')).
	page3 := database pageBuilder
		title: 'Page3';
		add.
	snippets
		add:
			(page3
				addSnippet: (LeTextSnippet string: 'Linked [[Page2]] and unlinked Page2 here')).
	snippets
		add:
			(page3
				addSnippet: (LePharoSnippet code: '"Code for Page2" 42 inspect.')).
	snippets
		add: (page3 addSnippet: (LeTextSnippet string: 'Hash to #Page2 here')).
	snippets
		do: [ :snippet | 
			maintainer := LeUnlinkedReferenceMaintenance forBlock: snippet.
			maintainer run ].
	self assert: page1 incomingUnlinked size equals: 0.
	self assert: page1 incomingLinks size equals: 0.
	self assert: page2 incomingUnlinked size equals: 3.
	self assert: page2 incomingLinks size equals: 1.
	link := page2 incomingUnlinked first.
	self assert: link origin equals: page1 children first.
	self assert: link target equals: page2.
	self assert: link targetUID equals: page2 title.
	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> noUnlinkedReferencesToUnamedPage [
	<gtExample>
	| database unnamedPage page1 page2  |
	database := LeDatabase new.
	unnamedPage := LePage unnamedPageWithDefaultTitle: 'Page 3'.
	database addPage: unnamedPage.
	
	page1 := database pageBuilder
		title: 'Page 1';
		add.
	
	page2 := database pageBuilder
		title: 'Page 2';
		add.
	BlUseAsyncFeatures disableDuring: [
		page2
			addSnippet: (LeTextSnippet string: 'Unlinked reference to Page 1 but not to Page 3') ].
	
	self assert: unnamedPage incomingUnlinked size equals: 0.
	self assert: unnamedPage incomingLinks size equals: 0.
	self assert: page1 incomingUnlinked size equals: 1.
	self assert: page1 incomingLinks size equals: 0.
	
	^ unnamedPage
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> noUnlinkedReferencesToUnamedPageWithSameDefaultTitleAsNamedPage [
	<gtExample>
	| database unnamedPage page1 page2  |
	database := LeDatabase new.
	unnamedPage := LePage unnamedPageWithDefaultTitle: 'Page 1'.

	BlUseAsyncFeatures disableDuring: [
		database addPage: unnamedPage.
	
		page1 := database pageBuilder
			title: 'Page 1';
			add.
	
		page2 := database pageBuilder
			title: 'Page 2';
			add.
		
		page2
			addSnippet: (LeTextSnippet string: 'Unlinked reference to named Page 1') ].
	
	self assert: unnamedPage incomingUnlinked size equals: 0.
	self assert: unnamedPage incomingLinks size equals: 0.
	self assert: page1 incomingUnlinked size equals: 1.
	self assert: page1 incomingLinks size equals: 0.
	
	^ unnamedPage
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> pageTitleWithRegexChars [
	<gtExample>
	| database blocks page1 page2 page3 maintainer link |
	database := LeDatabase new.
	blocks := OrderedCollection new.
	page1 := database pageBuilder
		title: 'Page 1';
		add.
	blocks
		add:
			(page1
				addSnippet: (LeTextSnippet string: 'Unlinked reference to +123Page 2 here')).
	blocks add: (page1 addSnippet: (LePharoSnippet code: '42 inspect')).
	page2 := database pageBuilder
		title: '+123Page 2';
		add.
	blocks
		add: (page2 addSnippet: (LeTextSnippet string: 'Page 2 Block 1')).
	page3 := database pageBuilder
		title: 'Page 3';
		add.
	blocks
		add:
			(page3
				addSnippet:
					(LeTextSnippet
						string: 'Linked [[+123Page 2]] and unlinked +123Page 2 here')).
	
	blocks
		do: [ :block | 
			maintainer := LeUnlinkedReferenceMaintenance forBlock: block.
			maintainer run ].
		
	self assert: page1 incomingUnlinked size equals: 0.
	self assert: page1 incomingLinks size equals: 0.
	self assert: page2 incomingUnlinked size equals: 1.
	self assert: page2 incomingLinks size equals: 1.
	link := page2 incomingUnlinked first.
	self assert: link origin equals: page1 children first.
	self assert: link target equals: page2.
	self assert: link targetUID equals: page2 title.
	^ page2
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> removePageWithOutgoingUnlinkedReference [
	<gtExample>
	| database pageOne pageTwo  |
	database := self linkedAndUnlinkedReferences.
	
	pageOne := database pageNamed: 'Page1'.
	pageTwo := database pageNamed: 'Page2'.

	self assert: pageTwo incomingUnlinked size equals: 3.
	
	BlUseAsyncFeatures disableDuring: [ pageOne removeSelf ].
	
	self assert: pageTwo incomingUnlinked size equals: 2.
	
	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> removeUnlinkedReference [
	"Remove the first unlinked reference from #linkedAndUnlinkedReferences"
	<gtExample>
	| database page1 snippet page2 found |

	database := self linkedAndUnlinkedReferences.
	page1 := database pageNamed: 'Page1'.
	page2 := database pageNamed: 'Page2'.
	snippet := page1 children first.

	self assert: page2 incomingUnlinked size equals: 3.
	self assert: page2 incomingUnlinked first origin equals: snippet.

	BlUseAsyncFeatures disableDuring: [ snippet removeSelf ].

	self assert: page2 incomingUnlinked size equals: 2.
	found := page2 incomingUnlinked 
		detect: [ :each | each origin = snippet ]
		ifFound: [ true ]
		ifNone: [ false ].
	self deny: found.

	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> removesSnippetWithChildSnippetsWithOutgoingUnlinkedReference [
	<gtExample>
	| database pageOne pageTwo newSnippet |
	database := self linkedAndUnlinkedReferences.
	
	pageOne := database pageNamed: 'Page1'.
	pageTwo := database pageNamed: 'Page2'.
	
	BlUseAsyncFeatures disableDuring: [ 
		newSnippet := pageOne snippetBuilder string: 'New snippet'; add.
		newSnippet snippetBuilder string: 'Unlinked reference to Page2'; add ].

	self assert: pageTwo incomingUnlinked size equals: 4.
	
	BlUseAsyncFeatures disableDuring: [ newSnippet removeSelf ].
	
	self assert: pageTwo incomingUnlinked size equals: 3.
	
	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> removesSnippetWithOutgoingUnlinkedReference [
	<gtExample>
	| database pageOne pageOneSnippetOne pageTwo |
	database := self linkedAndUnlinkedReferences.
	
	pageOne := database pageNamed: 'Page1'.
	pageOneSnippetOne := pageOne children first.
	pageTwo := database pageNamed: 'Page2'.

	self assert: pageTwo incomingUnlinked size equals: 3.
	
	BlUseAsyncFeatures disableDuring: [ pageOneSnippetOne removeSelf ].
	
	self assert: pageTwo incomingUnlinked size equals: 2.
	
	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> renamePageWithIncommingUnlinkedReference [
	<gtExample>
	<noTest>
	| database pageTwo  |
	database := self linkedAndUnlinkedReferences.
	
	pageTwo := database pageNamed: 'Page2'.

	self assert: pageTwo incomingUnlinked size equals: 3.
	
	BlUseAsyncFeatures disableDuring: [ pageTwo renameTo: 'Page9' ].
	
	self assert: pageTwo incomingUnlinked size equals: 0.
	
	^ database
]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> textSnippetVisitor [
	"Confirm the operation of the text snippet visitor"
	<gtExample>
	| snippet string |

	snippet := LeTextSnippet string: 'one two three'.
	string := String streamContents: [ :stream |
		snippet ast acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ].
	self assert: string equals: 'one two three'.

	snippet := LeTextSnippet string: 'one two [[three]]'.
	string := String streamContents: [ :stream |
		snippet ast acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ].
	self assert: string equals: 'one two '.

	snippet := LeTextSnippet string: '{{gtClass:ClassName}}'.
	string := String streamContents: [ :stream |
		snippet ast acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ].
	self assert: string equals: 'ClassName'.

	snippet := LeTextSnippet string: '{{gtMethod:ClassName>>#methodName}}'.
	string := String streamContents: [ :stream |
		snippet ast acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ].
	self assert: string equals: 'ClassName methodName'.

]

{ #category : #examples }
LeUnlinkedReferenceMaintenanceExamples >> unlinkedReferencesExcludeLinks [
	<gtExample>
	| database blocks page1 page1too page2 maintainer |
	database := LeDatabase new.
	blocks := OrderedCollection new.
	page1 := database pageBuilder
		title: 'Page1';
		add.
	blocks
		add: (page1 addSnippet: (LeTextSnippet string: 'Page 1 block 1')).
	page1too := database pageBuilder
		title: 'Page1 too';
		add.
	blocks
		add: (page1too addSnippet: (LeTextSnippet string: 'Page1 too Block 1')).
	page2 := database pageBuilder
		title: 'Page2';
		add.
	blocks
		add:
			(page2
				addSnippet: (LeTextSnippet string: 'Unlinked reference to Page1')).
	blocks
		add:
			(page2
				addSnippet:
					(LeTextSnippet
						string: 'Unlinked reference to Page1 ignored because of [[Page1 too]].')).
	blocks
		add:
			(page2
				addSnippet:
					(LeTextSnippet
						string: '[[Page1 too]] shouldn''t link to the other page 1.')).
	blocks
		do: [ :block | 
			maintainer := LeUnlinkedReferenceMaintenance forBlock: block.
			maintainer run ].
	self assert: page1 incomingUnlinked size equals: 3.
	self assert: page1 incomingLinks size equals: 0.
	self assert: page1too incomingUnlinked size equals: 0.
	self assert: page1too incomingLinks size equals: 2.
	self assert: page2 incomingUnlinked size equals: 0.
	self assert: page2 incomingLinks size equals: 0.
	^ database
]
