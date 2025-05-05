Class {
	#name : #LeSnippetOperationsWithAttachedLinksExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #'examples - database' }
LeSnippetOperationsWithAttachedLinksExamples >> databaseBaseWithContent [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage thirdSnippet fifthSnippet secondPage |
	database := self emptyDatabase.
	firstPage := database pageBuilder
			title: 'Page 1';
			add.
	firstPage snippetBuilder
		string: 'one';
		add.
	firstPage snippetBuilder
		string: 'two';
		add.
	thirdSnippet := firstPage snippetBuilder
			string: 'three';
			add.

	thirdSnippet snippetBuilder
		string: 'fourth';
		add.
	fifthSnippet := thirdSnippet snippetBuilder
			string: 'five';
			add.
	fifthSnippet snippetBuilder
		string: 'six';
		add.
	thirdSnippet snippetBuilder
		string: 'seven';
		add.

	firstPage snippetBuilder
		string: 'eight';
		add.

	secondPage := database pageBuilder
			title: 'Page 2';
			add.
	secondPage snippetBuilder
		string: 'Snippet in Page 2';
		add.

	^ database
]

{ #category : #'examples - database' }
LeSnippetOperationsWithAttachedLinksExamples >> emptyDatabase [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := LeDatabase new.

	self assert: database explicitLinks size equals: 0.

	^ database
]

{ #category : #utils }
LeSnippetOperationsWithAttachedLinksExamples >> linkFromSnippet: aSnippet in: aDatabase [
	| pageTwo explicitLink |
	pageTwo := aDatabase pageNamed: 'Page 2'.
	
	explicitLink := LeAttachedLink new 
		originReference: (LeLinkSnippetUidReference forSnippetUid: aSnippet uid);
		targetReference: (LeLinkPageUidReference forPageUid: pageTwo uid).
	aDatabase addExplicitLink: explicitLink.
	
	self assert: explicitLink originReference isResolved.
	self assert: explicitLink targetReference isResolved.
	
	^ explicitLink
]

{ #category : #utils }
LeSnippetOperationsWithAttachedLinksExamples >> linkFromSnippetOneIn: aDatabase [
	| pageOne snippetOne |
	pageOne := aDatabase pageNamed: 'Page 1'.
	snippetOne := pageOne children first.
	
	self linkFromSnippet: snippetOne in: aDatabase.
	
	^ aDatabase
]

{ #category : #'examples - database' }
LeSnippetOperationsWithAttachedLinksExamples >> moveDownSnippetInPagePreservesExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne snippetTwo explicitLink |
	database := self databaseBaseWithContent.
	pageOne := database pageNamed: 'Page 1'.

	snippetTwo := pageOne children second.
	explicitLink := self linkFromSnippet: snippetTwo in: database.
	self linkFromSnippetOneIn: database.

	self assert: snippetTwo outgoingExplicitLinks size equals: 1.

	snippetTwo moveDown.

	self assert: snippetTwo outgoingExplicitLinks size equals: 1.
	self assert: snippetTwo outgoingExplicitLinks first equals: explicitLink.
	self assert: database explicitLinksCount equals: 2.

	^ database
]

{ #category : #'examples - database' }
LeSnippetOperationsWithAttachedLinksExamples >> moveUpSnippetInPagePreservesExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne snippetTwo explicitLink |
	database := self databaseBaseWithContent.
	pageOne := database pageNamed: 'Page 1'.

	snippetTwo := pageOne children second.
	explicitLink := self linkFromSnippet: snippetTwo in: database.
	self linkFromSnippetOneIn: database.

	self assert: snippetTwo outgoingExplicitLinks size equals: 1.

	snippetTwo moveUp.

	self assert: snippetTwo outgoingExplicitLinks size equals: 1.
	self assert: snippetTwo outgoingExplicitLinks first equals: explicitLink.
	self assert: database explicitLinksCount equals: 2.

	^ database
]
