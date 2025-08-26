"
I am an abstract parent for trees of Topic Map nodes representing pages, topics, fields, and styles.

I support navigation via dedicated views of page groups.
"
Class {
	#name : #TMAbstractTreeNode,
	#superclass : #Object,
	#instVars : [
		'topicMap'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #navigation }
TMAbstractTreeNode >> children [
	self subclassResponsibility
]

{ #category : #testing }
TMAbstractTreeNode >> isAbstract [
	^ self == TMAbstractTreeNode
]

{ #category : #testing }
TMAbstractTreeNode >> isPageNode [
	^ false
]

{ #category : #accessing }
TMAbstractTreeNode >> name [
	self subclassResponsibility
]

{ #category : #printing }
TMAbstractTreeNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]

{ #category : #navigation }
TMAbstractTreeNode >> sendTo [
	"NB: this is also the pageGroup to send to when we click within the columnedTree view."

	self subclassResponsibility
]

{ #category : #accessing }
TMAbstractTreeNode >> topicMap [
	^ topicMap
]

{ #category : #accessing }
TMAbstractTreeNode >> topicMap: anObject [
	topicMap := anObject
]
