Class {
	#name : #LeContextMenuItemSpecification,
	#superclass : #Object,
	#traits : 'TLeContextMenuItemSpecification',
	#classTraits : 'TLeContextMenuItemSpecification classTrait',
	#instVars : [
		'title',
		'snippetClass',
		'priority',
		'definingMethod'
	],
	#category : 'Lepiter-UI-Snippet-Spotter'
}

{ #category : #'api - converting' }
LeContextMenuItemSpecification >> asSnippet [
	<return: #LeSnippet>
	^ self snippetClass empty
]

{ #category : #initialization }
LeContextMenuItemSpecification >> defaultPriority [
	^ 50
]

{ #category : #'api - accessing' }
LeContextMenuItemSpecification >> definingMethod [
	^ definingMethod
]

{ #category : #'api - accessing' }
LeContextMenuItemSpecification >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #'gt - extensions' }
LeContextMenuItemSpecification >> gtDefiningMethodFor: aView [
	<gtView>
	self definingMethod ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Source';
		priority: 2;
		object: [ self definingMethod ];
		view: #gtSourceFor:
]

{ #category : #'gt - extensions' }
LeContextMenuItemSpecification >> gtLiveFor: aView [
	<gtView>
	self definingMethod ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Live';
		priority: 1;
		object: [ self snippetClass new ];
		view: #gtLiveFor:
]

{ #category : #initialization }
LeContextMenuItemSpecification >> initialize [
	super initialize.
	priority := self defaultPriority.
	snippetClass := LeUnknownSnippet.
	title := 'Unknown'
]

{ #category : #testing }
LeContextMenuItemSpecification >> isDefaultPriority [
	^ self priority = self defaultPriority
]

{ #category : #printing }
LeContextMenuItemSpecification >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		print: self snippetClass;
		nextPutAll: ', ';
		nextPutAll: self title asString;
		nextPut: $)
]

{ #category : #'api - accessing' }
LeContextMenuItemSpecification >> priority [
	^ priority
]

{ #category : #'api - accessing' }
LeContextMenuItemSpecification >> priority: anObject [
	priority := anObject
]

{ #category : #'api - accessing' }
LeContextMenuItemSpecification >> snippetClass [
	^ snippetClass
]

{ #category : #'api - accessing' }
LeContextMenuItemSpecification >> snippetClass: aClass [
	snippetClass := aClass instanceSide
]

{ #category : #'as yet unclassified' }
LeContextMenuItemSpecification >> title [
	^ title
]

{ #category : #'api - accessing' }
LeContextMenuItemSpecification >> title: anObject [
	title := anObject
]
