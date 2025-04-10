Class {
	#name : #LeAbstractTableOfContentsNode,
	#superclass : #Object,
	#traits : 'TLeSpotterChildrenEnumerationSearch',
	#classTraits : 'TLeSpotterChildrenEnumerationSearch classTrait',
	#category : #'Lepiter-Utilities-ToC'
}

{ #category : #accessing }
LeAbstractTableOfContentsNode class >> treeNodeInfoElementClass [
	^ LePageTitleAndSummaryElement 
]

{ #category : #comparing }
LeAbstractTableOfContentsNode >> = anObject [
	^ self page = anObject page
]

{ #category : #accessing }
LeAbstractTableOfContentsNode >> asNodeViewModel [
	^ self page asContentUIModel
]

{ #category : #accessing }
LeAbstractTableOfContentsNode >> children [
	^ self subclassResponsibility
]

{ #category : #ui }
LeAbstractTableOfContentsNode >> gtChildrenFor: aView [
	<gtView>

	^ aView tree
		title: 'Children';
		priority: 50;
		items: [ self children ];
		children: #children
]

{ #category : #accessing }
LeAbstractTableOfContentsNode >> gtLiveFor: aView [
	<gtView>
	self page ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #comparing }
LeAbstractTableOfContentsNode >> hash [
	^ self class hash bitXor: [ 
		self page hash ]
]

{ #category : #accessing }
LeAbstractTableOfContentsNode >> isForPage [
	^ true
]

{ #category : #testing }
LeAbstractTableOfContentsNode >> isToCNode [
	^ true
]

{ #category : #accessing }
LeAbstractTableOfContentsNode >> page [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeAbstractTableOfContentsNode >> page: anObject [
	self subclassResponsibility
]

{ #category : #enumerating }
LeAbstractTableOfContentsNode >> selectedPageDo: aBlock [
	aBlock cull: self page
]
