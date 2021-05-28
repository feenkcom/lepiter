Class {
	#name : #LeIncomingLinksCardsViewModel,
	#superclass : #LeIncomingLinksCollectionViewModel,
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #private }
LeIncomingLinksCardsViewModel >> updateChildren [
	children := (LeLinksSelector default rootsFor: self content)
		collect: [ :eachLeIncomingPageLinksGroup |
			| linksGroupedByOrigin |

			linksGroupedByOrigin := eachLeIncomingPageLinksGroup groupedByOrigin.

			LeIncomingPageLinksTypeAndAmountViewModel new
				expanded: false;
				incomingPageLinksGroupModel: eachLeIncomingPageLinksGroup;
				snippetChildren: (linksGroupedByOrigin flatCollect: [ :eachLinksGroupedByOrigin |
					{
						"origin or referencing page label"
						eachLinksGroupedByOrigin isGroupedByPage
							ifTrue: [
								LeIncomingPageLinksReferencingPageLabelViewModel new
									incomingPageLinksGroupedByPageModel: eachLinksGroupedByOrigin ]
							ifFalse: [
								LeIncomingPageLinksOriginLabelViewModel new
									incomingPageLinksGroupedByOriginModel: eachLinksGroupedByOrigin ].

						"links"
						eachLinksGroupedByOrigin isGroupedByPage
							ifTrue: [ LeIncomingPageLinksGroupedByPageCardsViewModel new incomingPageLinksGroupedByPageModel: eachLinksGroupedByOrigin ]
							ifFalse: [
								eachLinksGroupedByOrigin links collect: [ :eachIncomingPageLink |
									LeIncomingPageLinkCardViewModel new incomingPageLinkModel: eachIncomingPageLink ] ] } ]) ]
]
