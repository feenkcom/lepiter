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

{ #category : #navigation }
TMDatabaseNode >> children [
	^ self fields collect: [:aField | TMFieldNode for: aField in: self topicMap ]
]

{ #category : #accessing }
TMDatabaseNode >> fields [
	^ self topicMap fields
]

{ #category : #accessing }
TMDatabaseNode >> name [
	^ self database databaseName
]

{ #category : #accessing }
TMDatabaseNode >> pageNodes [
	^ TMNodeCollectionNode
		for: (self pages collect: [ :aPage | TMPageNode for: aPage in: self topicMap ])
		in: self topicMap
]

{ #category : #accessing }
TMDatabaseNode >> pages [
	^ self database pages
]

{ #category : #accessing }
TMDatabaseNode >> styles [
	^ self topicMap styles
]

{ #category : #accessing }
TMDatabaseNode >> topics [
	^ self topicMap topics sorted
]
