Class {
	#name : #TMPageNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMPageNode class >> for: aPage [
	^ self new
		page: aPage;
		topicMap: aPage topicMap;
		yourself
]

{ #category : #'instance creation' }
TMPageNode class >> for: aPage in: aTopicMap [
	"Use this for testing if the topic map to use is not necessarily
	the default one, but a special test map."

	^ self new
		page: aPage;
		topicMap: aTopicMap;
		yourself
]

{ #category : #navigation }
TMPageNode >> children [
	^ self topics collect: [ :each | TMTopicNode for: each in: self topicMap ]
]

{ #category : #navigation }
TMPageNode >> fields [
	^ (self topicNodes nodes flatCollect: #fields) copyWithoutDuplicates
]

{ #category : #views }
TMPageNode >> gtDatabaseTreeFor: aView [
	<gtView>
	^ aView forward
		title: 'Database fields';
		priority: 40;
		object: [ self databaseNode ];
		view: #gtTreeFor:
]

{ #category : #views }
TMPageNode >> gtLivePageFor: aView [
	<gtView>
	^ aView forward
		title: 'Page';
		priority: 30;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #actions }
TMPageNode >> gtSpawnPageActionFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Spawn page';
		priority: 20;
		icon: LeIcons lepiterIcon;
		action: [ :aButton | aButton phlow spawnObject: self page ]
]

{ #category : #accessing }
TMPageNode >> name [
	^ 'Page: ', self page title
]

{ #category : #accessing }
TMPageNode >> page [
	^ page
]

{ #category : #accessing }
TMPageNode >> page: aPage [
	page := aPage
]

{ #category : #navigation }
TMPageNode >> pages [
	^ {self page}
]

{ #category : #accessing }
TMPageNode >> relatedInfo [
	^ 'Style:', self style
]

{ #category : #accessing }
TMPageNode >> relatedTitle [
	^ 'Style'
]

{ #category : #accessing }
TMPageNode >> style [
	^ self topicMap style4Page: self page
]

{ #category : #navigation }
TMPageNode >> styles [
	^ {self style}
]

{ #category : #querying }
TMPageNode >> topics [
	^ self topicMap topics4Page: self page
]

{ #category : #'as yet unclassified' }
TMPageNode >> treeMapDeep [
	"For a treemap, a page has no further children."

	^ {}
]
