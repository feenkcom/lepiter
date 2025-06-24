Class {
	#name : #LeIncomingPageLinksTypeAndAmountElementExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-IncomingReferences-Examples'
}

{ #category : #examples }
LeIncomingPageLinksTypeAndAmountElementExamples >> linksTypeAndAmountElement [
	<gtExample>
	<return: #LeIncomingPageLinksTypeAndAmountElement>
	| anElement theIncomingReferences anIncomingPageLinksViewModel |
	theIncomingReferences := LeIncomingReferencesForUIExamples new
			linkedReferences_PageThree.
	anIncomingPageLinksViewModel := LeIncomingPageLinksTypeAndAmountViewModel new
			incomingPageLinksGroupModel: theIncomingReferences.

	anElement := LeIncomingPageLinksTypeAndAmountElement new.
	anElement incomingPageLinksTypeAndAmountViewModel: anIncomingPageLinksViewModel.

	self assert: anElement text characters equals: '2 explicit references'.

	^ anElement
]
