Class {
	#name : #LeExportAnnotationResource,
	#superclass : #Object,
	#traits : 'TLeExportResource',
	#classTraits : 'TLeExportResource classTrait',
	#instVars : [
		'annotation',
		'path',
		'reference'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
LeExportAnnotationResource >> acceptVisitor: aVisitor [
	^ aVisitor visitExportAnnotationResource: self
]

{ #category : #accessing }
LeExportAnnotationResource >> annotation [
	^ annotation
]

{ #category : #accessing }
LeExportAnnotationResource >> annotation: anObject [
	annotation := anObject
]

{ #category : #initialization }
LeExportAnnotationResource >> defaultState [
	<return: #LeExportResourceState>
	^ (self reference isNotNil and: [ self reference exists ])
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState uninitialized ]
]

{ #category : #'gt - extensions' }
LeExportAnnotationResource >> gtFigureFor: aView [
	<gtView>
	reference ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Picture';
		priority: 10;
		object: [ reference ];
		view: #gtFigureFor:
]

{ #category : #accessing }
LeExportAnnotationResource >> path [
	<return: #RelativePath>
	^ path
]

{ #category : #accessing }
LeExportAnnotationResource >> path: anObject [
	path := anObject
]

{ #category : #accessing }
LeExportAnnotationResource >> reference [
	<return: #FileReference>
	^ reference
]

{ #category : #accessing }
LeExportAnnotationResource >> reference: aFileReference [
	reference := aFileReference
]

{ #category : #accessing }
LeExportAnnotationResource >> source [
	"Return a source of the export"

	^ self annotation
]
