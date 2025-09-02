Class {
	#name : #TMDatabaseNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMDatabaseNode class >> for: aDatabase [
	^ self new
		topicMap: aDatabase topicMap;
		yourself
]

{ #category : #'instance creation' }
TMDatabaseNode class >> for: aDatabase in: aTopicMap [
	^ self new
		topicMap: aTopicMap;
		yourself
]

{ #category : #navigation }
TMDatabaseNode >> children [
	^ self
		nodeGroupFor: (self fields collect: [ :aField | TMFieldNode for: aField in: self topicMap ])
]

{ #category : #navigation }
TMDatabaseNode >> fields [
	^ self topicMap fields
]

{ #category : #actions }
TMDatabaseNode >> gtDatabaseActionFor: anAction [
	<gtAction>
	self database ifNil: [ ^ anAction noAction ].
	self database isDatabase ifFalse: [ ^ anAction noAction ].

	^ anAction button
		tooltip: 'Inspect the database';
		priority: 40;
		icon: LeIcons lepiterDatabase;
		id: LePageDatabaseActionId;
		action: [ :aButton | aButton phlow spawnObject: self database ]
]

{ #category : #mondrian }
TMDatabaseNode >> mondrianNodeColor [
	^ Color blue
]

{ #category : #mondrian }
TMDatabaseNode >> mondrianNodeSize [
	^ 20 @ 20
]

{ #category : #accessing }
TMDatabaseNode >> name [
	^ self database databaseName
]

{ #category : #navigation }
TMDatabaseNode >> pages [
	^ self database pages
]

{ #category : #navigation }
TMDatabaseNode >> styles [
	^ self topicMap styles
]

{ #category : #navigation }
TMDatabaseNode >> topics [
	^ self topicMap topics sorted
]
