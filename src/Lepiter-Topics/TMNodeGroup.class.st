"
I hold as my children a collection of other nodes.
I am useful for generating ad hoc views of collections of pages, topics, etc.
"
Class {
	#name : #TMNodeGroup,
	#superclass : #TMAbstractTreeNode,
	#traits : 'TGtGroup',
	#classTraits : 'TGtGroup classTrait',
	#instVars : [
		'nodes'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMNodeGroup class >> for: aNodeCollection in: aTopicMap [
^ self new
	nodes: aNodeCollection;
	topicMap: aTopicMap;
	yourself 
]

{ #category : #navigation }
TMNodeGroup >> children [
	^ self nodes
]

{ #category : #navigation }
TMNodeGroup >> fields [
	^ (self children flatCollect: #fields) copyWithoutDuplicates
]

{ #category : #accessing }
TMNodeGroup >> items [
	^ nodes
]

{ #category : #accessing }
TMNodeGroup >> name [
	^ 'Node collection'
]

{ #category : #accessing }
TMNodeGroup >> nodes [
	^ nodes
]

{ #category : #accessing }
TMNodeGroup >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
TMNodeGroup >> pages [
	^ (self children flatCollect: #pages) copyWithoutDuplicates
]

{ #category : #printing }
TMNodeGroup >> printOn: aStream [
super printOn: aStream.
	aStream
		nextPut: $(;
		print: self pages size;
		nextPutAll: ' nodes';
		nextPut: $)
]

{ #category : #navigation }
TMNodeGroup >> styles [
	^ (self children flatCollect: #styles) copyWithoutDuplicates
]

{ #category : #navigation }
TMNodeGroup >> topics [
	^ (self children flatCollect: #topics) copyWithoutDuplicates
]
