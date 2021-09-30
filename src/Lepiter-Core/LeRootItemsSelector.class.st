"
I define root items, e.g., {{gtClass:LeSnippets}} that should be displayed in a tree (or potentionaly in a list).

"
Class {
	#name : #LeRootItemsSelector,
	#superclass : #Object,
	#category : 'Lepiter-Core-Utility'
}

{ #category : #'api - collect' }
LeRootItemsSelector >> rootsFor: aPageOrBlock [
	"Collect all root items and return them as an array"

	^ Array streamContents: [ :aStream | self rootsFor: aPageOrBlock into: aStream ]
]

{ #category : #'api - collect' }
LeRootItemsSelector >> rootsFor: aPageOrBlock into: aStream [
	"Collect all root items"
	self subclassResponsibility 
]
