"
I am ${class:LeRootItemsSelector}$.
I select all direct ${class:LePage}$ children and incoming references:
${method:LeChildrenAndLinksSelector>>#rootsFor:into:|expanded}$
"
Class {
	#name : #LeChildrenAndLinksSelector,
	#superclass : #LeRootItemsSelector,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Core-Utility'
}

{ #category : #'api - collect' }
LeChildrenAndLinksSelector >> rootsFor: aPageOrBlock into: aStream [
	"Collect all root items"
	LeChildrenSelector default rootsFor: aPageOrBlock into: aStream.
	LeLinksSelector default rootsFor: aPageOrBlock into: aStream.
]
