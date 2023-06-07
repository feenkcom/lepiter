Class {
	#name : #LeExportSnippetResource,
	#superclass : #Object,
	#traits : 'TLeExportResource',
	#classTraits : 'TLeExportResource classTrait',
	#instVars : [
		'path',
		'snippet',
		'reference'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
LeExportSnippetResource >> acceptVisitor: aVisitor [
	^ aVisitor visitExportSnippetResource: self
]

{ #category : #initialization }
LeExportSnippetResource >> defaultState [
	<return: #LeExportResourceState>
	^ LeExportResourceState ready
]

{ #category : #'gt - extensions' }
LeExportSnippetResource >> gtFigureFor: aView [
	<gtView>
	reference ifNil: [ ^ aView empty ].
	reference exists ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Picture';
		priority: 10;
		object: [ reference ];
		view: #gtFigureFor:
]

{ #category : #'gt - extensions' }
LeExportSnippetResource >> gtPageFor: aView [
	<gtView>
	snippet ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Page';
		priority: 30;
		object: [ snippet page ];
		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
LeExportSnippetResource >> gtSnippetFor: aView [
	<gtView>
	snippet ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Snippet';
		priority: 20;
		object: [ snippet ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeExportSnippetResource >> path [
	<return: #RelativePath>
	^ path
]

{ #category : #accessing }
LeExportSnippetResource >> path: aRelativePath [
	path := aRelativePath
]

{ #category : #accessing }
LeExportSnippetResource >> reference [
	<return: #FileReference>
	^ reference
]

{ #category : #accessing }
LeExportSnippetResource >> reference: aFileReference [
	reference := aFileReference
]

{ #category : #accessing }
LeExportSnippetResource >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportSnippetResource >> snippet: anObject [
	snippet := anObject
]

{ #category : #accessing }
LeExportSnippetResource >> source [
	"Return a source of the export"

	^ self snippet
]

{ #category : #accessing }
LeExportSnippetResource >> sourceType [
	"Return an object,e.g., a class, that represents the source type.
	I can be used for grouping resources by this type."

	^ self snippet page
]

{ #category : #'api - state' }
LeExportSnippetResource >> state: aState [
	"Set resource state, indicating whether the resource is ready for export."

	state := aState
]
