Class {
	#name : #LeExportExampleSnippetResource,
	#superclass : #LeExportSnippetResource,
	#instVars : [
		'height',
		'element'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #accessing }
LeExportExampleSnippetResource >> acceptVisitor: aVisitor [
	^ aVisitor visitExportExampleSnippetResource: self
]

{ #category : #initialization }
LeExportExampleSnippetResource >> defaultState [
	^ (self reference isNotNil and: [ self reference exists ])
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState uninitialized ]
]

{ #category : #accessing }
LeExportExampleSnippetResource >> height [
	<return: #Number>
	^ height
]

{ #category : #accessing }
LeExportExampleSnippetResource >> height: aNumber [
	height := aNumber
]

{ #category : #accessing }
LeExportExampleSnippetResource >> previewShowSelector [
	^ self snippet previewShowSelector
]
