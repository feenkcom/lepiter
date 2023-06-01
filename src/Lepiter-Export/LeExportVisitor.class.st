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

{ #category : #visiting }
LeExportVisitor >> visitElementSnippet: aLeElementSnippet [

	| element objectSpecification |
	element := LeExportUtility newSnippetElementFor: aLeElementSnippet.
	objectSpecification := self objectSpecificationFor: element.
	
	objectSpecification resourcer
		resources: context resources;
		sequencer: context sequencer;
		fileStore: context fileStore;
		snippet: aLeElementSnippet;
		build;
		createdResources.

	^ self visitContent: aLeElementSnippet
]
