Class {
	#name : #LeExportElementSnippetResource,
	#superclass : #LeExportSnippetResource,
	#instVars : [
		'height',
		'element'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
LeExportElementSnippetResource >> acceptVisitor: aVisitor [
	^ aVisitor visitExportElementSnippetResource: self
]

{ #category : #initialization }
LeExportElementSnippetResource >> defaultState [
	^ (self reference isNotNil and: [ self reference exists ])
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState uninitialized ]
]

{ #category : #accessing }
LeExportElementSnippetResource >> element [
	<return: #BlElement>
	^ element
]

{ #category : #'private - building' }
LeExportElementSnippetResource >> element: anElement [
	self
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'Element must be kind of ' , BlElement name , ': ' format: {anElement} ].

	element := anElement
]

{ #category : #accessing }
LeExportElementSnippetResource >> height [
	<return: #Number>
	^ height
]

{ #category : #accessing }
LeExportElementSnippetResource >> height: aNumber [
	height := aNumber
]
