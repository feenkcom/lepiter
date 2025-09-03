"
I am a special case of my superclass that distinguishes two page nodes for the same page, but different topics.
I am only needed for Mondrian tree layouts that contain nodes for the same page multiple times for different topics.
My = method is implemented so that Mondrian can correctly connect edges between page nodes and topics.
"
Class {
	#name : #TMPageForTopicNode,
	#superclass : #TMPageNode,
	#category : #'Lepiter-Topics-Model'
}

{ #category : #comparing }
TMPageForTopicNode >> = other [
	^ super = other and: [ self treeMapParent = other treeMapParent ]
]

{ #category : #comparing }
TMPageForTopicNode >> hash [
	^ super hash bitXor: self treeMapParent hash
]
