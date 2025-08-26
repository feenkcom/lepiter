Class {
	#name : #TMTopicNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'topic'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMTopicNode class >> for: aString within: aPageGroup [
^ self new
	pageGroup: aPageGroup;
	topic: aString;
	yourself 
]

{ #category : #accessing }
TMTopicNode >> children [
	^ self styles
		collect: [ :aStyle | TMStyleNode for: aStyle within: (self pageGroup copyWithPages: self pages) ]
]

{ #category : #accessing }
TMTopicNode >> name [
	^ 'Topic: ' , self topic
]

{ #category : #querying }
TMTopicNode >> pages [
	^ self topicMap topic2Pages at: self topic
]

{ #category : #accessing }
TMTopicNode >> styles [
	^ self topicMap topic2Styles: self topic
]

{ #category : #accessing }
TMTopicNode >> topic [
	^ topic
]

{ #category : #accessing }
TMTopicNode >> topic: anObject [
	topic := anObject
]
