Class {
	#name : #TMTopicNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'topic'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMTopicNode class >> for: aTopic in: aTopicMap [
^ self new
	topic: aTopic;
	topicMap: aTopicMap;
	yourself 
]

{ #category : #navigation }
TMTopicNode >> children [
	^ self styles
		collect: [ :aStyle | 
			TMStyleNode
				for: aStyle
				in: self topicMap
				within: (TMPageGroup for: self topicMap with: self pages) ]
]

{ #category : #accessing }
TMTopicNode >> field [
	^ self topicMap field4Topic: self topic
]

{ #category : #navigation }
TMTopicNode >> fields [
	^ {self field}
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
TMTopicNode >> relatedInfo [
	^ 'Field: ' , self field
]

{ #category : #navigation }
TMTopicNode >> styles [
	^ self topicMap styles4Topic: self topic
]

{ #category : #accessing }
TMTopicNode >> topic [
	^ topic
]

{ #category : #accessing }
TMTopicNode >> topic: aString [
	topic := aString
]

{ #category : #navigation }
TMTopicNode >> topics [
	^ {self topic}
]
