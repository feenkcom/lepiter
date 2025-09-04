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

{ #category : #comparing }
TMNodeGroup >> = other [
	self == other ifTrue: [ ^ true ].
	self class = other class ifFalse: [^ false ].
	^ self nodes asSet = other nodes asSet
]

{ #category : #navigation }
TMNodeGroup >> children [
	^ self nodeGroupFor: self nodes
]

{ #category : #navigation }
TMNodeGroup >> fields [
	^ (self children flatCollect: #fields) copyWithoutDuplicates
]

{ #category : #comparing }
TMNodeGroup >> hash [
	"Bad hack? Should we combine all the hashes?"

	^ self nodes first hash
]

{ #category : #testing }
TMNodeGroup >> isTMNodeGroup [
	^ true
]

{ #category : #accessing }
TMNodeGroup >> items [
	^ nodes
]

{ #category : #mondrian }
TMNodeGroup >> mondrianRoadMapNodes [
	^ self subclassResponsibility
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
