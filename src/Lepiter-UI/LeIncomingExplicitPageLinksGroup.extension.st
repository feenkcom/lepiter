Extension { #name : #LeIncomingExplicitPageLinksGroup }

{ #category : #'*Lepiter-UI' }
LeIncomingExplicitPageLinksGroup >> contentFilter [
	"Answer a LeFilter that will match the receiver's references"

	^ LePageLinkedReferencesFilter new title: self referencedPage title
]
