Class {
	#name : #LeIncomingImplicitPageLinksGroup,
	#superclass : #LeIncomingPageLinksGroup,
	#category : 'Lepiter-Core-IncomingReferences'
}

{ #category : #initialization }
LeIncomingImplicitPageLinksGroup >> initializeForPage: aLePage [
	super initializeForPage: aLePage.

	self initializeWithLinks: aLePage incomingUnlinked
]

{ #category : #testing }
LeIncomingImplicitPageLinksGroup >> isImplicit [
	^ true
]
