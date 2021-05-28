"
I define root items, e.g., ${class:LeBlocks}$ that should be displayed in a tree (or potentionaly in a list).
I am used by ${class:LeBlockTreeElement}$.
"
Class {
	#name : #LeRootItemsSelector,
	#superclass : #Object,
	#category : #'Lepiter-Core-Utility'
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
