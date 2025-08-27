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
TMDatabaseNode >> fieldNodes [
	^ TMNodeCollectionNode for: self children in: self topicMap
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

{ #category : #'as yet unclassified' }
TMDatabaseNode >> summary [
	^ {{'Database'.
			self database}.
		{'#Fields'.
			self fields size printString.
			self fieldNodes}.
		{'#Topics'.
			self topics size printString.
			self topicNodes}.
		{'#Pages'.
			self pages size printString.
			self pageGroup}}
]

{ #category : #accessing }
TMDatabaseNode >> topicNodes [
	^ TMNodeCollectionNode
		for: (self topics collect: [ :aTopic | TMTopicNode for: aTopic in: self topicMap ])
		in: self topicMap
]

{ #category : #accessing }
TMDatabaseNode >> topics [
	^ self topicMap topics
]
