Class {
	#name : #TMSceneryTopicNodeStencil,
	#superclass : #GtSceneryMindMapNodeStencil,
	#instVars : [
		'topicMapNode'
	],
	#category : #'Lepiter-Topics-Scenery'
}

{ #category : #'instance creation' }
TMSceneryTopicNodeStencil class >> for: aTopicMapNode [
	^ self new
		topicMapNode: aTopicMapNode;
		yourself
]

{ #category : #'api - instantiation' }
TMSceneryTopicNodeStencil >> elementClass [
	^ TMSceneryTopicNodeElement
]

{ #category : #accessing }
TMSceneryTopicNodeStencil >> topicMapNode [
	^ topicMapNode
]

{ #category : #accessing }
TMSceneryTopicNodeStencil >> topicMapNode: aTopicMapNode [
	self assert: aTopicMapNode isTMTreeNode.
	topicMapNode := aTopicMapNode.
	self label: self topicMapNode name.
	self backgroundColor: self topicMapNode defaultNodeColor
]
