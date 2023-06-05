Class {
	#name : #LeExportedAnnotationResource,
	#superclass : #Object,
	#traits : 'TLeExportResource',
	#classTraits : 'TLeExportResource classTrait',
	#instVars : [
		'annotation',
		'path',
		'reference'
	],
	#category : #'Lepiter-HTML-Old-Model'
}

{ #category : #visiting }
LeExportedAnnotationResource >> accept: aVisitor [
	^ aVisitor visitExportedAnnotationResource: self
]

{ #category : #accessing }
LeExportedAnnotationResource >> annotation [
	^ annotation
]

{ #category : #accessing }
LeExportedAnnotationResource >> annotation: anObject [
	annotation := anObject
]

{ #category : #'gt - extensions' }
LeExportedAnnotationResource >> gtFigureFor: aView [
	<gtView>
	reference ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Picture';
		priority: 10;
		object: [ reference ];
		view: #gtFigureFor:
]

{ #category : #accessing }
LeExportedAnnotationResource >> path [
	<return: #RelativePath>
	^ path
]

{ #category : #accessing }
LeExportedAnnotationResource >> path: anObject [
	path := anObject
]

{ #category : #accessing }
LeExportedAnnotationResource >> reference [
	<return: #FileReference>
	^ reference
]

{ #category : #accessing }
LeExportedAnnotationResource >> reference: aFileReference [
	reference := aFileReference
]

{ #category : #accessing }
LeExportedAnnotationResource >> source [
	"Return a source of the export"

	^ self annotation
]
