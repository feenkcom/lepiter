Class {
	#name : #TMSceneryTopicNodeElement,
	#superclass : #GtSceneryMindMapNodeElement,
	#category : #'Lepiter-Topics-Scenery'
}

{ #category : #'as yet unclassified' }
TMSceneryTopicNodeElement >> initialize [
	super initialize.
	self beReadOnlyWithoutSelection
]
