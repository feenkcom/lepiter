Extension { #name : 'LeIncomingPageLinksTypeAndAmountViewModel' }

{ #category : '*Lepiter-UI' }
LeIncomingPageLinksTypeAndAmountViewModel >> asPhlowTool [
	^ self incomingPageLinksGroupModel asLepiterIncomingReferencesPhlowTool
]
