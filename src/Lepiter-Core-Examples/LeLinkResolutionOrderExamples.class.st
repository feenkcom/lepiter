Class {
	#name : #LeLinkResolutionOrderExamples,
	#superclass : #Object,
	#instVars : [
		'storedDatabases'
	],
	#category : #'Lepiter-Core-Examples'
}

{ #category : #'examples - database' }
LeLinkResolutionOrderExamples >> addReferrersTo: aDatabase linkingTo: aLinkString [
	| aPage |
	aPage := (aDatabase pageBuilder)
				title: self referrersPageTitle;
				add.
	1 to: 20
		do: 
			[:anIndex |
			(aPage snippetBuilder)
				string: 'Snippet ' , anIndex printString , ' ' , (anIndex odd
									ifTrue: [aLinkString]
									ifFalse: ['[[' , self elsewherePageTitle , ']]']);
				add].
	^aPage
]

{ #category : #'examples - adding databases' }
LeLinkResolutionOrderExamples >> addingADatabaseResolvesAttachedLinksInBothDirections [
	<gtExample>
	<return: #LeLogicalDatabase>
	| aDatabaseOne aDatabaseTwo aPageOne aPageTwo aLinkFromOne aLinkFromTwo aLogicalDatabase |
	aDatabaseOne := self databaseNamed: 'One'.
	aDatabaseTwo := self databaseNamed: 'Two'.
	aPageOne := (aDatabaseOne pageBuilder)
				title: 'Page one';
				add.
	aPageTwo := (aDatabaseTwo pageBuilder)
				title: 'Page two';
				add.
	aPageOne
		addExplicitLinkTo: (LeLinkPageUidReference forPageUid: aPageTwo uid
				targetDatabaseUUID: aDatabaseTwo uuidString).
	aPageTwo
		addExplicitLinkTo: (LeLinkPageUidReference forPageUid: aPageOne uid
				targetDatabaseUUID: aDatabaseOne uuidString).
	self assert: aDatabaseOne explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks size equals: 1.
	aLinkFromOne := aDatabaseOne explicitLinks first.
	aLinkFromTwo := aDatabaseTwo explicitLinks first.
	self assert: aLinkFromOne targetReference isResolved not.
	self assert: aLinkFromTwo targetReference isResolved not.
	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseOne.
	aLogicalDatabase addDB: aDatabaseTwo.
	self assert: aLinkFromOne targetReference content == aPageTwo.
	self assert: aLinkFromTwo targetReference content == aPageOne.
	self assert: aLinkFromOne originReference content == aPageOne.
	self assert: aLinkFromTwo originReference content == aPageTwo.
	self assert: aPageTwo incomingLinks size equals: 1.
	self assert: aPageTwo incomingLinks first == aLinkFromOne.
	self assert: aPageOne incomingLinks size equals: 1.
	self assert: aPageOne incomingLinks first == aLinkFromTwo.
	^aLogicalDatabase
]

{ #category : #'examples - adding databases' }
LeLinkResolutionOrderExamples >> addingADatabaseResolvesEachLinkInItsTargetDatabase [
	<gtExample>
	<return: #LeLogicalDatabase>
	| aDatabaseOne aDatabaseTwo aDatabaseThree aTargetOne aTargetThree aLinkToThree aLogicalDatabase |
	aDatabaseOne := self databaseNamed: 'One'.
	aDatabaseTwo := self databaseNamed: 'Two'.
	aDatabaseThree := self databaseNamed: 'Three'.
	aTargetOne := (aDatabaseOne pageBuilder)
				title: self targetPageTitle;
				add.
	aTargetThree := (aDatabaseThree pageBuilder)
				title: self targetPageTitle;
				add.
	self addReferrersTo: aDatabaseTwo linkingTo: aTargetOne asRemoteLink.
	(((aDatabaseTwo pageBuilder)
		title: 'Other referrers';
		add) snippetBuilder)
		string: 'Link to ' , aTargetThree asRemoteLink;
		add.
	aLinkToThree := aDatabaseTwo explicitLinks items
				detect: [:each | each targetReference targetDatabaseUUID = aDatabaseThree uuidString].
	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseOne.
	aLogicalDatabase addDB: aDatabaseTwo.
	self assert: aLinkToThree targetReference isResolved not.
	self assert: aTargetThree incomingLinks isEmpty.
	self assertLinks: aTargetOne incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabaseTwo).
	self assertElsewhereLinksAreUnresolvedIn: aDatabaseTwo.
	aLogicalDatabase addDB: aDatabaseThree.
	self assert: aLinkToThree targetReference content == aTargetThree.
	self assert: aTargetThree incomingLinks size equals: 1.
	self assert: aTargetThree incomingLinks first == aLinkToThree.
	self assertLinks: aTargetOne incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabaseTwo).
	self assertElsewhereLinksAreUnresolvedIn: aDatabaseTwo.
	^aLogicalDatabase
]

{ #category : #examples }
LeLinkResolutionOrderExamples >> addingADatabaseResolvesTheCrossDatabaseLinksInCreationOrder [
	<gtExample>
	<return: #LeLogicalDatabase>
	| aDatabaseOne aDatabaseTwo aTargetPage aLogicalDatabase |
	aDatabaseOne := self databaseNamed: 'One'.
	aDatabaseTwo := self databaseNamed: 'Two'.
	aTargetPage := (aDatabaseOne pageBuilder)
				title: self targetPageTitle;
				add.
	self addReferrersTo: aDatabaseTwo linkingTo: aTargetPage asRemoteLink.
	self assert: (aDatabaseTwo explicitLinks items
				conform: [:each | each targetReference isResolved not]).
	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseOne.
	aLogicalDatabase addDB: aDatabaseTwo.
	self assertLinks: aTargetPage incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabaseTwo).
	^aLogicalDatabase
]

{ #category : #'examples - adding databases' }
LeLinkResolutionOrderExamples >> addingAnotherDatabaseDoesNotLinkResolvedLinksAgain [
	<gtExample>
	<return: #LeLogicalDatabase>
	| aLogicalDatabase aDatabaseTwo aTargetPage |
	aLogicalDatabase := self
				addingADatabaseResolvesTheCrossDatabaseLinksInCreationOrder.
	aDatabaseTwo := aLogicalDatabase databaseNamed: 'Two'.
	aTargetPage := (aLogicalDatabase databaseNamed: 'One')
				pageNamed: self targetPageTitle.
	aLogicalDatabase addDB: (self databaseNamed: 'Three').
	self assertLinks: aTargetPage incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabaseTwo).
	self assertElsewhereLinksAreUnresolvedIn: aDatabaseTwo.
	^aLogicalDatabase
]

{ #category : #'examples - adding databases' }
LeLinkResolutionOrderExamples >> addingDatabasesTogetherResolvesTheLinksBetweenThem [
	<gtExample>
	<return: #LeLogicalDatabase>
	| aDatabaseOne aDatabaseTwo aDatabaseThree aTargetTwo aTargetThree aLogicalDatabase |
	aDatabaseOne := self databaseNamed: 'One'.
	aDatabaseTwo := self databaseNamed: 'Two'.
	aDatabaseThree := self databaseNamed: 'Three'.
	aTargetTwo := (aDatabaseTwo pageBuilder)
				title: self targetPageTitle;
				add.
	aTargetThree := (aDatabaseThree pageBuilder)
				title: self targetPageTitle;
				add.
	self addReferrersTo: aDatabaseTwo linkingTo: aTargetThree asRemoteLink.
	self addReferrersTo: aDatabaseThree linkingTo: aTargetTwo asRemoteLink.
	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseOne.
	aLogicalDatabase addDBs: (Array with: aDatabaseTwo with: aDatabaseThree).
	self assertLinks: aTargetThree incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabaseTwo).
	self assertLinks: aTargetTwo incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabaseThree).
	self assertElsewhereLinksAreUnresolvedIn: aDatabaseTwo.
	self assertElsewhereLinksAreUnresolvedIn: aDatabaseThree.
	^aLogicalDatabase
]

{ #category : #'examples - adding databases' }
LeLinkResolutionOrderExamples >> addingTheTargetDatabaseResolvesTheLinksOfTheExistingDatabaseInCreationOrder [
	<gtExample>
	<return: #LeLogicalDatabase>
	| aDatabaseOne aDatabaseTwo aTargetPage aLogicalDatabase |
	aDatabaseOne := self databaseNamed: 'One'.
	aDatabaseTwo := self databaseNamed: 'Two'.
	aTargetPage := (aDatabaseOne pageBuilder)
				title: self targetPageTitle;
				add.
	self addReferrersTo: aDatabaseTwo linkingTo: aTargetPage asRemoteLink.
	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseTwo.
	self assert: aTargetPage incomingLinks isEmpty.
	aLogicalDatabase addDB: aDatabaseOne.
	self assertLinks: aTargetPage incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabaseTwo).
	self assertElsewhereLinksAreUnresolvedIn: aDatabaseTwo.
	^aLogicalDatabase
]

{ #category : #'examples - adding databases' }
LeLinkResolutionOrderExamples >> addingTheTargetDatabaseResolvesTheUnresolvedOriginOfAnAttachedLink [
	"An attached link resolves its references when it is added to a database. Its origin stays
	unresolved when the origin page is only added later. When a database is added, the origin is
	resolved only once the target of the link was found (see LeAttachedLink>>#resolveReferencesIfTargetIsFound),
	as the previous page-by-page resolution did: adding an unrelated database leaves the origin
	unresolved, adding the database of the target resolves both."
	<gtExample>
	<return: #LeLogicalDatabase>
	| aDatabaseOne aDatabaseTwo aSourcePage aTargetPage aLink aLogicalDatabase |
	aDatabaseOne := self databaseNamed: 'One'.
	aDatabaseTwo := self databaseNamed: 'Two'.
	aSourcePage := LePage named: 'Source'.
	aTargetPage := (aDatabaseTwo pageBuilder)
				title: self targetPageTitle;
				add.
	aLink := (LeAttachedLink new)
				originReference: (LeLinkPageUidReference forPageUid: aSourcePage uid);
				targetReference: (LeLinkPageUidReference forPageUid: aTargetPage uid
							targetDatabaseUUID: aDatabaseTwo uuidString).
	aDatabaseOne addExplicitLink: aLink.
	aDatabaseOne addPage: aSourcePage.
	self assert: aLink originReference isResolved not.
	self assert: aLink targetReference isResolved not.
	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseOne.
	aLogicalDatabase addDB: (self databaseNamed: 'Three').
	self assert: aLink originReference isResolved not.
	self assert: aLink targetReference isResolved not.
	aLogicalDatabase addDB: aDatabaseTwo.
	self assert: aLink targetReference content == aTargetPage.
	self assert: aLink originReference content == aSourcePage.
	self assert: aTargetPage incomingLinks size equals: 1.
	self assert: aTargetPage incomingLinks first == aLink.
	^aLogicalDatabase
]

{ #category : #examples }
LeLinkResolutionOrderExamples >> addingTheTargetPageResolvesTheLinksInCreationOrder [
	<gtExample>
	<return: #LePage>
	| aDatabase aTargetPage |
	aDatabase := self databaseWithLinksToNotYetCreatedPage.
	aTargetPage := (aDatabase pageBuilder)
				title: self targetPageTitle;
				add.
	self assertLinks: aTargetPage incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabase).
	^aTargetPage
]

{ #category : #examples }
LeLinkResolutionOrderExamples >> addingTheTargetPageWithAddPageResolvesTheLinksInCreationOrder [
	<gtExample>
	<return: #LePage>
	| aDatabase aTargetPage |
	aDatabase := self databaseWithLinksToNotYetCreatedPage.
	aTargetPage := aDatabase addPage: (LePage named: self targetPageTitle).
	self assertLinks: aTargetPage incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabase).
	^aTargetPage
]

{ #category : #asserting }
LeLinkResolutionOrderExamples >> assertElsewhereLinksAreUnresolvedIn: aDatabase [
	| theLinks |
	theLinks := aDatabase explicitLinks items
				select: [:each | each targetReference pageTitle = self elsewherePageTitle].
	self assert: theLinks size equals: 10.
	self
		assert: (theLinks conform: [:each | each targetReference isResolved not])
]

{ #category : #asserting }
LeLinkResolutionOrderExamples >> assertLinks: aCollectionOfLinks comeInCreationOrderFrom: aCollectionOfSnippets [
	self assert: aCollectionOfLinks size equals: aCollectionOfSnippets size.
	aCollectionOfLinks asArray with: aCollectionOfSnippets asArray
		do: [:eachLink :eachSnippet | self assert: eachLink origin == eachSnippet]
]

{ #category : #'examples - database' }
LeLinkResolutionOrderExamples >> databaseNamed: aString [
	| aDatabase |
	aDatabase := LeDatabase new.
	aDatabase monitor: LeVolatileMonitor new.
	aDatabase databaseName: aString.
	^aDatabase
]

{ #category : #examples }
LeLinkResolutionOrderExamples >> databaseWithLinksToNotYetCreatedPage [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self databaseNamed: 'One'.
	self addReferrersTo: aDatabase
		linkingTo: '[[' , self targetPageTitle , ']]'.
	self assert: aDatabase explicitLinksCount equals: 20.
	self assert: (self linkingSnippetsIn: aDatabase) size equals: 10.
	self assert: (aDatabase explicitLinks items
				conform: [:each | each targetReference isResolved not]).
	^aDatabase
]

{ #category : #constants }
LeLinkResolutionOrderExamples >> elsewherePageTitle [
	^'Elsewhere'
]

{ #category : #initialization }
LeLinkResolutionOrderExamples >> initialize [
	super initialize.
	storedDatabases := OrderedCollection new
]

{ #category : #'examples - database' }
LeLinkResolutionOrderExamples >> linkingSnippetsIn: aDatabase [
	^(aDatabase pageNamed: self referrersPageTitle) children asArray
		select: [:each | each string includesSubstring: self targetPageTitle]
]

{ #category : #constants }
LeLinkResolutionOrderExamples >> referrersPageTitle [
	^'Referrers'
]

{ #category : #examples }
LeLinkResolutionOrderExamples >> renamingAPageToTheTargetTitleResolvesTheLinksInCreationOrder [
	<gtExample>
	<return: #LePage>
	| aDatabase aPage |
	aDatabase := self databaseWithLinksToNotYetCreatedPage.
	aPage := (aDatabase pageBuilder)
				title: 'Other';
				add.
	self assert: aPage incomingLinks isEmpty.
	aPage updateTitle: self targetPageTitle.
	self assertLinks: aPage incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabase).
	^aPage
]

{ #category : #examples }
LeLinkResolutionOrderExamples >> scanningForLinksToTheTargetPageAnswersThemInCreationOrder [
	<gtExample>
	<return: #LeExplicitLinks>
	| aTargetPage theLinks |
	aTargetPage := self addingTheTargetPageResolvesTheLinksInCreationOrder.
	theLinks := aTargetPage database scanForLinksTo: aTargetPage.
	self assertLinks: theLinks items
		comeInCreationOrderFrom: (self linkingSnippetsIn: aTargetPage database).
	^theLinks
]

{ #category : #'examples - adding databases' }
LeLinkResolutionOrderExamples >> settingThePlaygroundDatabaseResolvesTheLinksInBothDirections [
	<gtExample>
	<after: #stopStoredDatabases>
	<return: #LeLogicalDatabase>
	| aDatabaseOne aDatabaseTwo aTargetOne aTargetTwo aLogicalDatabase |
	aDatabaseOne := self storedDatabaseNamed: 'one'.
	aDatabaseTwo := self storedDatabaseNamed: 'two'.
	aTargetOne := (aDatabaseOne pageBuilder)
				title: self targetPageTitle;
				add.
	aTargetTwo := (aDatabaseTwo pageBuilder)
				title: self targetPageTitle;
				add.
	self addReferrersTo: aDatabaseOne linkingTo: aTargetTwo asRemoteLink.
	self addReferrersTo: aDatabaseTwo linkingTo: aTargetOne asRemoteLink.
	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseOne.
	self assert: aTargetOne incomingLinks isEmpty.
	self assert: aTargetTwo incomingLinks isEmpty.
	aLogicalDatabase playgroundDB: aDatabaseTwo.
	self assert: aLogicalDatabase playgroundDB == aDatabaseTwo.
	self assertLinks: aTargetOne incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabaseTwo).
	self assertLinks: aTargetTwo incomingLinks
		comeInCreationOrderFrom: (self linkingSnippetsIn: aDatabaseOne).
	self assertElsewhereLinksAreUnresolvedIn: aDatabaseOne.
	self assertElsewhereLinksAreUnresolvedIn: aDatabaseTwo.
	^aLogicalDatabase
]

{ #category : #after }
LeLinkResolutionOrderExamples >> stopStoredDatabases [
	storedDatabases do: [:each | each stopMonitoring]
]

{ #category : #'examples - database' }
LeLinkResolutionOrderExamples >> storedDatabaseNamed: aString [
	| aFolder aStore aDatabase |
	aFolder := FileSystem memory / aString.
	aFolder ensureCreateDirectory.
	aStore := LeLocalStoreLoad current.
	aStore localRoot: aFolder.
	aDatabase := aStore loadAndMonitorFrom: aFolder saveDelay: 0 seconds.
	aDatabase databaseName: aString.
	storedDatabases add: aDatabase.
	^aDatabase
]

{ #category : #constants }
LeLinkResolutionOrderExamples >> targetPageTitle [
	^'Target'
]
