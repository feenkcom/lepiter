Class {
	#name : #LeTextualSnippetLinkBetweenChildrenExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'theDatabase',
		'thePage',
		'theFirstSnippet',
		'theSecondSnippet'
	],
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #'examples - change' }
LeTextualSnippetLinkBetweenChildrenExamples >> changeSnippetContentToRemoveLinks [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink |
	database := self createDatabaseWithTextualLink.
	currentLink := database explicitLinks items first.

	self secondSnippet updateText: 'new content with no link' asRopedText.

	self assert: database explicitLinksCount equals: 0.
	self assert: database textualSnippetsLinksCount equals: 0.

	self assert: currentLink targetReference content equals: self firstSnippet.
	self
		assert: currentLink targetReference snippetUid
		equals: self firstSnippet uid.

	^ database
]

{ #category : #'examples - change' }
LeTextualSnippetLinkBetweenChildrenExamples >> changeSnippetContentToRemoveLinks_firstSnippetHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changeSnippetContentToRemoveLinks.

	self assert: self firstSnippet outgoingExplicitLinks size equals: 0.
	self assert: self firstSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - change' }
LeTextualSnippetLinkBetweenChildrenExamples >> changeSnippetContentToRemoveLinks_removeAnnouncementIsTriggered [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink linksRemovedAnnouncements |
	database := self createDatabaseWithTextualLink.
	currentLink := database explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	self secondSnippet updateText: 'new content with no link' asRopedText.

	self assert: linksRemovedAnnouncements size equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks size
		equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks first
		equals: currentLink.

	^ database
]

{ #category : #'examples - change' }
LeTextualSnippetLinkBetweenChildrenExamples >> changeSnippetContentToRemoveLinks_secondSnippetHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changeSnippetContentToRemoveLinks.

	self assert: self secondSnippet outgoingExplicitLinks size equals: 0.
	self assert: self secondSnippet outgoingTextualLinks size equals: 0.
	self assert: self secondSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - creation' }
LeTextualSnippetLinkBetweenChildrenExamples >> createDatabaseWithTextualLink [
	<gtExample>
	<return: #LeDatabase>
	theDatabase := self emptyDatabase.

	thePage := theDatabase pageBuilder
			title: 'Page 1';
			add.
	theFirstSnippet := thePage snippetBuilder
			string: 'First Snippet in Page 1';
			add.
	theSecondSnippet := thePage snippetBuilder
			string: 'Second snippet with link to first snippet ((' , theFirstSnippet uidString
					, '))';
			add.

	self assert: theDatabase explicitLinksCount equals: 1.
	self assert: theDatabase textualSnippetsLinksCount equals: 1.

	^ theDatabase
]

{ #category : #'examples - creation' }
LeTextualSnippetLinkBetweenChildrenExamples >> createDatabaseWithTextualLink_addAnnouncementIsTriggered [
	<gtExample>
	<return: #LeDatabase>
	| database page secondSnippet firstSnippet linksAddedAnnouncements |
	database := self emptyDatabase.

	page := database pageBuilder
			title: 'Page 1';
			add.
	firstSnippet := page snippetBuilder
			string: 'First Snippet in Page 1';
			add.

	linksAddedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinkAddedAnnouncement
		send: #add:
		to: linksAddedAnnouncements.

	secondSnippet := page snippetBuilder
			string: 'Second snippet with link to first snippet ((' , firstSnippet uidString , '))';
			add.

	self assert: linksAddedAnnouncements size equals: 1.
	self assert: linksAddedAnnouncements first requiresSavingOfLinks not.
	self
		assert: linksAddedAnnouncements first newExplicitLink
		equals: secondSnippet outgoingExplicitLinks items first.

	^ database
]

{ #category : #'examples - creation' }
LeTextualSnippetLinkBetweenChildrenExamples >> createDatabaseWithTextualLink_firstSnippetHasIncomingLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet |
	database := self createDatabaseWithTextualLink.

	firstSnippet := self firstSnippet.

	self assert: firstSnippet outgoingExplicitLinks size equals: 0.
	self assert: firstSnippet incomingLinks size equals: 1.

	^ database
]

{ #category : #'examples - creation' }
LeTextualSnippetLinkBetweenChildrenExamples >> createDatabaseWithTextualLink_secondSnippetHasOutgoingLinks [
	<gtExample>
	<return: #LeDatabase>
	| database secondSnippet |
	database := self createDatabaseWithTextualLink.

	secondSnippet := self secondSnippet.

	self assert: secondSnippet outgoingExplicitLinks size equals: 1.
	self assert: secondSnippet outgoingTextualLinks size equals: 1.
	self assert: secondSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - creation' }
LeTextualSnippetLinkBetweenChildrenExamples >> createDatabaseWithTextualLink_textualLinkHasCorrectIdentity [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet secondSnippet currentLink |
	database := self createDatabaseWithTextualLink.

	firstSnippet := self firstSnippet.
	secondSnippet := self secondSnippet.
	currentLink := database explicitLinks items first.

	self assert: secondSnippet outgoingExplicitLinks items first == currentLink.
	self assert: firstSnippet incomingLinks first == currentLink.

	^ database
]

{ #category : #'examples - creation' }
LeTextualSnippetLinkBetweenChildrenExamples >> createDatabaseWithTextualLink_textualLinkHasCorrectProperties [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet secondSnippet currentLink |
	database := self createDatabaseWithTextualLink.

	firstSnippet := self firstSnippet.
	secondSnippet := self secondSnippet.
	currentLink := database explicitLinks items first.

	self assert: currentLink isTextualSnippetLink.
	self assert: currentLink targetSnippetUid equals: firstSnippet uid.
	self assert: currentLink targetUID equals: firstSnippet uid.
	self assert: currentLink target equals: firstSnippet.
	self assert: currentLink origin equals: secondSnippet.

	^ database
]

{ #category : #accessing }
LeTextualSnippetLinkBetweenChildrenExamples >> currentPage [ 
	^ thePage
]

{ #category : #examples }
LeTextualSnippetLinkBetweenChildrenExamples >> emptyDatabase [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := LeDatabase new.

	self assert: database explicitLinks size equals: 0.

	^ database
]

{ #category : #accessing }
LeTextualSnippetLinkBetweenChildrenExamples >> firstSnippet [ 
	^ theFirstSnippet
]

{ #category : #'examples - removal' }
LeTextualSnippetLinkBetweenChildrenExamples >> removePageWithSnippetWithOutgoingTextualLink [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink |
	database := self createDatabaseWithTextualLink.

	currentLink := database explicitLinks items first.

	self currentPage removeSelf.

	self assert: database explicitLinksCount equals: 0.
	self assert: database textualSnippetsLinksCount equals: 0.

	self assert: currentLink target equals: nil.
	self assert: currentLink targetReference content equals: nil.
	self
		assert: currentLink targetReference snippetUid
		equals: self firstSnippet uid.

	self assert: self firstSnippet incomingLinks size equals: 0.
	self assert: self secondSnippet outgoingExplicitLinks size equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualSnippetLinkBetweenChildrenExamples >> removeSnippetWithIncomingTextualLink [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet |
	database := self createDatabaseWithTextualLink.

	firstSnippet := self firstSnippet.
	firstSnippet removeSelf.

	self assert: database explicitLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 1.
	self assert: database textualPageLinksCount equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualSnippetLinkBetweenChildrenExamples >> removeSnippetWithIncomingTextualLink_firstSnippetHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removeSnippetWithIncomingTextualLink.

	self assert: self firstSnippet outgoingExplicitLinks size equals: 0.
	self assert: self firstSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualSnippetLinkBetweenChildrenExamples >> removeSnippetWithIncomingTextualLink_linkHasUpdatedContent [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink |
	database := self removeSnippetWithIncomingTextualLink.

	currentLink := database explicitLinks items first.

	self assert: currentLink targetReference content equals: nil.
	self
		assert: currentLink targetReference snippetUid
		equals: self firstSnippet uid.

	^ database
]

{ #category : #'examples - removal' }
LeTextualSnippetLinkBetweenChildrenExamples >> removeSnippetWithIncomingTextualLink_secondSnippetHasOutgoingLink [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removeSnippetWithIncomingTextualLink.

	self assert: self secondSnippet outgoingExplicitLinks size equals: 1.
	self assert: self secondSnippet outgoingTextualLinks size equals: 1.
	self assert: self secondSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualSnippetLinkBetweenChildrenExamples >> removeSnippetWithOutgoingTextualLink [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink |
	database := self createDatabaseWithTextualLink.
	currentLink := database explicitLinks items first.

	self secondSnippet removeSelf.

	self assert: database explicitLinksCount equals: 0.
	self assert: database textualSnippetsLinksCount equals: 0.

	self assert: currentLink targetReference content equals: self firstSnippet.
	self
		assert: currentLink targetReference snippetUid
		equals: self firstSnippet uid.

	^ database
]

{ #category : #'examples - removal' }
LeTextualSnippetLinkBetweenChildrenExamples >> removeSnippetWithOutgoingTextualLink_firstSnippetHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removeSnippetWithOutgoingTextualLink.

	self assert: self firstSnippet outgoingExplicitLinks size equals: 0.
	self assert: self firstSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualSnippetLinkBetweenChildrenExamples >> removeSnippetWithOutgoingTextualLink_removeAnnouncementIsTriggered [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink linksRemovedAnnouncements |
	database := self createDatabaseWithTextualLink.
	currentLink := database explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	self secondSnippet removeSelf.

	self assert: linksRemovedAnnouncements size equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks size
		equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks items first
		equals: currentLink.

	^ database
]

{ #category : #'examples - removal' }
LeTextualSnippetLinkBetweenChildrenExamples >> removeSnippetWithOutgoingTextualLink_secondSnippetHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removeSnippetWithOutgoingTextualLink.

	self assert: self secondSnippet outgoingExplicitLinks size equals: 0.
	self assert: self secondSnippet outgoingTextualLinks size equals: 0.
	self assert: self secondSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #accessing }
LeTextualSnippetLinkBetweenChildrenExamples >> secondSnippet [ 
	^ theSecondSnippet
]
