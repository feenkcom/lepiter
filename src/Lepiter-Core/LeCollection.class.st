Class {
	#name : #LeCollection,
	#superclass : #LeModel,
	#traits : 'TLeSpotterChildrenEnumerationSearch + TLeSpotterPagesSearch',
	#classTraits : 'TLeSpotterChildrenEnumerationSearch classTrait + TLeSpotterPagesSearch classTrait',
	#instVars : [
		'items'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'api - factory' }
LeCollection class >> empty [
	^ self new
]

{ #category : #visiting }
LeCollection >> acceptVisitor: aVisitor [

	^ aVisitor visitCollection: self
]

{ #category : #'api - adding / removing' }
LeCollection >> addChild: aChild [

	self items add: aChild
]

{ #category : #'api - adding / removing' }
LeCollection >> addFirstChild: aChild [

	^ self items addFirst: aChild.

]

{ #category : #accessing }
LeCollection >> anyOne [
	^ self first
]

{ #category : #enumerating }
LeCollection >> anySatisfy: aBlock [
	^ self items anySatisfy: aBlock
]

{ #category : #converting }
LeCollection >> asArray [
	^ Array streamContents: [ :aStream | self do: [ :eachItem | aStream nextPut: eachItem ] ]
]

{ #category : #'api - accessing' }
LeCollection >> at: anIndex [
	^ self items at: anIndex
]

{ #category : #'api - accessing' }
LeCollection >> children [
	<return: #Collection of: #LeContent>
	^ self items
]

{ #category : #'api - enumerating' }
LeCollection >> collect: aBlock [
	^ self items collect: aBlock
]

{ #category : #'api - enumerating' }
LeCollection >> collect: aBlock as: aClass [
	^ items collect: aBlock as: aClass
]

{ #category : #'api - enumerating' }
LeCollection >> copyDo: aBlock [
	"Iterate over a copy of the receiver's items.
	This is useful if the operation will modify the receiver's items in some way"

	self items copy do: aBlock
]

{ #category : #defaults }
LeCollection >> defaultItems [

	^ OrderedCollection new.
]

{ #category : #enumerating }
LeCollection >> detect: aBlock [ 

	^ items detect: aBlock
]

{ #category : #enumerating }
LeCollection >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [
	^ self items detect: aBlock ifFound: foundBlock ifNone: exceptionBlock
]

{ #category : #'api - enumerating' }
LeCollection >> do: aBlock [
	self items do: aBlock
]

{ #category : #'api - accessing' }
LeCollection >> fifth [

	^ items fifth
]

{ #category : #'api - accessing' }
LeCollection >> first [

	^ items first
]

{ #category : #'api - enumerating' }
LeCollection >> flatCollect: aBlock [
	^ self items flatCollect: aBlock
]

{ #category : #'api - accessing' }
LeCollection >> fourth [

	^ items fourth
]

{ #category : #'gt-extensions' }
LeCollection >> gtSpotterContainingSubPartsFor: aSearch [
	<gtSearch>
	
	self hasChildren 
		ifNil: [ ^ aSearch empty ].

	^ aSearch list
		priority: 23;
		title: 'Children Tree Content';
		wantsToDisplayOnEmptyQuery: false;
		items: [ self children ]
		filterBySubstring
]

{ #category : #'api - testing' }
LeCollection >> hasChildren [
	<return: #Boolean>
	^ self isNotEmpty
]

{ #category : #testing }
LeCollection >> ifEmpty: aBlock [
	^ self items ifEmpty: aBlock
]

{ #category : #testing }
LeCollection >> includes: anObject [ 
	^ self items includes: anObject
]

{ #category : #accessing }
LeCollection >> indexOf: anItem [

	^ items indexOf: anItem
]

{ #category : #initialization }
LeCollection >> initialize [
	super initialize.
	items := self defaultItems.
]

{ #category : #'api - testing' }
LeCollection >> isEmpty [
	^ self items isEmpty
]

{ #category : #'api - testing' }
LeCollection >> isNotEmpty [
	^ self isEmpty not 
]

{ #category : #'api - accessing' }
LeCollection >> items [
	^ items
]

{ #category : #'api - accessing' }
LeCollection >> items: aCollection [
	items := aCollection asOrderedCollection.
	self onItemsChanged.
]

{ #category : #accessing }
LeCollection >> last [ 

	^ items last
]

{ #category : #'api - testing' }
LeCollection >> notEmpty [
	^ self isEmpty not 
]

{ #category : #'private - hooks' }
LeCollection >> onItemsChanged [
	"Subclasses may react to changes"
]

{ #category : #removing }
LeCollection >> removeAllSuchThat: aBlock [ 

	^ items copy do: [ :item |
		(aBlock value: item) ifTrue: 
			[ item removeSelf ] ]
]

{ #category : #'api - accessing' }
LeCollection >> second [

	^ items second
]

{ #category : #'api - enumerating' }
LeCollection >> select: aBlock [
	^ self items select: aBlock
]

{ #category : #'api - accessing' }
LeCollection >> size [
	^ self items size
]

{ #category : #'api - accessing' }
LeCollection >> third [

	^ items third
]

{ #category : #'api - enumerating' }
LeCollection >> withIndexDo: aBlock [
	self items withIndexDo: aBlock
]
