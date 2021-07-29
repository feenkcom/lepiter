Class {
	#name : #LeLinksSelector,
	#superclass : #LeRootItemsSelector,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Core-Utility'
}

{ #category : #'api - collect' }
LeLinksSelector >> rootsFor: aPageOrSnippet into: aStream [
	"Collect all link items"
	| aReferencedPage |

	aPageOrSnippet isPage
		ifFalse: [ ^ self ].
	
	"re-assign under a different name to emphasise that the link groups
	are created for a page and NOT for a snippet"
	aReferencedPage := aPageOrSnippet.

	aReferencedPage hasIncomingLinks
		ifTrue: [ aStream nextPut: (LeIncomingExplicitPageLinksGroup forPage: aReferencedPage) ].
	aReferencedPage hasIncomingUnlinked
		ifTrue: [ aStream nextPut: (LeIncomingImplicitPageLinksGroup forPage: aReferencedPage) ]
]
