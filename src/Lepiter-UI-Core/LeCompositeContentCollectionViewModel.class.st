Class {
	#name : #LeCompositeContentCollectionViewModel,
	#superclass : #LeContentCollectionViewModel,
	#instVars : [
		'viewModelCollections'
	],
	#category : #'Lepiter-UI-Core'
}

{ #category : #adding }
LeCompositeContentCollectionViewModel >> addContentCollectionViewModel: aContentCollectionViewModel [
	viewModelCollections add: aContentCollectionViewModel.
	aContentCollectionViewModel parentContentCollection: self
]

{ #category : #enumerating }
LeCompositeContentCollectionViewModel >> allChildrenBreadthFirstDo: aBlock [ 
	viewModelCollections do: [ :each | each allChildrenBreadthFirstDo: aBlock ]
]

{ #category : #accessing }
LeCompositeContentCollectionViewModel >> children [
	^ Array streamContents: [ :aStream | 
		viewModelCollections do: [ :eachCollection | 
			aStream nextPutAll: eachCollection children ] ]
]

{ #category : #accessing }
LeCompositeContentCollectionViewModel >> content: aLeContent [
	super content: aLeContent.
	viewModelCollections
		do: [ :eachCollection | eachCollection content: aLeContent ]
]

{ #category : #initialization }
LeCompositeContentCollectionViewModel >> initialize [
	super initialize.
	
	viewModelCollections := OrderedCollection new
]

{ #category : #'api - scrolling' }
LeCompositeContentCollectionViewModel >> takeViewModelToScrollTo [
	viewModelCollections do: [ :eachViewModel |
		eachViewModel takeViewModelToScrollTo
			ifNotNil: [ :aViewModel | ^ aViewModel ] ].
	^ nil
]

{ #category : #private }
LeCompositeContentCollectionViewModel >> updateChildren [
	"Rebuild a collection of children view models due to changes of the assigned content.
	This may happen when items are added or removed from the collection"
	
	viewModelCollections do: [ :eachCollection | eachCollection updateChildren ]
]
