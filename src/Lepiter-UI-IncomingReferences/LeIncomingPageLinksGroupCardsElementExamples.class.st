Class {
	#name : #LeIncomingPageLinksGroupCardsElementExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-IncomingReferences-Examples'
}

{ #category : #'examples - page - card' }
LeIncomingPageLinksGroupCardsElementExamples >> pageReferencesCardElementElement [
	<gtExample>
	| anElement aDatabase allLinkGroups theExplicitPageLinksGroup theExplicitLinksGroupedByOrigin theLinksFromPageOneToThree |

	aDatabase := LeIncomingReferencesForUIExamples new databaseWithLinkedReferencesAmongPages.
	
	allLinkGroups := LeLinksSelector default rootsFor: (aDatabase pageNamed: 'three').
	self assert: allLinkGroups size equals: 1.

	theExplicitPageLinksGroup :=  allLinkGroups first.
	self assert: theExplicitPageLinksGroup size equals: 2.
	self assert: theExplicitPageLinksGroup class equals: LeIncomingExplicitPageLinksGroup.

	theExplicitLinksGroupedByOrigin := theExplicitPageLinksGroup groupedByOrigin.
	self assert: theExplicitLinksGroupedByOrigin size equals: 2.
	self assert: theExplicitLinksGroupedByOrigin first isGroupedByPage.
	self assert: theExplicitLinksGroupedByOrigin first referencingPage equals: (aDatabase pageNamed: 'one').
	self assert: theExplicitLinksGroupedByOrigin second isGroupedByPage.
	self assert: theExplicitLinksGroupedByOrigin second referencingPage equals: (aDatabase pageNamed: 'two').

	theLinksFromPageOneToThree := theExplicitLinksGroupedByOrigin first.

	anElement := LeIncomingPageLinksGroupCardsElement new.
	anElement incomingPageLinksGroupCardsViewModel: (LeIncomingPageLinksGroupedByPageCardsViewModel new
		incomingPageLinksGroupedByPageModel: theLinksFromPageOneToThree).
	
	^ anElement
]
