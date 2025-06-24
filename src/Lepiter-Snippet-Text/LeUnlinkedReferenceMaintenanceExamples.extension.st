Extension { #name : #LeUnlinkedReferenceMaintenanceExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeUnlinkedReferenceMaintenanceExamples >> addPageWithOutgoingUnlinkedReference [
	<gtExample>
	<return: #LeDatabase>
	| database pageTwo newPage |
	database := self linkedAndUnlinkedReferences.
	pageTwo := database pageNamed: 'Page2'.

	newPage := LePage named: 'New page'.
	newPage addSnippet: (LeTextSnippet string: 'Page2 new snippet').

	BlUseAsyncFeatures disableDuring: [ database addPage: newPage ].

	self assert: pageTwo incomingUnlinked size equals: 4.

	^ database
]

{ #category : #'*Lepiter-Snippet-Text' }
LeUnlinkedReferenceMaintenanceExamples >> addSnippetWithIncommingUnlinkedReference [
	<gtExample>
	<return: #LeDatabase>
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

{ #category : #'*Lepiter-Snippet-Text' }
LeUnlinkedReferenceMaintenanceExamples >> crossDatabaseUnlinkedReference [
	<gtExample>
	<return: #LeLogicalDatabase>
	| db1 db2 ldb referencedPage namedPage unnamedPage blocks maintainer |
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
	blocks
		add: (namedPage
				addSnippet: (LeTextSnippet string: 'NamedPage ref to ReferencedPage.')).
	unnamedPage := db2 addPage: LePage unnamedPage.
	blocks
		add: (unnamedPage
				addSnippet: (LeTextSnippet string: 'UnnamedPage ref to ReferencedPage.')).

	blocks
		do: [ :block | 
			maintainer := LeUnlinkedReferenceMaintenance forBlock: block.
			maintainer run ].

	self assert: referencedPage incomingUnlinked size equals: 2.
	^ ldb
]

{ #category : #'*Lepiter-Snippet-Text' }
LeUnlinkedReferenceMaintenanceExamples >> noUnlinkedReferencesToUnamedPage [
	<gtExample>
	<return: #LePage>
	| database unnamedPage page1 page2 |
	database := LeDatabase new.
	unnamedPage := LePage unnamedPageWithDefaultTitle: 'Page 3'.
	database addPage: unnamedPage.

	page1 := database pageBuilder
			title: 'Page 1';
			add.

	page2 := database pageBuilder
			title: 'Page 2';
			add.
	BlUseAsyncFeatures
		disableDuring: [ page2
				addSnippet: (LeTextSnippet string: 'Unlinked reference to Page 1 but not to Page 3') ].

	self assert: unnamedPage incomingUnlinked size equals: 0.
	self assert: unnamedPage incomingLinks size equals: 0.
	self assert: page1 incomingUnlinked size equals: 1.
	self assert: page1 incomingLinks size equals: 0.

	^ unnamedPage
]

{ #category : #'*Lepiter-Snippet-Text' }
LeUnlinkedReferenceMaintenanceExamples >> noUnlinkedReferencesToUnamedPageWithSameDefaultTitleAsNamedPage [
	<gtExample>
	<return: #LePage>
	| database unnamedPage page1 page2 |
	database := LeDatabase new.
	unnamedPage := LePage unnamedPageWithDefaultTitle: 'Page 1'.

	BlUseAsyncFeatures
		disableDuring: [ database addPage: unnamedPage.

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

{ #category : #'*Lepiter-Snippet-Text' }
LeUnlinkedReferenceMaintenanceExamples >> textSnippetVisitor [
	"Confirm the operation of the text snippet visitor"

	<gtExample>
	<return: #LeUnlinkedReferenceMaintenanceExamples>
	| snippet string |
	snippet := LeTextSnippet string: 'one two three'.
	string := String
			streamContents: [ :stream | 
				snippet ast
					acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ].
	self assert: string equals: 'one two three'.

	snippet := LeTextSnippet string: 'one two [[three]]'.
	string := String
			streamContents: [ :stream | 
				snippet ast
					acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ].
	self assert: string equals: 'one two '.

	snippet := LeTextSnippet string: '{{gtClass:ClassName}}'.
	string := String
			streamContents: [ :stream | 
				snippet ast
					acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ].
	self assert: string equals: 'ClassName'.

	snippet := LeTextSnippet string: '{{gtMethod:ClassName>>#methodName}}'.
	string := String
			streamContents: [ :stream | 
				snippet ast
					acceptVisitor: (LeUnlinkedReferenceTextSnippetVisitor new stream: stream) ].
	self assert: string equals: 'ClassName methodName'
]

{ #category : #'*Lepiter-Snippet-Text' }
LeUnlinkedReferenceMaintenanceExamples >> unlinkedReferencesExcludeLinks [
	<gtExample>
	<return: #LeDatabase>
	| database blocks page1 page1too page2 maintainer |
	database := LeDatabase new.
	blocks := OrderedCollection new.
	page1 := database pageBuilder
			title: 'Page1';
			add.
	blocks add: (page1 addSnippet: (LeTextSnippet string: 'Page 1 block 1')).
	page1too := database pageBuilder
			title: 'Page1 too';
			add.
	blocks add: (page1too addSnippet: (LeTextSnippet string: 'Page1 too Block 1')).
	page2 := database pageBuilder
			title: 'Page2';
			add.
	blocks
		add: (page2 addSnippet: (LeTextSnippet string: 'Unlinked reference to Page1')).
	blocks
		add: (page2
				addSnippet: (LeTextSnippet
						string: 'Unlinked reference to Page1 ignored because of [[Page1 too]].')).
	blocks
		add: (page2
				addSnippet: (LeTextSnippet string: '[[Page1 too]] shouldn''t link to the other page 1.')).
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
