Class {
	#name : #LeLinkReferenceCollectionViewModel,
	#superclass : #LeContentCollectionViewModel,
	#instVars : [
		'linkReferencePreviewViewModel'
	],
	#category : 'Lepiter-UI-! Link Reference'
}

{ #category : #accessing }
LeLinkReferenceCollectionViewModel >> content: aLeContent [
	super content: aLeContent.
	
	self updateChildren
]

{ #category : #accessing }
LeLinkReferenceCollectionViewModel >> linkReferencePreviewViewModel [
	<return: #LeLinkReferencePreviewViewModel>
	^ linkReferencePreviewViewModel
]

{ #category : #accessing }
LeLinkReferenceCollectionViewModel >> linkReferencePreviewViewModel: aLeLinkReferencePreviewViewModel [
	linkReferencePreviewViewModel := aLeLinkReferencePreviewViewModel
]

{ #category : #private }
LeLinkReferenceCollectionViewModel >> updateChildren [
	"Rebuild a collection of children view models due to changes of the assigned content.
	This may happen when items are added or removed from the collection"
	children := Array with: self linkReferencePreviewViewModel
]
