"
I exemplify {{gtClass:LeModel}} and other objects in this package.

"
Class {
	#name : #LeContentExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #'examples - model' }
LeContentExamples >> addPageToDatabase [
	<gtExample>
	| aDatabase aPage aCollection |
	aDatabase := self basicDatabase.
	aCollection := OrderedCollection new.
	aDatabase 
		when: LeDatabasePageAdded 
		do: [ :anAnnouncement | aCollection add: anAnnouncement ].
	aPage := aDatabase pageBuilder title: 'page one'; add.
	self assert: aDatabase size equals: 1.
	self assert: aDatabase anyOne equals: aPage.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicBlock [
	<gtExample>
	| aTextSnippet |
	aTextSnippet := LeTextSnippet new.
	self assert: aTextSnippet isTextSnippet.
	^ aTextSnippet
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicBlock_hasNoIncomingExplicitLinks [
	<gtExample>
	| aTextSnippet |
	aTextSnippet := self basicBlock.
	self assert: aTextSnippet incomingLinks isEmpty.
	
	^ aTextSnippet
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicBlock_hasNoOutgoingExplicitLinks [
	<gtExample>
	| aTextSnippet |
	aTextSnippet := self basicBlock.
	self assert: aTextSnippet outgoingExplicitLinks isEmpty.
	self assert: aTextSnippet outgoingTextualLinks isEmpty.
	self assert: aTextSnippet hasOutgoingTextualLinks not.
	self assert: aTextSnippet allChildOutgoingLinks size equals: 0.
	
	^ aTextSnippet
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicBlock_hasUninitializedCachedLinks [
	<gtExample>
	| aTextSnippet |
	aTextSnippet := self basicBlock.
	self assert: aTextSnippet cachedTextualLinks isNil.
	
	^ aTextSnippet
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicBlocks [
	<gtExample>
	| theParts |
	theParts := LeSnippets new.
	self assert: theParts size equals: 0.
	^ theParts
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicBlocksWithAll: anArray [
	<gtExample>
	| theParts |
	theParts := self basicBlocks.
	theParts items: anArray.
	self assert: theParts size equals: anArray size.
	^ theParts
]

{ #category : #'examples - basic' }
LeContentExamples >> basicDatabase [
	<gtExample>
	| aDatabase |
	aDatabase := LeDatabase new.
	self assert: aDatabase size equals: 0.
	self assert: aDatabase userEmail isNotNil.
	self assert: aDatabase userEmail class equals: LeEmail.
	self assert: aDatabase pages size equals: 0.
	^ aDatabase
]

{ #category : #'examples - basic' }
LeContentExamples >> basicDatabaseWithMonitor [
	<gtExample>
	<after: #stopDatabaseMonitor>
	| folderReference localStore |
	
	^ database ifNil: [ 
		folderReference := FileSystem memory / 'storage'.
		folderReference ensureCreateDirectory.
		
		localStore := LeLocalStoreLoad current.
		localStore localRoot: folderReference.
		database := localStore loadAndMonitorFrom: folderReference.
		
		self assert: database explicitLinks size equals: 0.
			
		database ]
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicPage [
	<gtExample>
	| aPage |
	aPage := LePage named: #BasicPage.
	self assert: aPage title equals: #BasicPage.
	^ aPage
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicTime [
	<gtExample>
	| aTime |
	aTime := LeTime new.
	self assert: aTime time isNil.
	self assert: aTime equals: aTime.
	^ aTime
]

{ #category : #'examples - block changes' }
LeContentExamples >> blockChangeText [
	<gtExample>
	| aBlock aCreateTime aCreateEmail anEditTime anEditEmail aNewUserEmail aNewText |
	aBlock := self textBlockInPageAndDatabase.
	aCreateTime := aBlock createTime.
	aCreateEmail := aBlock createEmail.
	anEditTime := aBlock editTime.
	anEditEmail := aBlock editEmail.
	aNewUserEmail := 'connie@dogs.com'.
	aBlock database userEmail: aNewUserEmail.
	aNewText := 'new block text' asRopedText.
	aBlock updateText: aNewText.
	self assert: aBlock text characters equals: aNewText characters.
	self assert: aBlock string equals: aNewText asString.
	self assert: aBlock createTime == aCreateTime.
	self assert: aBlock createEmail == aCreateEmail.
	self assert: (aBlock editTime == anEditTime) not.
	self assert: (aBlock editEmail == anEditEmail) not.
	self assert: aBlock editEmail equals: aBlock database userEmail.
	self assert: aBlock editEmail email equals: aNewUserEmail.
	self assert: aBlock text equals: aNewText.
	^ aBlock
]

{ #category : #'examples - model' }
LeContentExamples >> blockOne [
	<gtExample>
	| aBlock |
	aBlock := self basicBlock.
	aBlock string: self blockOneString.
	aBlock editTime: self editTimeOne.
	aBlock editEmail: self editorOne.
	self assert: aBlock string equals: self blockOneString.
	self assert: aBlock editTime equals: self editTimeOne.
	self assert: aBlock editEmail equals: self editorOne.
	^ aBlock
]

{ #category : #accessing }
LeContentExamples >> blockOneString [
	^ 'block one content'
]

{ #category : #'examples - model' }
LeContentExamples >> blockOne_hasNoCachedLinks [
	<gtExample>
	| aBlock |
	aBlock := self blockOne.
	
	self assert: aBlock cachedTextualLinks notNil.
	self assert: aBlock cachedTextualLinks isEmpty.
	
	^ aBlock
]

{ #category : #'examples - model' }
LeContentExamples >> blockThree [
	<gtExample>
	| aBlock |
	aBlock := self basicBlock.
	aBlock string: self blockThreeString.
	aBlock editTime: self editTimeOne.
	aBlock editEmail: self editorOne.
	self assert: aBlock string equals: self blockThreeString.
	self assert: aBlock editTime equals: self editTimeOne.
	self assert: aBlock editEmail equals: self editorOne.
	^ aBlock
]

{ #category : #accessing }
LeContentExamples >> blockThreeString [
	^ 'block three content'
]

{ #category : #'examples - model' }
LeContentExamples >> blockTwo [
	<gtExample>
	| aBlock |
	aBlock := self basicBlock.
	aBlock string: self blockTwoString.
	aBlock editTime: self editTimeOne.
	aBlock editEmail: self editorOne.
	self assert: aBlock string equals: self blockTwoString.
	self assert: aBlock editTime equals: self editTimeOne.
	self assert: aBlock editEmail equals: self editorOne.
	^ aBlock
]

{ #category : #accessing }
LeContentExamples >> blockTwoString [
	^ 'block two content'
]

{ #category : #accessing }
LeContentExamples >> breadthFirstForPageOneWithTwoBlocksAndWithBlockChild [
	<gtExample>
	| page allChildren |
	page := self pageOneWithTwoBlocksAndWithBlockChild.
	allChildren := page allChildrenBreadthFirst.
	self assert: allChildren size = 3.
	self assert: allChildren first contentAsString = self blockOneString.
	self assert: allChildren second contentAsString = self blockThreeString.
	self assert: allChildren third contentAsString = self blockTwoString.
	^ page
]

{ #category : #'examples - basic' }
LeContentExamples >> characterTextsAreEqual [
	<gtExample>
	"This assertion is important in ${method:LeBlockTextEditorElement>>#updateEditorText}$"
	self assert: 'a' asRopedText characters equals: 'a' asRopedText characters.
	self assert: 'a' asRopedText ~= 'a' asRopedText.
	^ 'a' asRopedText
]

{ #category : #'examples - time' }
LeContentExamples >> compareEarlierAndNewerTimes [
	<gtExample>
	| aDateAndTime aTimeOne aTimeTwo |
	aDateAndTime := DateAndTime now.
	aTimeOne := self basicTime time: aDateAndTime - 1 second.
	aTimeTwo := self basicTime time: aDateAndTime.
	self assert: (aTimeOne = aTimeTwo) not.
	self assert: (aTimeOne < aTimeTwo).
	self assert: (aTimeOne <= aTimeTwo).
	self assert: (aTimeOne > aTimeTwo) not.
	self assert: (aTimeOne >= aTimeTwo) not.
	^ aTimeOne
]

{ #category : #'examples - time' }
LeContentExamples >> compareNewerAndEarlierTimes [
	<gtExample>
	| aDateAndTime aTimeOne aTimeTwo |
	aDateAndTime := DateAndTime now.
	aTimeOne := self basicTime time: aDateAndTime.
	aTimeTwo := self basicTime time: aDateAndTime - 1 second.
	self assert: (aTimeOne = aTimeTwo) not.
	self assert: (aTimeOne < aTimeTwo) not.
	self assert: (aTimeOne <= aTimeTwo) not.
	self assert: (aTimeOne > aTimeTwo).
	self assert: (aTimeOne >= aTimeTwo).
	^ aTimeOne
]

{ #category : #'examples - time' }
LeContentExamples >> compareSameTimes [
	<gtExample>
	| aDateAndTime aTimeOne aTimeTwo |
	aDateAndTime := DateAndTime now.
	aTimeOne := self basicTime time: aDateAndTime.
	aTimeTwo := self basicTime time: aDateAndTime.
	self assert: aTimeOne equals: aTimeTwo.
	self assert: (aTimeOne < aTimeTwo) not.
	self assert: (aTimeOne <= aTimeTwo).
	self assert: (aTimeOne > aTimeTwo) not.
	self assert: (aTimeOne >= aTimeTwo).
	^ aTimeOne
]

{ #category : #'examples - model support' }
LeContentExamples >> editTimeOne [
	<gtExample>
	^ LeTime new 
		time: '2020-03-01 16:55:00' asDateAndTime
]

{ #category : #'examples - model support' }
LeContentExamples >> editorOne [
	<gtExample>
	^ LeEmail new 
		email: 'one@example.com'
]

{ #category : #'examples - model' }
LeContentExamples >> onePageWithOneBlockAndLinkToNotExistingPage [
	<gtExample>
	| aDatabase aPageOne aSnippetOne |
	aDatabase := self basicDatabaseWithMonitor.
	
	aPageOne := aDatabase pageBuilder title: 'one'; add.
	aSnippetOne := aPageOne snippetBuilder string: '[[two]]'; add.
	
	self assert: aDatabase pageCount equals: 1.
	self assert: aPageOne incomingLinks size equals: 0.
	
	self assert: aSnippetOne incomingLinks size equals: 0.
	self assert: aSnippetOne outgoingExplicitLinks size equals: 1.
	self assert: aSnippetOne outgoingTextualLinks size equals: 1.
	self assert: aSnippetOne cachedTextualLinks isNil.
	
	self assert: aDatabase explicitLinksCount equals: 1.
	
	^ aDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> onePageWithOneBlockAndLinkToNotExistingPage_AddPageTwo [
	<gtExample>
	| aDatabase aPageTwo |
	aDatabase := self onePageWithOneBlockAndLinkToNotExistingPage.
	
	aPageTwo := aDatabase pageBuilder title: 'two'; add.
	
	self assert: aPageTwo incomingLinks size equals: 1.
	self assert: aDatabase explicitLinksCount equals: 1.
	self assert: (aDatabase scanForLinksTo: aPageTwo) size equals: 1.
	self assert: aPageTwo incomingLinks size equals: 1.
	
	^ aDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> onePageWithOneBlockAndLinkToNotExistingPage_AddPageTwo_AddPageThree [
	<gtExample>
	| aDatabase aPageOne aBlockOne aPageTwo |
	aDatabase := self onePageWithOneBlockAndLinkToNotExistingPage_AddPageTwo.
	aPageOne := aDatabase pageNamed: 'one'.
	aBlockOne := aPageOne children first.
	aPageTwo := aDatabase pageBuilder
		title: 'three';
		add.
	self assert: aPageOne incomingLinks size equals: 0.
	self assert: aPageTwo incomingLinks size equals: 0.
	self assert: aBlockOne incomingLinks size equals: 0.
	self assert: aBlockOne outgoingTextualLinks size equals: 1.
	self assert: aBlockOne outgoingExplicitLinks size equals: 1.
	self assert: aDatabase explicitLinksCount equals: 1.
	^ aDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> onePageWithOneBlockAndLinkToNotExistingPage_AddPageTwo_AddPageThree_RenameToTwo [
	<gtExample>
	| aDatabase aPageOne aBlockOne aPageTwo |
	aDatabase := self
		onePageWithOneBlockAndLinkToNotExistingPage_AddPageTwo_AddPageThree.
	aPageOne := aDatabase pageNamed: 'one'.
	aPageTwo := aDatabase pageNamed: 'two'.
	aBlockOne := aPageOne children first.
	aPageTwo updateTitle: 'two'.
	self assert: aPageOne incomingLinks size equals: 0.
	self assert: aPageTwo incomingLinks size equals: 1.
	self assert: aBlockOne incomingLinks size equals: 0.
	self assert: aBlockOne outgoingExplicitLinks size equals: 1.
	self assert: aBlockOne outgoingTextualLinks size equals: 1.
	self assert: aDatabase explicitLinksCount equals: 1.
	self assert: (aDatabase scanForLinksTo: aPageTwo) size equals: 1.
	self assert: aPageTwo incomingLinks size equals: 1.
	^ aDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> onePageWithOneBlockAndLinkToNotExistingPage_AddPageTwo_AddPageThree_RenameToTwo_RenameToThree [
	<gtExample>
	| aDatabase aPageOne aBlockOne aPageTwo |
	aDatabase := self
		onePageWithOneBlockAndLinkToNotExistingPage_AddPageTwo_AddPageThree.
	aPageOne := aDatabase pageNamed: 'one'.
	aPageTwo := aDatabase pageNamed: 'two'.
	aBlockOne := aPageOne children first.
	self assert: aPageTwo database equals: aDatabase.
	aPageTwo updateTitle: 'four'.
	self assert: aPageOne incomingLinks size equals: 0.
	self assert: aPageTwo incomingLinks size equals: 1.
	self assert: aBlockOne incomingLinks size equals: 0.
	self assert: aBlockOne outgoingExplicitLinks size equals: 1.
	self assert: aBlockOne outgoingTextualLinks size equals: 1.
	self
		assert: aBlockOne outgoingExplicitLinks first targetPageTitle
		equals: 'four'.
	self
		assert: aBlockOne outgoingTextualLinks first targetPageTitle
		equals: 'four'.
	self assert: aDatabase explicitLinksCount equals: 1.
	^ aDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> pageOne [
	<gtExample>
	| aPage |
	aPage := self basicPage.
	aPage title: self pageOneTitle.
	aPage editTime: self editTimeOne.
	aPage editEmail: self editorOne.
	self assert: aPage title equals: self pageOneTitle.
	self assert: aPage editTime equals: self editTimeOne.
	self assert: aPage editEmail equals: self editorOne.
	^ aPage
]

{ #category : #'examples - model support' }
LeContentExamples >> pageOneTitle [
	^ 'Page One'
]

{ #category : #'examples - model' }
LeContentExamples >> pageOneWithOneBlock [
	<gtExample>
	| aPage aPart |
	aPage := self pageOne.
	aPart := self blockOne.
	aPage children: (self basicBlocksWithAll: { aPart }).
	self assert: aPage hasChildren.
	self assert: aPage childrenCount equals: 1.
	self assert: aPage children items first equals: aPart.
	^ aPage
]

{ #category : #'examples - model' }
LeContentExamples >> pageOneWithOneBlockWithChild [
	<gtExample>
	| aPage aSnippet |
	aPage := self pageOne.
	aSnippet := self snippetOneWithOneChild.
	aPage children: (self basicBlocksWithAll: { aSnippet }).
	self assert: aPage hasChildren.
	self assert: aPage childrenCount equals: 1.
	self assert: aPage children items first equals: aSnippet.
	^ aPage
]

{ #category : #'examples - model' }
LeContentExamples >> pageOneWithTwoBlocks [
	<gtExample>
	| aPage aPart |
	aPage := self pageOneWithOneBlock.
	aPart := self blockTwo.
	aPage children: (self basicBlocksWithAll: (aPage children items copyWith: aPart)).
	self assert: aPage hasChildren.
	self assert: aPage childrenCount equals: 2.
	self assert: aPage children items second equals: aPart.
	^ aPage
]

{ #category : #'examples - model' }
LeContentExamples >> pageOneWithTwoBlocksAndWithBlockChild [
	<gtExample>
	| aPage aPart |
	aPage := self pageOneWithOneBlockWithChild.
	aPart := self blockTwo.
	aPage children: (self basicBlocksWithAll: (aPage children items copyWith: aPart)).
	self assert: aPage hasChildren.
	self assert: aPage childrenCount equals: 2.
	self assert: aPage children items second equals: aPart.
	^ aPage
]

{ #category : #'examples - model' }
LeContentExamples >> removeBlockFromParent [
	<gtExample>
	| aSnippet aChild |
	aSnippet := self blockOne.
	aChild := self blockTwo.
	aSnippet addSnippet: aChild.
	self assert: aChild parent equals: aSnippet.
	self assert: aSnippet hasChildren.
	aSnippet removeSnippet: aChild.
	self assert: aChild parent equals: nil.
	self assert: aSnippet hasChildren not.
	^ aSnippet
]

{ #category : #'examples - text changes' }
LeContentExamples >> removeLinkToEmptyPage [
	"Removing a link to an empty page should remove that page"
	<gtExample>
	| aDatabase referringPage emptyPage removedPages |

	removedPages := OrderedCollection new.
	aDatabase := self addPageToDatabase.
	emptyPage := aDatabase pageBuilder title: 'an empty page'; add.
	
	aDatabase when: LeDatabasePageRemoved do: [ :announcement |
		removedPages add: announcement page ].
	referringPage := aDatabase anyOne.
	referringPage snippetBuilder 
		string: 'Link to [[an empty page]]';
		add.
	
	aDatabase removePage: referringPage.
	
	self assert: aDatabase hasChildren not.
	self assert: aDatabase linksCount equals: 0.
	self assert: removedPages size equals: 2.
	self assert: removedPages first equals: emptyPage.
	self assert: removedPages second equals: referringPage.
	self assert: aDatabase sortedPages size equals: 0.
	^ aDatabase
]

{ #category : #'examples - text changes' }
LeContentExamples >> removeLinkToNonExistingPage [
	"Removing a link to a page that does not exist"
	<gtExample>
	| aDatabase referringPage removedPages |

	removedPages := OrderedCollection new.
	aDatabase := self addPageToDatabase.
	
	aDatabase when: LeDatabasePageRemoved do: [ :announcement |
		removedPages add: announcement page ].
	referringPage := aDatabase anyOne.
	referringPage snippetBuilder 
		string: 'Link to [[an empty page]]';
		add.
	
	aDatabase removePage: referringPage.
	
	self assert: aDatabase hasChildren not.
	self assert: aDatabase linksCount equals: 0.
	self assert: removedPages size equals: 1.
	self assert: removedPages first equals: referringPage.
	self assert: aDatabase sortedPages size equals: 0.
	^ aDatabase
]

{ #category : #removing }
LeContentExamples >> removePageWithExistingTextualLink [
	"Remove a page for which there exist textual links in other pages"

	<gtExample>
	| localDatabase page1 snippet page2 |
	localDatabase := LeDatabase new.
	page1 := localDatabase pageBuilder
		title: 'Page1';
		add.
	page1 addSnippet: (LeTextSnippet string: 'Page1 isn''t empty').
	page2 := localDatabase pageBuilder
		title: 'Page2';
		add.
	page2 addSnippet: (LeTextSnippet string: 'Page2 isn''t empty').
	snippet := page2
		addSnippet: (LeTextSnippet string: 'link to [[Page1]] here').
	self assert: page2 allOutgoingExplicitLinks size equals: 1.
	self assert: page2 allChildOutgoingLinks size equals: 1.
	self
		assert: page2 allOutgoingExplicitLinks first target
		equals: page1.
	self assert: page2 allChildOutgoingLinks first target equals: page1.
	self assert: page1 hasIncomingLinks.
	self assert: page1 incomingLinks first origin equals: snippet.
	page1 removeSelf.
	self assert: page2 allOutgoingExplicitLinks size equals: 1.
	self assert: page2 allChildOutgoingLinks size equals: 1.
	self deny: page1 hasIncomingLinks.
	^ localDatabase
]

{ #category : #removing }
LeContentExamples >> removeSnippetWithLink [
	"Remove a snippet with a link to another page and ensure that the incoming links for the target page are updated"

	<gtExample>
	| localDatabase page1 snippet page2 |
	localDatabase := LeDatabase new.
	page1 := localDatabase pageBuilder
		title: 'Page1';
		add.
	page1 addSnippet: (LeTextSnippet string: 'Page1 isn''t empty').
	page2 := localDatabase pageBuilder
		title: 'Page2';
		add.
	page2 addSnippet: (LeTextSnippet string: 'Page2 isn''t empty').
	snippet := page2
		addSnippet: (LeTextSnippet string: 'link to [[Page1]] here').
	self assert: page2 allOutgoingExplicitLinks size equals: 1.
	self assert: page2 allChildOutgoingLinks size equals: 1.
	self
		assert: page2 allOutgoingExplicitLinks first target
		equals: page1.
	self assert: page2 allChildOutgoingLinks first target equals: page1.
	self assert: page1 hasIncomingLinks.
	self assert: page1 incomingLinks first origin equals: snippet.
	snippet removeSelf.
	self assert: page2 allOutgoingExplicitLinks isEmpty.
	self assert: page2 allChildOutgoingLinks isEmpty.
	self deny: page1 hasIncomingLinks.
	^ localDatabase
]

{ #category : #'examples - text changes' }
LeContentExamples >> renameDatabasePageToUnnamed_PageTitleChanged_ReceivedByDatabase [
	<gtExample>
	| aDatabase aPage aCollection |
	aDatabase := self renameDatabasePage_PageTitleChanged_ReceivedByDatabase.
	aCollection := OrderedCollection new.
	aDatabase 
		when: LePageTitleChanged
		do: [ :anAnnouncement | aCollection add: anAnnouncement ].
	aPage := aDatabase anyOne.
	aPage updateTitle: ''.
	self assert: aDatabase size equals: 1.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #'examples - text changes' }
LeContentExamples >> renameDatabasePage_DatabaseResorted_AnnouncedByDatabase [
	<gtExample>
	| aDatabase aPage aCollection |
	aDatabase := self addPageToDatabase.
	aCollection := OrderedCollection new.
	aDatabase 
		when: LeDatabaseResorted
		do: [ :anAnnouncement | aCollection add: anAnnouncement ].
	aPage := aDatabase anyOne.
	aPage updateTitle: 'page two'.
	self assert: aDatabase size equals: 1.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #'examples - text changes' }
LeContentExamples >> renameDatabasePage_PageTitleChanged_AnnouncedByPage [
	<gtExample>
	| aDatabase aPage aCollection |
	aDatabase := self addPageToDatabase.
	aCollection := OrderedCollection new.
	aPage := aDatabase anyOne.
	aPage 
		when: LePageTitleChanged
		do: [ :anAnnouncement | aCollection add: anAnnouncement ].
	aPage updateTitle: 'page two'.
	self assert: aDatabase size equals: 1.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #'examples - text changes' }
LeContentExamples >> renameDatabasePage_PageTitleChanged_ReceivedByDatabase [
	<gtExample>
	| aDatabase aPage aCollection |
	aDatabase := self addPageToDatabase.
	aCollection := OrderedCollection new.
	aDatabase 
		when: LePageTitleChanged
		do: [ :anAnnouncement | aCollection add: anAnnouncement ].
	aPage := aDatabase anyOne.
	aPage updateTitle: 'page two'.
	self assert: aDatabase size equals: 1.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> snippetOneWithOneChild [
	<gtExample>
	| aSnippet aChild |
	aSnippet := self blockOne.
	aChild := self blockThree.
	aSnippet children: (self basicBlocksWithAll: { aChild }).
	self assert: aChild parent equals: aSnippet.
	self assert: aSnippet hasChildren.
	self assert: aSnippet childrenCount equals: 1.
	self assert: aSnippet children items first equals: aChild.
	^ aSnippet
]

{ #category : #'examples - model' }
LeContentExamples >> sortedPagesInitializesWithAllAvailablePages [
	"When creating initially the sorted pages cache all pages should be added there."
	<gtExample>
	| basicDatabase unnamedPage pharoClassPage |
	basicDatabase := self basicDatabase.

	basicDatabase pageBuilder title: 'page one'; add.
	unnamedPage := LePage unnamedPage.
	basicDatabase addPage: unnamedPage.
	pharoClassPage := LePage pharoClassName: self class name.
	basicDatabase addPage: pharoClassPage.
	
	self assert: basicDatabase hasSortedItems not.
	
	self assert: basicDatabase size equals: 3.
	self assert: basicDatabase sortedPages size equals: 3.
	^ basicDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> sortedPagesRemoveUnnamedPageAfterInitialization [
	"Remove an unnamed pages after pages by date was computed. This verifies that 
	pages by date was initialized correctly."
	<gtExample>
	| basicDatabase unnamedPage pharoClassPage |
	basicDatabase := self basicDatabase.

	basicDatabase pageBuilder title: 'page one'; add.
	unnamedPage := LePage unnamedPage.
	basicDatabase addPage: unnamedPage.
	pharoClassPage := LePage pharoClassName: self class name.
	basicDatabase addPage: pharoClassPage.
	
	basicDatabase sortedPages.
	self assert: basicDatabase sortedPages size equals: 3.
	self assert: basicDatabase hasSortedItems.
	
	basicDatabase removePage: unnamedPage.
	
	self assert: basicDatabase size equals: 2.
	self assert: basicDatabase sortedPages size equals: 2.
	^ basicDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> sortedPagesRemoveUnnamedPageBeforeInitialization [
	"Remove an unnamed pages before pages by date was computed."
	<gtExample>
	| basicDatabase unnamedPage pharoClassPage |
	basicDatabase := self basicDatabase.

	basicDatabase pageBuilder title: 'page one'; add.
	unnamedPage := LePage unnamedPage.
	basicDatabase addPage: unnamedPage.
	pharoClassPage := LePage pharoClassName: self class name.
	basicDatabase addPage: pharoClassPage.
	
	self assert: basicDatabase hasSortedItems not.
	basicDatabase removePage: unnamedPage.
	self assert: basicDatabase hasSortedItems not.
	
	self assert: basicDatabase size equals: 2.
	self assert: basicDatabase sortedPages size equals: 2.
	^ basicDatabase
]

{ #category : #'examples - basic' }
LeContentExamples >> stopDatabaseMonitor [
	database ifNotNil: [ database stopMonitoring ]
]

{ #category : #'examples - model' }
LeContentExamples >> textBlockInPageAndDatabase [
	<gtExample>
	| aDatabase aPage aSnippet |
	aDatabase := self basicDatabase.
	aPage := aDatabase pageBuilder title: 'one'; add.
	aSnippet := aPage snippetBuilder string: 'one > one'; add.
	self assert: aSnippet string equals: 'one > one'.
	self assert: aSnippet parent equals: aPage.
	self assert: aSnippet database equals: aDatabase.
	self assert: aSnippet createTime isNotNil.
	self assert: aSnippet createTime <= LeTime now.
	self assert: aSnippet createEmail equals: aDatabase userEmail.
	self assert: aSnippet editTime equals: aSnippet createTime.
	self assert: aSnippet editEmail equals: aSnippet createEmail.
	^ aSnippet
]

{ #category : #'examples - model' }
LeContentExamples >> twoPagesWithOneBlockEachAndLinksToTheFirstPage [
	<gtExample>
	| aDatabase aPageOne aPageTwo aSnippetOne aSnippetTwo |
	aDatabase := self basicDatabase.
	aPageOne := aDatabase pageBuilder title: 'one'; add.
	aPageTwo := aDatabase pageBuilder title: 'two'; add.
	aSnippetOne := aPageOne snippetBuilder string: '[[one]]'; add.
	aSnippetTwo := aPageTwo snippetBuilder string: '[[one]]'; add.
	self assert: aPageOne incomingLinks size equals: 2.
	self assert: aPageTwo incomingLinks size equals: 0.
	self assert: aSnippetOne incomingLinks size equals: 0.
	self assert: aSnippetTwo incomingLinks size equals: 0.
	self assert: aSnippetOne outgoingExplicitLinks size equals: 1.
	self assert: aSnippetTwo outgoingExplicitLinks size equals: 1.
	self assert: aSnippetOne outgoingTextualLinks size equals: 1.
	self assert: aSnippetTwo outgoingTextualLinks size equals: 1.
	self assert: aDatabase explicitLinksCount equals: 2.
	^ aDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> twoPagesWithOneBlockEachAndLinksToTheFirstPage_DeleteOneLink [
	<gtExample>
	| aDatabase aPageOne aPageTwo aBlockOne aBlockTwo |
	aDatabase := self twoPagesWithOneBlockEachAndLinksToTheFirstPage.
	aPageOne := aDatabase pageNamed: 'one'.
	aPageTwo := aDatabase pageNamed: 'two'.
	aBlockOne := aPageOne children first.
	aBlockTwo := aPageTwo children first.
	aBlockOne updateString: 'new content'.
	self assert: aPageOne incomingLinks size equals: 1.
	self assert: aPageTwo incomingLinks size equals: 0.
	self assert: aBlockOne incomingLinks size equals: 0.
	self assert: aBlockTwo incomingLinks size equals: 0.
	self assert: aBlockOne outgoingExplicitLinks size equals: 0.
	self assert: aBlockOne outgoingTextualLinks size equals: 0.
	self assert: aBlockTwo outgoingExplicitLinks size equals: 1.
	self assert: aBlockTwo outgoingTextualLinks size equals: 1.
	self assert: aDatabase explicitLinksCount equals: 1.
	^ aDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> twoPagesWithOneBlockEachAndLinksToTheFirstPage_RenamePageOnce [
	<gtExample>
	| aDatabase aPageOne aPageTwo aBlockOne aBlockTwo |
	aDatabase := self twoPagesWithOneBlockEachAndLinksToTheFirstPage.
	aPageOne := aDatabase pageNamed: 'one'.
	aPageTwo := aDatabase pageNamed: 'two'.
	aBlockOne := aPageOne children first.
	aBlockTwo := aPageTwo children first.
	aPageOne updateTitle: 'updated one'.
	self assert: aPageOne incomingLinks size equals: 2.
	self assert: aPageTwo incomingLinks size equals: 0.
	self assert: aBlockOne incomingLinks size equals: 0.
	self assert: aBlockTwo incomingLinks size equals: 0.
	self assert: aBlockOne outgoingExplicitLinks size equals: 1.
	self assert: aBlockTwo outgoingExplicitLinks size equals: 1.
	self assert: aBlockOne outgoingTextualLinks size equals: 1.
	self assert: aBlockTwo outgoingTextualLinks size equals: 1.
	self assert: aDatabase explicitLinksCount equals: 2.
	self assert: aBlockOne string equals: '[[updated one]]'.
	self assert: aBlockTwo string equals: '[[updated one]]'.
	^ aDatabase
]
