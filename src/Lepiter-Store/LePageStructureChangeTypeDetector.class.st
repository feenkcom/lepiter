Class {
	#name : #LePageStructureChangeTypeDetector,
	#superclass : #Object,
	#category : #'Lepiter-Store-Reload'
}

{ #category : #api }
LePageStructureChangeTypeDetector >> detectChangeBetween: aContent and: anotherContent [
	"Checks if the structure of the two pages is the same, including the order of snippets."
	
	aContent children size = anotherContent children size
		ifFalse: [ ^ LePageComplexStructureChange ].
	
	aContent children withIndexDo: [ :aSnippet :anIndex |
		| anotherSnippet childChange |
		anotherSnippet := anotherContent children at: anIndex.
		aSnippet uid = anotherSnippet uid
			ifFalse: [ ^ LePageComplexStructureChange ].
		childChange := self detectChangeBetween: aSnippet and: anotherSnippet.
		childChange = LePageComplexStructureChange ifTrue: [ ^ LePageComplexStructureChange ] ].

	^ LePageNoStructureChange
]
