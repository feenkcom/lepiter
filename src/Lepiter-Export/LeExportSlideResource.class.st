Class {
	#name : #LeExportSlideResource,
	#superclass : #LeExportSnippetResource,
	#instVars : [
		'slide',
		'height'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
LeExportSlideResource >> acceptVisitor: aVisitor [
	^ aVisitor visitExportSlideResource: self
]

{ #category : #initialization }
LeExportSlideResource >> defaultState [
	^ (self reference isNotNil and: [ self reference exists ])
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState uninitialized ]
]

{ #category : #accessing }
LeExportSlideResource >> gtSlideFor: aView [
	<gtView>
	slide ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Slide';
		priority: 15;
		object: [ slide ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeExportSlideResource >> height [
	<return: #Number>
	^ height
]

{ #category : #accessing }
LeExportSlideResource >> height: aNumber [
	height := aNumber
]

{ #category : #accessing }
LeExportSlideResource >> slide [
	^ slide
]

{ #category : #accessing }
LeExportSlideResource >> slide: anObject [
	slide := anObject
]
