Extension { #name : #LeUnlinkedReferenceMaintenanceExamples }

{ #category : #'*Lepiter-Pharo' }
LeUnlinkedReferenceMaintenanceExamples >> linkedAndUnlinkedReferences [
	<gtExample>
	<return: #LeDatabase>
	| database snippets page1 page2 page3 maintainer link |
	database := LeDatabase new.
	snippets := OrderedCollection new.
	page1 := database pageBuilder
			title: 'Page1';
			add.
	snippets
		add: (page1 addSnippet: (LeTextSnippet string: 'Unlinked reference to Page2 here')).
	snippets add: (page1 addSnippet: (LePharoSnippet code: '42 inspect')).
	page2 := database pageBuilder
			title: 'Page2';
			add.
	snippets add: (page2 addSnippet: (LeTextSnippet string: 'Page2 Block 1')).
	page3 := database pageBuilder
			title: 'Page3';
			add.
	snippets
		add: (page3
				addSnippet: (LeTextSnippet string: 'Linked [[Page2]] and unlinked Page2 here')).
	snippets
		add: (page3 addSnippet: (LePharoSnippet code: '"Code for Page2" 42 inspect.')).
	snippets add: (page3 addSnippet: (LeTextSnippet string: 'Hash to #Page2 here')).
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

{ #category : #'*Lepiter-Pharo' }
LeUnlinkedReferenceMaintenanceExamples >> pageTitleWithRegexChars [
	<gtExample>
	<return: #LePage>
	| database blocks page1 page2 page3 maintainer link |
	database := LeDatabase new.
	blocks := OrderedCollection new.
	page1 := database pageBuilder
			title: 'Page 1';
			add.
	blocks
		add: (page1
				addSnippet: (LeTextSnippet string: 'Unlinked reference to +123Page 2 here')).
	blocks add: (page1 addSnippet: (LePharoSnippet code: '42 inspect')).
	page2 := database pageBuilder
			title: '+123Page 2';
			add.
	blocks add: (page2 addSnippet: (LeTextSnippet string: 'Page 2 Block 1')).
	page3 := database pageBuilder
			title: 'Page 3';
			add.
	blocks
		add: (page3
				addSnippet: (LeTextSnippet string: 'Linked [[+123Page 2]] and unlinked +123Page 2 here')).

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
