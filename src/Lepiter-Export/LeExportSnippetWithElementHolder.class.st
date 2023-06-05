Class {
	#name : #LeExportSnippetWithElementHolder,
	#superclass : #Object,
	#instVars : [
		'snippet',
		'element'
	],
	#category : #'Lepiter-Export-Examples'
}

{ #category : #accessing }
LeExportSnippetWithElementHolder >> element [
	^ element
]

{ #category : #accessing }
LeExportSnippetWithElementHolder >> element: anObject [
	element := anObject
]

{ #category : #'gt - extensions' }
LeExportSnippetWithElementHolder >> gtElementFor: aView [
	<gtView>
	element ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Element';
		priority: 20;
		object: [ element ];
		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
LeExportSnippetWithElementHolder >> gtSnippetFor: aView [
	<gtView>
	snippet ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Snippet';
		priority: 20;
		object: [ snippet ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeExportSnippetWithElementHolder >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportSnippetWithElementHolder >> snippet: anObject [
	snippet := anObject
]
