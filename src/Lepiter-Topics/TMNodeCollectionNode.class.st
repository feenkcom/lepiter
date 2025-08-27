"
I hold as my children a collection of other nodes.
I am useful for generating ad hoc views of collections of pages, topics, etc.
"
Class {
	#name : #TMNodeCollectionNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'nodes'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #accessing }
TMNodeCollectionNode class >> for: aNodeCollection in: aTopicMap [
^ self new
	nodes: aNodeCollection;
	topicMap: aTopicMap;
	yourself 
]

{ #category : #navigation }
TMNodeCollectionNode >> children [
	^ self nodes
]

{ #category : #accessing }
TMNodeCollectionNode >> fields [
	^ (self children flatCollect: #fields) copyWithoutDuplicates
]

{ #category : #accessing }
TMNodeCollectionNode >> name [
	^ 'Node collection'
]

{ #category : #accessing }
TMNodeCollectionNode >> nodes [
	^ nodes
]

{ #category : #accessing }
TMNodeCollectionNode >> nodes: anObject [
	nodes := anObject
]

{ #category : #accessing }
TMNodeCollectionNode >> pages [
	^ (self children flatCollect: #pages) copyWithoutDuplicates
]

{ #category : #'as yet unclassified' }
TMNodeCollectionNode >> printOn: aStream [
super printOn: aStream.
	aStream
		nextPut: $(;
		print: self pages size;
		nextPutAll: ' nodes';
		nextPut: $)
]

{ #category : #accessing }
TMNodeCollectionNode >> styles [
	^ (self children flatCollect: #styles) copyWithoutDuplicates
]

{ #category : #accessing }
TMNodeCollectionNode >> topics [
	^ (self children flatCollect: #topics) copyWithoutDuplicates
]
