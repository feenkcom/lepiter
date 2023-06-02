Class {
	#name : #LeExportVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-Export-! Core'
}

{ #category : #accessing }
LeExportVisitor >> context [
	<return: #TLeExportContext>
	^ context
]

{ #category : #accessing }
LeExportVisitor >> context: aContext [
	context := aContext
]

{ #category : #'gt - extensions' }
LeExportVisitor >> gtFilesFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 20;
		object: [ context ];
		view: #gtFilesFor:
]

{ #category : #'gt - extensions' }
LeExportVisitor >> gtResourcesFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ context ];
		view: #gtResourcesFor:
]

{ #category : #'private - exporting' }
LeExportVisitor >> objectSpecificationFor: anObject [
	<return: #TLeObjectExportSpecification>
	^ context objectSpecificationFor: anObject
]

{ #category : #'private - exporting' }
LeExportVisitor >> resourcesFor: aLeSnippet [
	| snippetResources |
	snippetResources := context resources select: [ :eachResource | 
		eachResource source == aLeSnippet ].
	
	^ LeExportSnippetResources new
		resources: snippetResources
]

{ #category : #visiting }
LeExportVisitor >> visitElementSnippet: aLeElementSnippet [
	self writeElementSnippet: aLeElementSnippet.
	^ self visitContent: aLeElementSnippet
]

{ #category : #visiting }
LeExportVisitor >> visitPictureSnippet: aLePictureSnippet [
	self writePictureSnippet: aLePictureSnippet.
	^ self visitContent: aLePictureSnippet
]

{ #category : #'private - writing' }
LeExportVisitor >> writeElementSnippet: aLeElementSnippet [
	| element objectSpecification |
	element := LeExportUtility newSnippetElementFor: aLeElementSnippet.
	objectSpecification := self objectSpecificationFor: element.
	
	^ objectSpecification resourcer
		resources: context resources;
		sequencer: context sequencer;
		fileStore: context fileStore;
		snippet: aLeElementSnippet;
		build;
		createdResources.
]

{ #category : #'private - writing' }
LeExportVisitor >> writePictureSnippet: aLePictureSnippet [ 
	| objectSpecification |
	objectSpecification := self objectSpecificationFor: aLePictureSnippet.
	
	^ objectSpecification resourcer
		resources: context resources;
		sequencer: context sequencer;
		fileStore: context fileStore;
		snippet: aLePictureSnippet;
		build;
		createdResources.
]
