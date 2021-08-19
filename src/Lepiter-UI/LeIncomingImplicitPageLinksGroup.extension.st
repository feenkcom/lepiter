Extension { #name : 'LeIncomingImplicitPageLinksGroup' }

{ #category : '*Lepiter-UI' }
LeIncomingImplicitPageLinksGroup >> contentFilter [
	"Answer a LeFilter that will match the receiver's references"

	^ LePageUnlinkedReferencesFilter new title: self referencedPage title
]
