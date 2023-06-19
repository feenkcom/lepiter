Class {
	#name : #LeIncomingExplicitPageLinksGroup,
	#superclass : #LeIncomingPageLinksGroup,
	#category : 'Lepiter-Core-IncomingReferences'
}

{ #category : #initialization }
LeIncomingExplicitPageLinksGroup >> initializeForPage: aLePage [
	super initializeForPage: aLePage.
	
	self initializeWithLinks: aLePage incomingLinks
]

{ #category : #testing }
LeIncomingExplicitPageLinksGroup >> isExplicit [
	^ true
]
