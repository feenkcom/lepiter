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
	^ self fields collect: [ :aField | TMFieldNode for: aField in: self topicMap ]
]

{ #category : #navigation }
TMDatabaseNode >> fields [
	^ self topicMap fields
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
