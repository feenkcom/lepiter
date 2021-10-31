Class {
	#name : #LeExplicitLinksChange,
	#superclass : #LeAnnouncement,
	#instVars : [
		'explicitLinks'
	],
	#category : 'Lepiter-Core-Links'
}

{ #category : #accessing }
LeExplicitLinksChange >> explicitLinks [
	^ explicitLinks
]

{ #category : #accessing }
LeExplicitLinksChange >> explicitLinks: aCollectionOfLinks [ 
	explicitLinks := aCollectionOfLinks
]

{ #category : #testing }
LeExplicitLinksChange >> requiresSavingOfLinks [
	"Indicate if there are links within this change that should be persisted to disk."
	^ self subclassResponsibility
]
