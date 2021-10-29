Extension { #name : #LeIncomingPageLinksGroup }

{ #category : #'*Lepiter-UI' }
LeIncomingPageLinksGroup >> asLepiterIncomingReferencesPhlowTool [
	| aFilter |

	aFilter := LeAppliedFilter new
		database: self referencedPage database;
		filter: self contentFilter.

	^ LeIncomingReferencesTool appliedFilter: aFilter
]

{ #category : #'*Lepiter-UI' }
LeIncomingPageLinksGroup >> contentFilter [
	"Answer a LeFilter that will match the receiver's references"

	^ self subclassResponsibility
]
