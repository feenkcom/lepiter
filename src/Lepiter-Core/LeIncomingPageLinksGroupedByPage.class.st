Class {
	#name : #LeIncomingPageLinksGroupedByPage,
	#superclass : #LeIncomingPageLinksGroupedByOrigin,
	#category : 'Lepiter-Core-IncomingReferences'
}

{ #category : #testing }
LeIncomingPageLinksGroupedByPage >> isGroupedByPage [
	^ true
]

{ #category : #accessing }
LeIncomingPageLinksGroupedByPage >> referencingPage [
	^ self origin
]

{ #category : #accessing }
LeIncomingPageLinksGroupedByPage >> referencingPage: aLePage [
	self origin: aLePage
]
