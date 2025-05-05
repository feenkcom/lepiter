Class {
	#name : #LeIncomingPageLinkCardElementExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-IncomingReferences-Examples'
}

{ #category : #'examples - page - card' }
LeIncomingPageLinkCardElementExamples >> pageReferencedParagraphCardElement [
	<gtExample>
	<return: #LeIncomingPageLinkCardElement>
	| aPage thePageLinks anIncomingPageLink aPageLinkCardViewModel anElement |
	aPage := LeIncomingReferencesForUIExamples new
			pageThreeOfDatabaseWithLinkedReferencesAmongPages.
	thePageLinks := aPage incomingLinks.
	self assert: thePageLinks size equals: 2.

	anIncomingPageLink := LeIncomingPageLink new
			referencedPage: aPage;
			link: thePageLinks first.

	aPageLinkCardViewModel := LeIncomingPageLinkCardViewModel new
			incomingPageLinkModel: anIncomingPageLink.

	anElement := LeIncomingPageLinkCardElement new.
	anElement incomingPageLinkCardViewModel: aPageLinkCardViewModel.

	^ anElement
]
