Class {
	#name : #TMSceneryBuilder,
	#superclass : #Object,
	#instVars : [
		'topicMapNode'
	],
	#category : #'Lepiter-Topics-Scenery'
}

{ #category : #'instance creation' }
TMSceneryBuilder class >> for: aTopicMapNode [
	"Normally this should be the databaseNode, but it can be any subnode as well."

	^ self new
		topicMapNode: aTopicMapNode;
		yourself
]

{ #category : #building }
TMSceneryBuilder >> build [
	| scenery root rootItem |
	scenery := GtScenery new.

	root := self topicMapNode.
	rootItem := (TMSceneryTopicNodeStencil for: root) asItem.
	scenery addSceneryItem: rootItem.

	root children nodes
		do: [ :each | 
			| item |
			item := scenery addSceneryItem: (TMSceneryTopicNodeStencil for: each) asItem.
			scenery addConnectionFrom: rootItem to: item ].
	scenery
		onceLayout: (GtGradHorizontalTreeLayout new
				levelDistance: 50;
				nodeDistance: 20).
	^ scenery
]

{ #category : #accessing }
TMSceneryBuilder >> topicMapNode [
	^ topicMapNode
]

{ #category : #accessing }
TMSceneryBuilder >> topicMapNode: aTopicMapNode [
	self assert: aTopicMapNode isTMTreeNode.
	topicMapNode := aTopicMapNode
]
