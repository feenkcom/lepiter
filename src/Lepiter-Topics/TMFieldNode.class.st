Class {
	#name : #TMFieldNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'field'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMFieldNode class >> for: aField in: aTopicMap [
^ self new
	field: aField;
	topicMap: aTopicMap;
	yourself 
]

{ #category : #accessing }
TMFieldNode >> children [
	^ self topics collect: [ :each | TMTopicNode for: each in: self topicMap ]
]

{ #category : #accessing }
TMFieldNode >> field [
	^ field
]

{ #category : #accessing }
TMFieldNode >> field: anObject [
	field := anObject
]

{ #category : #navigation }
TMFieldNode >> fields [
	^ {field}
]

{ #category : #accessing }
TMFieldNode >> name [
	^ 'Field: ' , self field
]

{ #category : #navigation }
TMFieldNode >> pages [
	^ (self children flatCollect: #pages) copyWithoutDuplicates
]

{ #category : #navigation }
TMFieldNode >> styles [
	| topicStyles |
	topicStyles := (self children flatCollect: #styles) copyWithoutDuplicates.
	^ self topicMap styles select: [ :aStyle | topicStyles includes: aStyle ]
]

{ #category : #navigation }
TMFieldNode >> topics [
	^ self topicMap topic4Field: self field
]
