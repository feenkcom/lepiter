"
I am {{gtClass:LeRootItemsSelector}}.
I select all direct children of an item, e.g., {{gtClass:LePage}}:
{{gtMethod:LeChildrenSelector>>#rootsFor:into:|expanded}}

"
Class {
	#name : #LeChildrenSelector,
	#superclass : #LeRootItemsSelector,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Core-Utility'
}

{ #category : #'api - collect' }
LeChildrenSelector >> rootsFor: aPageOrBlock into: aStream [
	"Collect all root items"
	aStream nextPutAll: aPageOrBlock children.
]
