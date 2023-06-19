"
I am {{gtClass:LeRootItemsSelector}}.
I select the parent itself as a root item:
{{gtMethod:LeParentSelector>>#rootsFor:into:|expanded}}

"
Class {
	#name : #LeParentSelector,
	#superclass : #LeRootItemsSelector,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Core-Utility'
}

{ #category : #'api - collect' }
LeParentSelector >> rootsFor: aPageOrBlock into: aStream [
	"Collect all root items"
	aStream nextPut: aPageOrBlock
]
