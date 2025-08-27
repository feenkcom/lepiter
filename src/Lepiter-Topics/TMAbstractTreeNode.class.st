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

{ #category : #views }
TMAbstractTreeNode >> gtChildrenFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Children';
		items: [ self children];
		children: #children;
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Node'
			text: [ :each | each name ]
			width: 300;
		column: self relatedTitle
			text: [ :each | each related ]
			width: 300;
		send: [ :each | each ];
		actionUpdateButton
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

{ #category : #accessing }
TMAbstractTreeNode >> related [
	"Related information to display."

	^ '-'
]

{ #category : #accessing }
TMAbstractTreeNode >> relatedTitle [
	"Title of related information to display."

	^ '-'
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
