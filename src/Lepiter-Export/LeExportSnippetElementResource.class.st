Class {
	#name : #LeExportSnippetElementResource,
	#superclass : #LeExportSnippetResource,
	#instVars : [
		'height',
		'element'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
LeExportSnippetElementResource >> acceptVisitor: aVisitor [
	^ aVisitor visitExportSnippetElementResource: self
]

{ #category : #initialization }
LeExportSnippetElementResource >> defaultState [
	^ (self reference isNotNil and: [ self reference exists ])
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState uninitialized ]
]

{ #category : #accessing }
LeExportSnippetElementResource >> element [
	<return: #BlElement>
	^ element ifNil: [ element := self newSnippetElement ]
]

{ #category : #accessing }
LeExportSnippetElementResource >> element: aSnippetElement [
	element := aSnippetElement
]

{ #category : #accessing }
LeExportSnippetElementResource >> height [
	<return: #Number>
	^ height ifNil: [ height := LepiterConstants defaultPreviewHeight ]
]

{ #category : #accessing }
LeExportSnippetElementResource >> height: aNumber [
	height := aNumber
]

{ #category : #'instance creation' }
LeExportSnippetElementResource >> newSnippetElement [
	^ LeExportUtility newSnippetElementFor: snippet
]
