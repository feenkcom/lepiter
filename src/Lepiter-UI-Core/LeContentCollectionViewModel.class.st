Class {
	#name : #LeContentCollectionViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'content',
		'children',
		'announcer',
		'parentContentCollection'
	],
	#category : #'Lepiter-UI-Core'
}

{ #category : #enumerating }
LeContentCollectionViewModel >> allChildrenBreadthFirstDo: aBlock [ 
	self children do: aBlock.
	self children do: [ :each | each allChildrenBreadthFirstDo: aBlock ]
]

{ #category : #announcer }
LeContentCollectionViewModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement.
	
	self parentContentCollection ifNotNil: [ :aParentCollection | aParentCollection announce: anAnnouncement ]
]

{ #category : #announcer }
LeContentCollectionViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
LeContentCollectionViewModel >> children [
	^ children
]

{ #category : #accessing }
LeContentCollectionViewModel >> children: anObject [
	children := anObject
]

{ #category : #accessing }
LeContentCollectionViewModel >> content [
	^ content
]

{ #category : #accessing }
LeContentCollectionViewModel >> content: aLeContent [
	content := aLeContent
]

{ #category : #'gt - extensions' }
LeContentCollectionViewModel >> gtViewChildrenFor: aView [ 
	<gtView>
	
	^ aView list
		title: 'Children';
		priority: 25;
		items: [ self children ]
]

{ #category : #initialization }
LeContentCollectionViewModel >> initialize [
	super initialize.
	
	children := #()
]

{ #category : #accessing }
LeContentCollectionViewModel >> parentContentCollection [
	^ parentContentCollection
]

{ #category : #accessing }
LeContentCollectionViewModel >> parentContentCollection: anObject [
	parentContentCollection := anObject
]

{ #category : #copying }
LeContentCollectionViewModel >> postCopy [
	super postCopy.
	
	announcer := nil
]

{ #category : #'api - scrolling' }
LeContentCollectionViewModel >> takeViewModelToScrollTo [
	^ nil
]

{ #category : #private }
LeContentCollectionViewModel >> updateChildren [
	"Rebuild a collection of children view models due to changes of the assigned content.
	This may happen when items are added or removed from the collection"
	
	self subclassResponsibility
]

{ #category : #enumerating }
LeContentCollectionViewModel >> withAllChildrenBreadthFirstDo: aBlock [ 
	aBlock value: self.
	self allChildrenBreadthFirstDo: aBlock
]
