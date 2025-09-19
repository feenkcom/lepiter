Class {
	#name : #LeIncomingReferencesExamples,
	#superclass : #Object,
	#instVars : [
		'database',
		'page1',
		'page2',
		'page3',
		'p1b2',
		'p2b2',
		'page4'
	],
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #examples }
LeIncomingReferencesExamples >> database [
	<gtExample>
	<after: #stopDatabaseMonitor>
	<return: #LeDatabase>
	^ database
		ifNil: [ | folderReference localStore |
			folderReference := FileSystem memory / 'storage'.
			folderReference ensureCreateDirectory.

			localStore := LeLocalStoreLoad current.
			localStore localRoot: folderReference.
			database := localStore loadAndMonitorFrom: folderReference.

			self assert: database explicitLinks size equals: 0.

			database userEmail: 'example@user.com'.
			^ database ]
]

{ #category : #examples }
LeIncomingReferencesExamples >> databaseWithPages [
	"Pages are created lazily, just retrieve them to force creation"

	<gtExample>
	<return: #LeDatabase>
	self page1.
	self page2.
	self page3.
	self page4.
	^ self database
]

{ #category : #examples }
LeIncomingReferencesExamples >> incomingLinkedReferences [
	<gtExample>
	<return: #LeIncomingExplicitPageLinksGroup>
	| incomingReferences theLinks pageToPageLink |
	self databaseWithPages.
	incomingReferences := LeIncomingExplicitPageLinksGroup forPage: self page3.
	self assert: incomingReferences size equals: 2.
	theLinks := incomingReferences links.
	self assert: theLinks size equals: 2.

	pageToPageLink := theLinks first.
	self assert: (pageToPageLink isFromPage: page1).
	self assert: pageToPageLink referencingPage equals: page1.
	self assert: pageToPageLink referencedPage equals: page3.
	self
		assert: pageToPageLink link originReference content
		equals: (page1 children at: 2).

	pageToPageLink := theLinks second.
	self assert: (pageToPageLink isFromPage: page2).
	self assert: pageToPageLink referencingPage equals: page2.
	self assert: pageToPageLink referencedPage equals: page3.
	self
		assert: pageToPageLink link originReference content
		equals: (page2 children at: 2).

	^ incomingReferences
]

{ #category : #examples }
LeIncomingReferencesExamples >> incomingLinkedSelfReference [
	<gtExample>
	<return: #LeIncomingExplicitPageLinksGroup>
	| incomingReferences theLinks pageToPageLink |
	self databaseWithPages.
	incomingReferences := LeIncomingExplicitPageLinksGroup forPage: self page4.
	self assert: incomingReferences size equals: 1.
	theLinks := incomingReferences links.
	self assert: theLinks size equals: 1.

	pageToPageLink := theLinks first.
	self assert: (pageToPageLink isFromPage: page1).
	self assert: pageToPageLink referencingPage equals: page1.
	self assert: pageToPageLink referencedPage equals: page4.
	self
		assert: pageToPageLink link originReference content
		equals: (page1 children at: 3).

	^ incomingReferences
]

{ #category : #examples }
LeIncomingReferencesExamples >> incomingUnlinkedReferences [
	"This test passes only because unlinked references are not recomputed 
	for a page when new content is added to the database. When page 1 is
	added it contains an unlinked reference to Page 3, but page three is
	only added later."

	<gtExample>
	<return: #LeDatabase>
	| incomingReferences |
	BlUseAsyncFeatures disableDuring: [ self databaseWithPages ].

	incomingReferences := LeIncomingImplicitPageLinksGroup forPage: self page3.
	self assert: incomingReferences size equals: 0.

	^ self database
]

{ #category : #examples }
LeIncomingReferencesExamples >> incomingUnlinkedReferencesWithPage3First [
	<gtExample>
	<return: #LeIncomingImplicitPageLinksGroup>
	| incomingReferences theLinks pageToPageLink |
	BlUseAsyncFeatures
		disableDuring: [  "We do page 3 first so that it incoming links will be created when page 1 is added"self
				page3.
			self page1.
			self page2.
			self page4 ].

	incomingReferences := LeIncomingImplicitPageLinksGroup forPage: self page3.
	self assert: incomingReferences size equals: 1.
	theLinks := incomingReferences links.
	self assert: theLinks size equals: 1.

	pageToPageLink := theLinks first.
	self assert: (pageToPageLink isFromPage: page1).
	self assert: pageToPageLink referencingPage equals: page1.
	self assert: pageToPageLink referencedPage equals: page3.
	self
		assert: pageToPageLink link originReference content
		equals: (page1 children at: 4).

	^ incomingReferences
]

{ #category : #examples }
LeIncomingReferencesExamples >> page1 [
	<gtExample>
	<return: #LePage>
	page1 ifNotNil: [ ^ page1 ].
	page1 := self database pageBuilder
			title: 'Page 1';
			add.
	page1 snippetBuilder
		string: 'First block in Page 1';
		add.
	p1b2 := page1 snippetBuilder
			string: 'Page 1 Link to [[Page 3]]';
			add.
	page1 snippetBuilder
		string: 'Page 1 Link to [[Page 4]]';
		add.
	page1 addSnippet: (LeTextSnippet string: 'Page 1 unlinked to Page 3').
	^ page1
]

{ #category : #examples }
LeIncomingReferencesExamples >> page2 [
	<gtExample>
	<return: #LePage>
	page2 ifNotNil: [ ^ page2 ].
	page2 := self database pageBuilder
			title: 'Page 2';
			add.
	page2 snippetBuilder
		string: 'First block in Page 2';
		add.
	p2b2 := page2 snippetBuilder
			string: 'Page 2 Link to [[Page 3]]';
			add.
	^ page2
]

{ #category : #examples }
LeIncomingReferencesExamples >> page3 [
	<gtExample>
	<return: #LePage>
	page3 ifNotNil: [ ^ page3 ].

	page3 := self database ensurePageNamed: 'Page 3'.
	page3 snippetBuilder
		string: 'First block in Page 3.';
		add.
	page3 snippetBuilder
		string: 'Second block in Page 3.';
		add.
	^ page3
]

{ #category : #examples }
LeIncomingReferencesExamples >> page4 [
	<gtExample>
	<return: #LePage>
	page4 ifNotNil: [ ^ page4 ].

	page4 := self database ensurePageNamed: 'Page 4'.
	page4 snippetBuilder
		string: 'Page 4 links to itself: [[Page 4]]';
		add.
	page4 snippetBuilder
		string: 'Second block in Page 4.';
		add.
	^ page4
]

{ #category : #examples }
LeIncomingReferencesExamples >> stopDatabaseMonitor [
	database ifNotNil: [ database stopMonitoring ]
]
