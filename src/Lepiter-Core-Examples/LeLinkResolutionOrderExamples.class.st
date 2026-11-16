Class {
	#name : #LeLinkResolutionOrderExamples,
	#superclass : #Object,
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

{ #category : #constants }
LeLinkResolutionOrderExamples >> targetPageTitle [
	^'Target'
]
