Class {
	#name : #LeContentNotifierExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Notifier'
}

{ #category : #'examples - basic' }
LeContentNotifierExamples >> basicNotifier [
	<gtExample>
	<return: #LeNotifier>
	| aNotifier |
	aNotifier := LeNotifier new.
	self assert: aNotifier propagaters isNotNil.
	self assert: aNotifier content isNil.
	^ aNotifier
]

{ #category : #'examples - notifying' }
LeContentNotifierExamples >> bubblingInPage [
	<gtExample>
	<return: #LePage>
	| aPage aCollection anAnnouncement |
	aPage := self pageWithThreeSnippets.
	aCollection := OrderedCollection new.
	self
		subscribeTo: aPage
		andAllChildrenSending: #add:
		to: aCollection.
	anAnnouncement := aPage notifier
			bubble;
			announce: Announcement.
	self assert: anAnnouncement class equals: Announcement.
	self assert: aCollection size equals: 1.
	self assert: aCollection anyOne equals: anAnnouncement.
	^ aPage
]

{ #category : #'examples - notifying' }
LeContentNotifierExamples >> bubblingInSecondSnippet [
	<gtExample>
	<return: #LePage>
	| aPage aCollection anAnnouncement aSecondSnippet |
	aPage := self pageWithThreeSnippets.
	aSecondSnippet := aPage children first children first.
	aCollection := OrderedCollection new.
	self
		subscribeTo: aPage
		andAllChildrenSending: #add:
		to: aCollection.
	anAnnouncement := aSecondSnippet notifier
			bubble;
			announce: Announcement.
	self assert: anAnnouncement class equals: Announcement.
	self assert: aCollection size equals: 3.
	self assert: aCollection asSet size equals: 1.
	self assert: aCollection anyOne equals: anAnnouncement.
	^ aPage
]

{ #category : #'examples - notifying' }
LeContentNotifierExamples >> bubblingInThirdSnippet [
	<gtExample>
	<return: #LePage>
	| aPage aCollection anAnnouncement aThirdSnippet |
	aPage := self pageWithThreeSnippets.
	aThirdSnippet := aPage children first children first children first.
	aCollection := OrderedCollection new.
	self
		subscribeTo: aPage
		andAllChildrenSending: #add:
		to: aCollection.
	anAnnouncement := aThirdSnippet notifier
			bubble;
			announce: Announcement.
	self assert: anAnnouncement class equals: Announcement.
	self assert: aCollection size equals: 4.
	self assert: aCollection asSet size equals: 1.
	self assert: aCollection anyOne equals: anAnnouncement.
	^ aPage
]

{ #category : #'examples - notifying' }
LeContentNotifierExamples >> localInPage [
	<gtExample>
	<return: #LePage>
	| aPage aCollection anAnnouncement |
	aPage := self pageWithThreeSnippets.
	aCollection := OrderedCollection new.
	self
		subscribeTo: aPage
		andAllChildrenSending: #add:
		to: aCollection.
	anAnnouncement := aPage notifier
			bubble;
			announce: Announcement.
	self assert: anAnnouncement class equals: Announcement.
	self assert: aCollection size equals: 1.
	self assert: aCollection anyOne equals: anAnnouncement.
	^ aPage
]

{ #category : #'examples - notifying' }
LeContentNotifierExamples >> localInSecondSnippet [
	<gtExample>
	<return: #LePage>
	| aPage aCollection anAnnouncement aSecondSnippet |
	aPage := self pageWithThreeSnippets.
	aSecondSnippet := aPage children first children first.
	aCollection := OrderedCollection new.
	self
		subscribeTo: aPage
		andAllChildrenSending: #add:
		to: aCollection.
	anAnnouncement := aSecondSnippet notifier
			local;
			announce: Announcement.
	self assert: anAnnouncement class equals: Announcement.
	self assert: aCollection size equals: 1.
	self assert: aCollection anyOne equals: anAnnouncement.
	^ aPage
]

{ #category : #'examples - notifying' }
LeContentNotifierExamples >> localInThirdSnippet [
	<gtExample>
	<return: #LePage>
	| aPage aCollection anAnnouncement aThirdSnippet |
	aPage := self pageWithThreeSnippets.
	aThirdSnippet := aPage children first children first children first.
	aCollection := OrderedCollection new.
	self
		subscribeTo: aPage
		andAllChildrenSending: #add:
		to: aCollection.
	anAnnouncement := aThirdSnippet notifier
			local;
			announce: Announcement.
	self assert: anAnnouncement class equals: Announcement.
	self assert: aCollection size equals: 1.
	self assert: aCollection anyOne equals: anAnnouncement.
	^ aPage
]

{ #category : #'examples - models' }
LeContentNotifierExamples >> pageWithThreeSnippets [
	<gtExample>
	<return: #LePage>
	| aPage aSnippetOne aSnippetTwo |
	aPage := LePage builder
			title: 'Page One';
			build.
	aSnippetOne := aPage snippetBuilder
			string: 'Block One';
			add.
	aSnippetTwo := aSnippetOne snippetBuilder
			string: 'Block One > Two';
			add.
	aSnippetTwo snippetBuilder
		string: 'Block One > Two > Three';
		add.
	^ aPage
]

{ #category : #'examples - support' }
LeContentNotifierExamples >> subscribeTo: aPageOrSnippet andAllChildrenSending: aSymbol to: aSubscriber [
	aPageOrSnippet weak when: Announcement send: aSymbol to: aSubscriber.
	aPageOrSnippet childrenDo: [ :eachChild |
		self 
			subscribeTo: eachChild 
			andAllChildrenSending: aSymbol
			to: aSubscriber ].
]
