Class {
	#name : #LeExportElementSnippetResource,
	#superclass : #LeExportSnippetResource,
	#instVars : [
		'height'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #accessing }
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
LeExportElementSnippetResource >> height [
	<return: #Number>
	^ height
]

{ #category : #accessing }
LeExportElementSnippetResource >> height: aNumber [
	height := aNumber
]
