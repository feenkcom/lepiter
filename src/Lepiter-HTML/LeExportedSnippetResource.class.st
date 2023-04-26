Class {
	#name : #LeExportedSnippetResource,
	#superclass : #Object,
	#traits : 'TLeExportedResource',
	#classTraits : 'TLeExportedResource classTrait',
	#instVars : [
		'path',
		'snippet',
		'reference'
	],
	#category : #'Lepiter-HTML-Model'
}

{ #category : #visiting }
LeExportedSnippetResource >> accept: aVisitor [
	^ aVisitor visitExportedSnippetResource: self
]

{ #category : #'gt - extensions' }
LeExportedSnippetResource >> gtFigureFor: aView [
	<gtView>
	reference ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Picture';
		priority: 10;
		object: [ reference ];
		view: #gtFigureFor:
]

{ #category : #accessing }
LeExportedSnippetResource >> path [
	<return: #RelativePath>
	^ path
]

{ #category : #accessing }
LeExportedSnippetResource >> path: aRelativePath [
	path := aRelativePath
]

{ #category : #accessing }
LeExportedSnippetResource >> reference [
	<return: #FileReference>
	^ reference
]

{ #category : #accessing }
LeExportedSnippetResource >> reference: aFileReference [
	reference := aFileReference
]

{ #category : #accessing }
LeExportedSnippetResource >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportedSnippetResource >> snippet: anObject [
	snippet := anObject
]

{ #category : #accessing }
LeExportedSnippetResource >> source [
	"Return a source of the export"

	^ self snippet
]
