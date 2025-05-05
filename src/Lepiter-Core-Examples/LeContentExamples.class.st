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
	<return: #LeDatabase>
	| aDatabase aPage aCollection |
	aDatabase := self basicDatabase.
	aCollection := OrderedCollection new.

	aDatabase weak
		when: Announcement
		send: #add:
		to: aCollection.	"LeDatabasePageAdded"
	aPage := LePage named: 'page one'.
	aPage addSnippet: (LeTextSnippet string: 'snippet one').
	aPage addSnippet: (LeTextSnippet string: 'snippet two').
	aDatabase addPage: aPage.

	self assert: aDatabase size equals: 1.
	self assert: aDatabase anyOne equals: aPage.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #asserting }
LeContentExamples >> assertTextChangedAnnouncementFor: aSnippet from: anAnnouncer [
	<gtExample>
	| announcements newText |
	
	announcements := OrderedCollection new.
	anAnnouncer when: Announcement send: #add: to: announcements.

	newText := 'new block text' asRopedText.
	aSnippet updateText: newText.
	
	self assert: aSnippet text characters equals: newText characters.
	self assert: aSnippet string equals: newText asString.
	
	self assert: announcements size equals: 1.
	self assert: announcements first class equals: LeSnippetTextChanged.
	self assert: announcements first snippet equals: aSnippet.
]

{ #category : #'examples - basic' }
LeContentExamples >> basicDatabase [
	<gtExample>
	<return: #LeDatabase>
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
	<return: #LeDatabase>
	| folderReference localStore |
	^ database
		ifNil: [ folderReference := FileSystem memory / 'storage'.
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
	<return: #LePage>
	| aPage |
	aPage := LePage named: #BasicPage.
	self assert: aPage title equals: #BasicPage.
	^ aPage
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicSnippet [
	<gtExample>
	<return: #LeTextSnippet>
	| aTextSnippet |
	aTextSnippet := LeTextSnippet new.
	self assert: aTextSnippet isTextSnippet.
	^ aTextSnippet
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicSnippet_hasNoIncomingExplicitLinks [
	<gtExample>
	<return: #LeTextSnippet>
	| aTextSnippet |
	aTextSnippet := self basicSnippet.
	self assert: aTextSnippet incomingLinks isEmpty.

	^ aTextSnippet
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicSnippet_hasNoOutgoingExplicitLinks [
	<gtExample>
	<return: #LeTextSnippet>
	| aTextSnippet |
	aTextSnippet := self basicSnippet.
	self assert: aTextSnippet outgoingExplicitLinks isEmpty.
	self assert: aTextSnippet outgoingTextualLinks isEmpty.
	self assert: aTextSnippet hasOutgoingTextualLinks not.
	self assert: aTextSnippet allChildOutgoingLinks size equals: 0.

	^ aTextSnippet
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicSnippet_hasUninitializedCachedLinks [
	<gtExample>
	<return: #LeTextSnippet>
	| aTextSnippet |
	aTextSnippet := self basicSnippet.
	self assert: aTextSnippet cachedTextualLinks isNil.

	^ aTextSnippet
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicSnippets [
	<gtExample>
	<return: #LeSnippets>
	| theParts |
	theParts := LeSnippets new.
	self assert: theParts size equals: 0.
	^ theParts
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicSnippetsWithAll: anArray [
	<gtExample>
	| theParts |
	theParts := self basicSnippets.
	theParts items: anArray.
	self assert: theParts size equals: anArray size.
	^ theParts
]

{ #category : #'examples - model basic' }
LeContentExamples >> basicTime [
	<gtExample>
	<return: #LeTime>
	| aTime |
	aTime := LeTime new.
	self assert: aTime time isNil.
	self assert: aTime equals: aTime.
	^ aTime
]

{ #category : #accessing }
LeContentExamples >> breadthFirstForPageOneWithTwoSnippetsAndWithSnippetChild [
	<gtExample>
	<return: #LePage>
	| page allChildren |
	page := self pageOneWithTwoSnippetsAndWithSnippetChild.
	allChildren := page allChildrenBreadthFirst.
	self assert: allChildren size = 3.
	self assert: allChildren first contentAsString = self snippetOneString.
	self assert: allChildren second contentAsString = self snippetTwoString.
	self assert: allChildren third contentAsString = self snippetThreeString.
	^ page
]

{ #category : #'examples - basic' }
LeContentExamples >> characterTextsAreEqual [
	"This assertion is important in ${method:LeBlockTextEditorElement>>#updateEditorText}$"

	<gtExample>
	<return: #BlRunRopedText>
	self assert: 'a' asRopedText characters equals: 'a' asRopedText characters.
	self assert: 'a' asRopedText ~= 'a' asRopedText.
	^ 'a' asRopedText
]

{ #category : #'examples - time' }
LeContentExamples >> compareEarlierAndNewerTimes [
	<gtExample>
	<return: #LeTime>
	| aDateAndTime aTimeOne aTimeTwo |
	aDateAndTime := DateAndTime now.
	aTimeOne := self basicTime time: aDateAndTime - 1 second.
	aTimeTwo := self basicTime time: aDateAndTime.
	self assert: (aTimeOne = aTimeTwo) not.
	self assert: aTimeOne < aTimeTwo.
	self assert: aTimeOne <= aTimeTwo.
	self assert: (aTimeOne > aTimeTwo) not.
	self assert: (aTimeOne >= aTimeTwo) not.
	^ aTimeOne
]

{ #category : #'examples - time' }
LeContentExamples >> compareNewerAndEarlierTimes [
	<gtExample>
	<return: #LeTime>
	| aDateAndTime aTimeOne aTimeTwo |
	aDateAndTime := DateAndTime now.
	aTimeOne := self basicTime time: aDateAndTime.
	aTimeTwo := self basicTime time: aDateAndTime - 1 second.
	self assert: (aTimeOne = aTimeTwo) not.
	self assert: (aTimeOne < aTimeTwo) not.
	self assert: (aTimeOne <= aTimeTwo) not.
	self assert: aTimeOne > aTimeTwo.
	self assert: aTimeOne >= aTimeTwo.
	^ aTimeOne
]

{ #category : #'examples - time' }
LeContentExamples >> compareSameTimes [
	<gtExample>
	<return: #LeTime>
	| aDateAndTime aTimeOne aTimeTwo |
	aDateAndTime := DateAndTime now.
	aTimeOne := self basicTime time: aDateAndTime.
	aTimeTwo := self basicTime time: aDateAndTime.
	self assert: aTimeOne equals: aTimeTwo.
	self assert: (aTimeOne < aTimeTwo) not.
	self assert: aTimeOne <= aTimeTwo.
	self assert: (aTimeOne > aTimeTwo) not.
	self assert: aTimeOne >= aTimeTwo.
	^ aTimeOne
]

{ #category : #'examples - model support' }
LeContentExamples >> editTimeOne [
	<gtExample>
	<return: #LeTime>
	^ LeTime new time: '2020-03-01 16:55:00' asDateAndTime
]

{ #category : #'examples - model support' }
LeContentExamples >> editorOne [
	<gtExample>
	<return: #LeEmail>
	^ LeEmail new email: 'one@example.com'
]

{ #category : #'examples - model' }
LeContentExamples >> onePageWithOneSnippetAndLinkToNotExistingPage [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPageOne aSnippetOne |
	aDatabase := self basicDatabaseWithMonitor.

	aPageOne := aDatabase pageBuilder
			title: 'one';
			add.
	aSnippetOne := aPageOne snippetBuilder
			string: '[[two]]';
			add.

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
LeContentExamples >> onePageWithOneSnippetAndLinkToNotExistingPage_AddPageTwo [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPageTwo |
	aDatabase := self onePageWithOneSnippetAndLinkToNotExistingPage.

	aPageTwo := aDatabase pageBuilder
			title: 'two';
			add.

	self assert: aPageTwo incomingLinks size equals: 1.
	self assert: aDatabase explicitLinksCount equals: 1.
	self assert: (aDatabase scanForLinksTo: aPageTwo) size equals: 1.
	self assert: aPageTwo incomingLinks size equals: 1.

	^ aDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> onePageWithOneSnippetAndLinkToNotExistingPage_AddPageTwo_AddPageThree [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPageOne aBlockOne aPageTwo |
	aDatabase := self onePageWithOneSnippetAndLinkToNotExistingPage_AddPageTwo.
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
LeContentExamples >> onePageWithOneSnippetAndLinkToNotExistingPage_AddPageTwo_AddPageThree_RenameToTwo [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPageOne aBlockOne aPageTwo |
	aDatabase := self
			onePageWithOneSnippetAndLinkToNotExistingPage_AddPageTwo_AddPageThree.
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
LeContentExamples >> onePageWithOneSnippetAndLinkToNotExistingPage_AddPageTwo_AddPageThree_RenameToTwo_RenameToThree [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPageOne aBlockOne aPageTwo |
	aDatabase := self
			onePageWithOneSnippetAndLinkToNotExistingPage_AddPageTwo_AddPageThree.
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
	<return: #LePage>
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
LeContentExamples >> pageOneWithOneSnippet [
	<gtExample>
	<return: #LePage>
	| aPage aPart |
	aPage := self pageOne.
	aPart := self snippetOne.
	aPage children: (self basicSnippetsWithAll: {aPart}).
	self assert: aPage hasChildren.
	self assert: aPage childrenCount equals: 1.
	self assert: aPage children items first equals: aPart.
	^ aPage
]

{ #category : #'examples - model' }
LeContentExamples >> pageOneWithOneSnippetWithChild [
	<gtExample>
	<return: #LePage>
	| aPage aSnippet |
	aPage := self pageOne.
	aSnippet := self snippetOneWithOneChild.
	aPage children: (self basicSnippetsWithAll: {aSnippet}).
	self assert: aPage hasChildren.
	self assert: aPage childrenCount equals: 1.
	self assert: aPage children items first equals: aSnippet.
	^ aPage
]

{ #category : #'examples - model' }
LeContentExamples >> pageOneWithTwoSnippets [
	<gtExample>
	<return: #LePage>
	| aPage aPart |
	aPage := self pageOneWithOneSnippet.
	aPart := self snippetTwo.
	aPage
		children: (self basicSnippetsWithAll: (aPage children items copyWith: aPart)).
	self assert: aPage hasChildren.
	self assert: aPage childrenCount equals: 2.
	self assert: aPage children items second equals: aPart.
	^ aPage
]

{ #category : #'examples - model' }
LeContentExamples >> pageOneWithTwoSnippetsAndWithSnippetChild [
	<gtExample>
	<return: #LePage>
	| aPage aPart |
	aPage := self pageOneWithOneSnippetWithChild.
	aPart := self snippetTwo.
	aPage
		children: (self basicSnippetsWithAll: (aPage children items copyWith: aPart)).
	self assert: aPage hasChildren.
	self assert: aPage childrenCount equals: 2.
	self assert: aPage children items second equals: aPart.
	^ aPage
]

{ #category : #'examples - model' }
LeContentExamples >> removeLinkToEmptyPage [
	"Removing a link to an empty page should remove that page"

	<gtExample>
	<return: #LeDatabase>
	| aDatabase referringPage emptyPage removedPages |
	removedPages := OrderedCollection new.
	aDatabase := self addPageToDatabase.
	emptyPage := aDatabase pageBuilder
			title: 'an empty page';
			add.

	aDatabase
		when: LeDatabasePageRemoved
		do: [ :announcement | removedPages add: announcement page ].
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

{ #category : #'examples - model' }
LeContentExamples >> removeLinkToNonExistingPage [
	"Removing a link to a page that does not exist"

	<gtExample>
	<return: #LeDatabase>
	| aDatabase referringPage removedPages |
	removedPages := OrderedCollection new.
	aDatabase := self addPageToDatabase.

	aDatabase
		when: LeDatabasePageRemoved
		do: [ :announcement | removedPages add: announcement page ].
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
	<return: #LeDatabase>
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
	snippet := page2 addSnippet: (LeTextSnippet string: 'link to [[Page1]] here').
	self assert: page2 allOutgoingExplicitLinks size equals: 1.
	self assert: page2 allChildOutgoingLinks size equals: 1.
	self assert: page2 allOutgoingExplicitLinks first target equals: page1.
	self assert: page2 allChildOutgoingLinks first target equals: page1.
	self assert: page1 hasIncomingLinks.
	self assert: page1 incomingLinks first origin equals: snippet.
	page1 removeSelf.
	self assert: page2 allOutgoingExplicitLinks size equals: 1.
	self assert: page2 allChildOutgoingLinks size equals: 1.
	self deny: page1 hasIncomingLinks.
	^ localDatabase
]

{ #category : #'examples - model' }
LeContentExamples >> removeSnippetFromParent [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet aChild |
	aSnippet := self snippetOne.
	aChild := self snippetTwo.
	aSnippet addSnippet: aChild.
	self assert: aChild parent equals: aSnippet.
	self assert: aSnippet hasChildren.
	aSnippet removeSnippet: aChild.
	self assert: aChild parent equals: nil.
	self assert: aSnippet hasChildren not.
	^ aSnippet
]

{ #category : #removing }
LeContentExamples >> removeSnippetWithLink [
	"Remove a snippet with a link to another page and ensure that the incoming links for the target page are updated"

	<gtExample>
	<return: #LeDatabase>
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
	snippet := page2 addSnippet: (LeTextSnippet string: 'link to [[Page1]] here').
	self assert: page2 allOutgoingExplicitLinks size equals: 1.
	self assert: page2 allChildOutgoingLinks size equals: 1.
	self assert: page2 allOutgoingExplicitLinks first target equals: page1.
	self assert: page2 allChildOutgoingLinks first target equals: page1.
	self assert: page1 hasIncomingLinks.
	self assert: page1 incomingLinks first origin equals: snippet.
	snippet removeSelf.
	self assert: page2 allOutgoingExplicitLinks isEmpty.
	self assert: page2 allChildOutgoingLinks isEmpty.
	self deny: page1 hasIncomingLinks.
	^ localDatabase
]

{ #category : #'examples - renames' }
LeContentExamples >> renameDatabasePageToUnnamed_PageTitleChanged_ReceivedByDatabase [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPage aCollection |
	aDatabase := self renameDatabasePage_PageTitleChanged_ReceivedByDatabase.
	aCollection := OrderedCollection new.
	aDatabase weak
		when: LePageTitleChanged
		send: #add:
		to: aCollection.
	aPage := aDatabase anyOne.
	aPage updateTitle: ''.
	self assert: aDatabase size equals: 1.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #'examples - renames' }
LeContentExamples >> renameDatabasePage_DatabaseResorted_AnnouncedByDatabase [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPage aCollection |
	aDatabase := self addPageToDatabase.
	aCollection := OrderedCollection new.
	aDatabase weak
		when: LeDatabaseResorted
		send: #add:
		to: aCollection.
	aPage := aDatabase anyOne.
	aPage updateTitle: 'page two'.
	self assert: aDatabase size equals: 1.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #'examples - renames' }
LeContentExamples >> renameDatabasePage_PageTitleChanged_AnnouncedByPage [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPage aCollection |
	aDatabase := self addPageToDatabase.
	aCollection := OrderedCollection new.
	aPage := aDatabase anyOne.
	aPage weak
		when: LePageTitleChanged
		send: #add:
		to: aCollection.
	aPage updateTitle: 'page two'.
	self assert: aDatabase size equals: 1.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #'examples - renames' }
LeContentExamples >> renameDatabasePage_PageTitleChanged_ReceivedByDatabase [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPage aCollection |
	aDatabase := self addPageToDatabase.
	aCollection := OrderedCollection new.
	aDatabase weak
		when: LePageTitleChanged
		send: #add:
		to: aCollection.
	aPage := aDatabase anyOne.
	aPage updateTitle: 'page two'.
	self assert: aDatabase size equals: 1.
	self assert: aCollection size equals: 1.
	self assert: aCollection first page equals: aPage.
	^ aDatabase
]

{ #category : #'examples - snippet changes' }
LeContentExamples >> snippetChangeText [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet aCreateTime aCreateEmail anEditTime anEditEmail aNewUserEmail aNewText |
	aSnippet := self textSnippetInPageAndDatabase.

	aCreateTime := aSnippet createTime.
	aCreateEmail := aSnippet createEmail.
	anEditTime := aSnippet editTime.
	anEditEmail := aSnippet editEmail.
	aNewUserEmail := 'connie@dogs.com'.
	aSnippet database userEmail: aNewUserEmail.
	aNewText := 'new block text' asRopedText.
	aSnippet updateText: aNewText.

	self assert: aSnippet text characters equals: aNewText characters.
	self assert: aSnippet string equals: aNewText asString.
	self assert: aSnippet createTime == aCreateTime.
	self assert: aSnippet createEmail == aCreateEmail.
	self assert: (aSnippet editTime == anEditTime) not.
	self assert: (aSnippet editEmail == anEditEmail) not.
	self assert: aSnippet editEmail equals: aSnippet database userEmail.
	self assert: aSnippet editEmail email equals: aNewUserEmail.
	self assert: aSnippet text equals: aNewText.

	^ aSnippet
]

{ #category : #'examples - snippet changes' }
LeContentExamples >> snippetChangeText_AnnouncedByDatabase [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := self textSnippetInPageAndDatabase.

	self assertTextChangedAnnouncementFor: snippet from: snippet database weak.

	^ snippet
]

{ #category : #'examples - snippet changes' }
LeContentExamples >> snippetChangeText_AnnouncedByPage [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := self textSnippetInPageAndDatabase.

	self assertTextChangedAnnouncementFor: snippet from: snippet page weak.

	^ snippet
]

{ #category : #'examples - snippet changes' }
LeContentExamples >> snippetChangeText_AnnouncedBySnippet [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := self textSnippetInPageAndDatabase.

	self assertTextChangedAnnouncementFor: snippet from: snippet weak.

	^ snippet
]

{ #category : #'examples - model' }
LeContentExamples >> snippetOne [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet |
	aSnippet := self basicSnippet.
	aSnippet string: self snippetOneString.
	aSnippet editTime: self editTimeOne.
	aSnippet editEmail: self editorOne.
	self assert: aSnippet string equals: self snippetOneString.
	self assert: aSnippet editTime equals: self editTimeOne.
	self assert: aSnippet editEmail equals: self editorOne.
	^ aSnippet
]

{ #category : #accessing }
LeContentExamples >> snippetOneString [
	^ 'block one content'
]

{ #category : #'examples - model' }
LeContentExamples >> snippetOneWithOneChild [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet aChild |
	aSnippet := self snippetOne.
	aChild := self snippetThree.
	aSnippet children: (self basicSnippetsWithAll: {aChild}).
	self assert: aChild parent equals: aSnippet.
	self assert: aSnippet hasChildren.
	self assert: aSnippet childrenCount equals: 1.
	self assert: aSnippet children items first equals: aChild.
	^ aSnippet
]

{ #category : #'examples - model' }
LeContentExamples >> snippetOne_hasNoCachedLinks [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet |
	aSnippet := self snippetOne.

	self assert: aSnippet cachedTextualLinks notNil.
	self assert: aSnippet cachedTextualLinks isEmpty.

	^ aSnippet
]

{ #category : #'examples - model' }
LeContentExamples >> snippetThree [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet |
	aSnippet := self basicSnippet.
	aSnippet string: self snippetThreeString.
	aSnippet editTime: self editTimeOne.
	aSnippet editEmail: self editorOne.
	self assert: aSnippet string equals: self snippetThreeString.
	self assert: aSnippet editTime equals: self editTimeOne.
	self assert: aSnippet editEmail equals: self editorOne.
	^ aSnippet
]

{ #category : #accessing }
LeContentExamples >> snippetThreeString [
	^ 'block three content'
]

{ #category : #'examples - model' }
LeContentExamples >> snippetTwo [
	<gtExample>
	<return: #LeTextSnippet>
	| aSnippet |
	aSnippet := self basicSnippet.
	aSnippet string: self snippetTwoString.
	aSnippet editTime: self editTimeOne.
	aSnippet editEmail: self editorOne.
	self assert: aSnippet string equals: self snippetTwoString.
	self assert: aSnippet editTime equals: self editTimeOne.
	self assert: aSnippet editEmail equals: self editorOne.
	^ aSnippet
]

{ #category : #accessing }
LeContentExamples >> snippetTwoString [
	^ 'block two content'
]

{ #category : #'examples - model' }
LeContentExamples >> sortedPagesInitializesWithAllAvailablePages [
	"When creating initially the sorted pages cache all pages should be added there."

	<gtExample>
	<return: #LeDatabase>
	| basicDatabase unnamedPage pharoClassPage |
	basicDatabase := self basicDatabase.

	basicDatabase pageBuilder
		title: 'page one';
		add.
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
	<return: #LeDatabase>
	| basicDatabase unnamedPage pharoClassPage |
	basicDatabase := self basicDatabase.

	basicDatabase pageBuilder
		title: 'page one';
		add.
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
	<return: #LeDatabase>
	| basicDatabase unnamedPage pharoClassPage |
	basicDatabase := self basicDatabase.

	basicDatabase pageBuilder
		title: 'page one';
		add.
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
LeContentExamples >> textSnippetInPageAndDatabase [
	<gtExample>
	<return: #LeTextSnippet>
	| aDatabase aPage aSnippet |
	aDatabase := self basicDatabase.
	aPage := aDatabase pageBuilder
			title: 'one';
			add.
	aSnippet := aPage snippetBuilder
			string: 'one > one';
			add.
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
LeContentExamples >> treeSnippetsInOrder [
	"This example verifies that a tree of text snippets can be extracted in the right order using allChildrenTextSnippets"

	<gtExample>
	<return: #LePage>
	| treeSnippetPage |
	treeSnippetPage := LePage unnamedPage
			addSnippet: (LeTextSnippet new
					string: 'A';
					addSnippet: (LeTextSnippet new
							string: 'B';
							yourself);
					addSnippet: (LeTextSnippet new
							string: 'C';
							addSnippet: (LeTextSnippet new
									string: 'D';
									yourself);
							addSnippet: (LeTextSnippet new
									string: 'E';
									yourself);
							yourself);
					addSnippet: (LeTextSnippet new
							string: 'F';
							addSnippet: (LeTextSnippet new
									string: 'G';
									yourself);
							yourself);
					yourself);
			addSnippet: (LeTextSnippet new
					string: 'H';
					addSnippet: (LeTextSnippet new
							string: 'I';
							yourself);
					yourself);
			yourself.
	self
		assert: ('' join: (treeSnippetPage allChildrenTextSnippets collect: #string))
		equals: 'ABCDEFGHI'.
	^ treeSnippetPage
]

{ #category : #'examples - model' }
LeContentExamples >> twoPagesWithOneSnippetEachAndLinksToTheFirstPage [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPageOne aPageTwo aSnippetOne aSnippetTwo |
	aDatabase := self basicDatabase.
	aPageOne := aDatabase pageBuilder
			title: 'one';
			add.
	aPageTwo := aDatabase pageBuilder
			title: 'two';
			add.
	aSnippetOne := aPageOne snippetBuilder
			string: '[[one]]';
			add.
	aSnippetTwo := aPageTwo snippetBuilder
			string: '[[one]]';
			add.
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
LeContentExamples >> twoPagesWithOneSnippetEachAndLinksToTheFirstPage_DeleteOneLink [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPageOne aPageTwo aBlockOne aBlockTwo |
	aDatabase := self twoPagesWithOneSnippetEachAndLinksToTheFirstPage.
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
LeContentExamples >> twoPagesWithOneSnippetEachAndLinksToTheFirstPage_RenamePageOnce [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPageOne aPageTwo aBlockOne aBlockTwo |
	aDatabase := self twoPagesWithOneSnippetEachAndLinksToTheFirstPage.
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
