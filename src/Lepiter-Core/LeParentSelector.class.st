"
I am ${class:LeRootItemsSelector}$.
I select the parent itself as a root item:
${method:LeParentSelector>>#rootsFor:into:|expanded}$
I am used by ${class:LeBlockTreeElement}$.
"
Class {
	#name : #LeParentSelector,
	#superclass : #LeRootItemsSelector,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Core-Utility'
}

{ #category : #'api - collect' }
LeParentSelector >> rootsFor: aPageOrBlock into: aStream [
	"Collect all root items"
	aStream nextPut: aPageOrBlock
]
