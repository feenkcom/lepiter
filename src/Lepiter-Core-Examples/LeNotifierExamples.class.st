"
I exemplify {{gtClass:LeNotifier}}.

"
Class {
	#name : #LeNotifierExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Notifier'
}

{ #category : #'examples - support' }
LeNotifierExamples >> addAllAnnouncementsIn: aDatabase into: aCollection [
	<gtExample>
	aDatabase
		when: Announcement
		do: [ :anAnnouncement :anAnnouncer | 
			aCollection add: anAnnouncer ];
		allChildrenBreadthFirstDo: [ :aContent | 
			aContent
				when: Announcement
				do: [ :anAnnouncement :anAnnouncer | 
					aCollection add: anAnnouncer ] ]
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> bubblingNotification_BlockThree [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aDatabase := aBlockThree database.
	self addAllAnnouncementsIn: aDatabase into: aCollection.
	aBlockThree notifier
		bubble;
		announce: Announcement.
	self assert: aCollection size equals: 4.
	self assert: aCollection first equals: aBlockThree announcer.
	self assert: aCollection second equals: aBlockThree parent announcer.
	self assert: aCollection third equals: aBlockThree parent parent announcer.
	self
		assert: aCollection fourth
		equals: aBlockThree parent parent parent announcer.
	^ aDatabase
]

{ #category : #'examples - model' }
LeNotifierExamples >> database [
	<gtExample>
	<return: #LeDatabase>
	^ LeDatabase new
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> databaseNotification_BlockThree [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aDatabase := aBlockThree database.
	self addAllAnnouncementsIn: aDatabase into: aCollection.
	aBlockThree notifier
		database;
		announce: Announcement.
	self assert: aCollection size equals: 1.
	self assert: aCollection first equals: aDatabase announcer.
	^ aDatabase
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> databaseNotification_BlockThree_OneSubscription [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aDatabase := aBlockThree database.
	aDatabase
		when: Announcement
		do: [ :anAnnouncement :anAnnouncer | aCollection add: anAnnouncer ].
	aBlockThree notifier
		database;
		announce: Announcement.
	self assert: aCollection size equals: 1.
	self assert: aCollection first equals: aDatabase announcer.
	^ aDatabase
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> databaseNotification_BlockThree_TwoSubscriptions [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aDatabase := aBlockThree database.
	aBlockThree
		when: Announcement
		do: [ :anAnnouncement :anAnnouncer | aCollection add: anAnnouncer ].
	aDatabase
		when: Announcement
		do: [ :anAnnouncement :anAnnouncer | aCollection add: anAnnouncer ].
	aBlockThree notifier
		database;
		announce: Announcement.
	self assert: aCollection size equals: 1.
	self assert: aCollection first equals: aDatabase announcer.
	^ aDatabase
]

{ #category : #'examples - model' }
LeNotifierExamples >> hierarchy_database [
	<gtExample>
	<return: #LeDatabase>
	^ self hierarchy_thirdBlock database
]

{ #category : #'examples - model' }
LeNotifierExamples >> hierarchy_firstBlock [
	<gtExample>
	<return: #LeTextSnippet>
	| aDatabase aPage aSnippetOne aSnippetTwo |
	aDatabase := self database.
	aPage := aDatabase pageBuilder
			title: 'page';
			add.
	aSnippetOne := aPage snippetBuilder
			string: 'block one';
			add.
	aSnippetTwo := aSnippetOne snippetBuilder
			string: 'block two';
			add.
	aSnippetTwo snippetBuilder
		string: 'block three';
		add.
	^ aSnippetOne
]

{ #category : #'examples - model' }
LeNotifierExamples >> hierarchy_thirdBlock [
	<gtExample>
	<return: #LeTextSnippet>
	| aDatabase aPage aSnippetOne aSnippetTwo aSnippetThree |
	aDatabase := self database.
	aPage := aDatabase pageBuilder
			title: 'page';
			add.
	aSnippetOne := aPage snippetBuilder
			string: 'block one';
			add.
	aSnippetTwo := aSnippetOne snippetBuilder
			string: 'block two';
			add.
	aSnippetThree := aSnippetTwo snippetBuilder
			string: 'block three';
			add.
	^ aSnippetThree
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> localAndDatabaseNotification_BlockThree [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aDatabase := aBlockThree database.
	self addAllAnnouncementsIn: aDatabase into: aCollection.
	aBlockThree notifier
		local;
		database;
		announce: Announcement.
	self assert: aCollection size equals: 2.
	self assert: aCollection first equals: aBlockThree announcer.
	self assert: aCollection second equals: aDatabase announcer.
	^ aDatabase
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> localAndDatabaseNotification_BlockThree_ReversedOrder [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aDatabase := aBlockThree database.
	self addAllAnnouncementsIn: aDatabase into: aCollection.
	aBlockThree notifier
		database;
		local;
		announce: Announcement.
	self assert: aCollection size equals: 2.
	self assert: aCollection first equals: aBlockThree announcer.
	self assert: aCollection second equals: aDatabase announcer.
	^ aDatabase
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> localAndDatabaseNotification_BlockThree_TwoSubscriptions [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aDatabase := aBlockThree database.
	aBlockThree
		when: Announcement
		do: [ :anAnnouncement :anAnnouncer | aCollection add: anAnnouncer ].
	aDatabase
		when: Announcement
		do: [ :anAnnouncement :anAnnouncer | aCollection add: anAnnouncer ].
	aBlockThree notifier
		local;
		database;
		announce: Announcement.
	self assert: aCollection size equals: 2.
	self assert: aCollection first equals: aBlockThree announcer.
	self assert: aCollection second equals: aDatabase announcer.
	^ aDatabase
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> localNotification_BlockThree [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aDatabase := aBlockThree database.
	self addAllAnnouncementsIn: aDatabase into: aCollection.
	aBlockThree notifier
		local;
		announce: Announcement.
	self assert: aCollection size equals: 1.
	self assert: aCollection first equals: aBlockThree announcer.
	^ aDatabase
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> treeNotification_BlockOne [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection aBlockOne |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aBlockOne := aBlockThree parent parent.
	aDatabase := aBlockThree database.
	self addAllAnnouncementsIn: aDatabase into: aCollection.
	aBlockOne notifier
		tree;
		announce: Announcement.
	self assert: aCollection size equals: 3.
	self assert: aCollection third equals: aBlockThree announcer.
	self assert: aCollection second equals: aBlockThree parent announcer.
	self assert: aCollection first equals: aBlockThree parent parent announcer.
	^ aDatabase
]

{ #category : #'examples - notifier' }
LeNotifierExamples >> treeNotification_Page [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aBlockThree aCollection aPage |
	aCollection := OrderedCollection new.
	aBlockThree := self hierarchy_thirdBlock.
	aPage := aBlockThree parent parent parent.
	aDatabase := aBlockThree database.
	self addAllAnnouncementsIn: aDatabase into: aCollection.
	aPage notifier
		tree;
		announce: Announcement.
	self assert: aCollection size equals: 4.
	self assert: aCollection fourth equals: aBlockThree announcer.
	self assert: aCollection third equals: aBlockThree parent announcer.
	self assert: aCollection second equals: aBlockThree parent parent announcer.
	self assert: aCollection first equals: aPage announcer.
	^ aDatabase
]
