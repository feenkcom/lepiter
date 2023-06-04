Class {
	#name : #LeExportVisitorHolder,
	#superclass : #Object,
	#instVars : [
		'visitor',
		'snippet'
	],
	#category : #'Lepiter-Export-Examples'
}

{ #category : #accessing }
LeExportVisitorHolder >> context [
	^ visitor context
]

{ #category : #accessing }
LeExportVisitorHolder >> fileStore [
	^ visitor context fileStore
]

{ #category : #'gt - extensions' }
LeExportVisitorHolder >> gtFilesFor: aView [
	<gtView>
	visitor ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 20;
		object: [ visitor ];
		view: #gtFilesFor:
]

{ #category : #'gt - extensions' }
LeExportVisitorHolder >> gtLogFor: aView [
	<gtView>
	visitor ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Log';
		priority: 20;
		object: [ visitor ];
		view: #gtLogFor:
]

{ #category : #'gt - extensions' }
LeExportVisitorHolder >> gtResourcesFor: aView [
	<gtView>
	visitor ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ visitor ];
		view: #gtResourcesFor:
]

{ #category : #'gt - extensions' }
LeExportVisitorHolder >> gtSnippetFor: aView [
	<gtView>
	snippet ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Snippet';
		priority: 30;
		object: [ snippet ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeExportVisitorHolder >> log [
	^ visitor context log
]

{ #category : #accessing }
LeExportVisitorHolder >> resources [
	^ visitor context resources
]

{ #category : #accessing }
LeExportVisitorHolder >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportVisitorHolder >> snippet: anObject [
	snippet := anObject
]

{ #category : #accessing }
LeExportVisitorHolder >> visitor [
	^ visitor
]

{ #category : #accessing }
LeExportVisitorHolder >> visitor: aVisitor [
	visitor := aVisitor
]
