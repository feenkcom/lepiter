"
I am {{gtClass:LeRootItemsSelector}}.
I select all {{gtClass:LeDatabase}} direct children that satisfies a filter conditions:
{{gtMethod:LeFilteredChildrenSelector>>#rootsFor:into:|expanded}}
I am used by {{gtClass:LeDatabaseFilteredTreeElement|show=#gtDocumentFor:}}.

"
Class {
	#name : #LeFilteredChildrenSelector,
	#superclass : #LeRootItemsSelector,
	#instVars : [
		'element'
	],
	#category : 'Lepiter-Core-Utility'
}

{ #category : #'api - accessing' }
LeFilteredChildrenSelector >> element [
	^ element
]

{ #category : #'api - accessing' }
LeFilteredChildrenSelector >> element: anObject [
	element := anObject
]

{ #category : #'private - accessing' }
LeFilteredChildrenSelector >> filters [
	^ self element filters
]

{ #category : #'api - collect' }
LeFilteredChildrenSelector >> rootsFor: aDatabase into: aStream [
	"Collect all root items"
	aDatabase children do: [ :eachPage | 
		(self filters allSatisfy: [ :filter | filter matches: eachPage ])
			ifTrue: [ aStream nextPut: eachPage ] ].
]
