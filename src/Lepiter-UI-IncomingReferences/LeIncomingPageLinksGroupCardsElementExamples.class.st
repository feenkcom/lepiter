Class {
	#name : #LeIncomingPageLinksGroupCardsElementExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-IncomingReferences-Examples'
}

{ #category : #'examples - page - card' }
LeIncomingPageLinksGroupCardsElementExamples >> pageReferencesCardElementElement [
	<gtExample>
	<return: #LeIncomingPageLinksGroupCardsElement>
	| anElement aDatabase allLinkGroups theExplicitPageLinksGroup theExplicitLinksGroupedByOrigin theLinksFromPageOneToThree |
	"Ensure that unlinked incoming references are updated immediately so that stepping through produces the same results as running"
	BlUseAsyncFeatures
		disableDuring: [ aDatabase := LeIncomingReferencesForUIExamples new
					databaseWithLinkedReferencesAmongPages.
			LeUnlinkedReferenceMaintenance updateDatabase: aDatabase.
			allLinkGroups := LeLinksSelector default
					rootsFor: (aDatabase pageNamed: 'three') ].
	self assert: allLinkGroups size equals: 2.

	theExplicitPageLinksGroup := allLinkGroups first.
	self assert: theExplicitPageLinksGroup size equals: 2.
	self
		assert: theExplicitPageLinksGroup class
		equals: LeIncomingExplicitPageLinksGroup.

	theExplicitLinksGroupedByOrigin := theExplicitPageLinksGroup groupedByOrigin.
	self assert: theExplicitLinksGroupedByOrigin size equals: 2.
	self assert: theExplicitLinksGroupedByOrigin first isGroupedByPage.
	self
		assert: theExplicitLinksGroupedByOrigin first referencingPage
		equals: (aDatabase pageNamed: 'two').
	self assert: theExplicitLinksGroupedByOrigin second isGroupedByPage.
	self
		assert: theExplicitLinksGroupedByOrigin second referencingPage
		equals: (aDatabase pageNamed: 'one').

	theLinksFromPageOneToThree := theExplicitLinksGroupedByOrigin first.

	anElement := LeIncomingPageLinksGroupCardsElement new.
	anElement
		incomingPageLinksGroupCardsViewModel: (LeIncomingPageLinksGroupedByPageCardsViewModel new
				incomingPageLinksGroupedByPageModel: theLinksFromPageOneToThree).

	^ anElement
]
