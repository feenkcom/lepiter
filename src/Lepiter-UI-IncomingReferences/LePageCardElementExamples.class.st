Class {
	#name : #LePageCardElementExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-IncomingReferences-Examples'
}

{ #category : #'examples - showroom' }
LePageCardElementExamples >> pageCardElement [
	<gtExample>
	<return: #LePageCardElement>
	| anElement aPage |
	aPage := LeIncomingReferencesForUIExamples new
			pageThreeOfDatabaseWithLinkedReferencesAmongPages.

	anElement := LePageCardElement new.
	anElement pageViewModel: aPage asContentUIModel.

	self assert: anElement containerElement label characters equals: aPage title.

	^ anElement
]
