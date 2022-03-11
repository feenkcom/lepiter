"
Determines the type of change in structure between two Lepiter pages.

The change in structure is calculated based on snippet ids. 
"
Class {
	#name : #LePageStructureChangeTypeDetector,
	#superclass : #Object,
	#category : #'Lepiter-Store-Reload'
}

{ #category : #api }
LePageStructureChangeTypeDetector >> detectChangeBetween: targetContent and: anotherContent [
	"Checks if the structure of the two pages is the same, including the order of snippets."
	
	targetContent children size = anotherContent children size
		ifFalse: [ ^ LePageComplexStructureChange ].
	
	targetContent children withIndexDo: [ :aSnippet :anIndex |
		| anotherSnippet childChange |
		anotherSnippet := anotherContent children at: anIndex.
		aSnippet uid = anotherSnippet uid
			ifFalse: [ ^ LePageComplexStructureChange ].
		childChange := self detectChangeBetween: aSnippet and: anotherSnippet.
		childChange = LePageComplexStructureChange ifTrue: [ ^ LePageComplexStructureChange ] ].

	^ LePageNoStructureChange
]
