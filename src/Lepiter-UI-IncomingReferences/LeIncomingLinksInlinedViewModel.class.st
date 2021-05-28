Class {
	#name : #LeIncomingLinksInlinedViewModel,
	#superclass : #LeIncomingLinksCollectionViewModel,
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #private }
LeIncomingLinksInlinedViewModel >> updateChildren [
	children := (LeLinksSelector default rootsFor: self content)
		collect: [ :eachLeIncomingPageLinksGroup |
			| linksGroupedByOrigin |

			linksGroupedByOrigin := eachLeIncomingPageLinksGroup groupedByOrigin.

			LeIncomingPageLinksTypeAndAmountViewModel new
				expanded: false;
				incomingPageLinksGroupModel: eachLeIncomingPageLinksGroup;
				snippetChildren: (linksGroupedByOrigin collect: [ :eachLinksGroupedByOrigin |
						"origin or referencing page label"
						eachLinksGroupedByOrigin isGroupedByPage
							ifTrue: [
								LeIncomingPageLinksReferencingPageLabelViewModel new
									marginTop: 2;
									incomingPageLinksGroupedByPageModel: eachLinksGroupedByOrigin;
									snippetChildren: (eachLinksGroupedByOrigin links collect: [ :eachLeIncomingPageLink |
										eachLeIncomingPageLink originReference content asSnippetViewModel ]) ]
							ifFalse: [
								LeIncomingPageLinksOriginLabelViewModel new
									incomingPageLinksGroupedByOriginModel: eachLinksGroupedByOrigin;
									snippetChildren: (eachLinksGroupedByOrigin links collect: [ :eachIncomingPageLink |
										LeIncomingPageLinkCardViewModel new incomingPageLinkModel: eachIncomingPageLink ]) ] ]) ]
]
