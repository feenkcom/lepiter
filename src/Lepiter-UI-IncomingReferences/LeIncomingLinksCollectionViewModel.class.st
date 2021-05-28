Class {
	#name : #LeIncomingLinksCollectionViewModel,
	#superclass : #LeContentCollectionViewModel,
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #accessing }
LeIncomingLinksCollectionViewModel >> content: aLeContent [
	super content: aLeContent.
	
	self updateChildren
]
