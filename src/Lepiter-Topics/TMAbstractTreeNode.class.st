"
I am an abstract parent for trees of Topic Map nodes representing pages, topics, fields, and styles.
I supposrt navigation via dedicated views of page groups.
"
Class {
	#name : #TMAbstractTreeNode,
	#superclass : #Object,
	#instVars : [
		'pageGroup'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #accessing }
TMAbstractTreeNode >> children [
	self subclassResponsibility
]

{ #category : #testing }
TMAbstractTreeNode >> isAbstract [
	^ self == TMAbstractTreeNode
]

{ #category : #accessing }
TMAbstractTreeNode >> name [
	self subclassResponsibility
]

{ #category : #accessing }
TMAbstractTreeNode >> pageGroup [
	^ pageGroup
]

{ #category : #accessing }
TMAbstractTreeNode >> pageGroup: anObject [
	pageGroup := anObject
]

{ #category : #printing }
TMAbstractTreeNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #accessing }
TMAbstractTreeNode >> topicMap [
	^ self pageGroup topicMap
]
