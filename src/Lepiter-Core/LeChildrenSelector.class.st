"
I am ${class:LeRootItemsSelector}$.
I select all direct children of an item, e.g., ${class:LePage}$:
${method:LeChildrenSelector>>#rootsFor:into:|expanded}$
I am used by ${class:LeBlockTreeElement}$.
"
Class {
	#name : #LeChildrenSelector,
	#superclass : #LeRootItemsSelector,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Core-Utility'
}

{ #category : #'api - collect' }
LeChildrenSelector >> rootsFor: aPageOrBlock into: aStream [
	"Collect all root items"
	aStream nextPutAll: aPageOrBlock children.
]
