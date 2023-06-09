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

{ #category : #'private - exporting' }
LeExportVisitor >> addResource: aResource [
	context resources addResource: aResource
]

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
LeExportVisitor >> gtLogFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Log';
		priority: 20;
		object: [ context ];
		view: #gtLogFor:
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
LeExportVisitor >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ context fileStore nextFileReferenceTo: aRelativePath
]

{ #category : #'private - exporting' }
LeExportVisitor >> nextPath [
	<return: #RelativePath>
	^ self nextPathWithExtension: LepiterConstants exportedResultsExtension
]

{ #category : #'private - exporting' }
LeExportVisitor >> nextPathWithExtension: anExtension [
	<return: #RelativePath>
	^ LepiterConstants exportedResultsDirectoryPath / self nextSequence asString
		withExtension: anExtension
]

{ #category : #'private - exporting' }
LeExportVisitor >> nextSequence [
	<return: #String>
	^ context sequencer nextId
]

{ #category : #'private - exporting' }
LeExportVisitor >> objectSpecificationFor: anObject [
	<return: #TLeExportObjectSpecification>
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
	
	^ self visitSnippet: aLeElementSnippet
]

{ #category : #visiting }
LeExportVisitor >> visitPictureSnippet: aLePictureSnippet [

	LeExportPictureResourceBuilder new
		resources: context resources;
		sequencer: context sequencer;
		fileStore: context fileStore;
		snippet: aLePictureSnippet;
		build.
	
	^ self visitSnippet: aLePictureSnippet
]

{ #category : #visiting }
LeExportVisitor >> visitTextSnippet: aLeTextSnippet [
	| visitor |
	visitor := LeExportTextSnippetVisitor new
		context: context;
		snippet: aLeTextSnippet.
	
	aLeTextSnippet ast acceptVisitor: visitor.

	^ self visitTextualSnippet: aLeTextSnippet
]
