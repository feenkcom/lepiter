Class {
	#name : #LeSnippetHolder,
	#superclass : #Object,
	#instVars : [
		'snippet',
		'temporaryDatabase'
	],
	#category : #'Lepiter-Core-Examples-Models'
}

{ #category : #'gt - extensions' }
LeSnippetHolder >> gtSnippetAttachmentsFor: aView [
	<gtView>
	^ aView forward
		title: 'Attachments';
		priority: 20;
		object: [ self snippet ];
		view: #gtSnippetAttachmentsFor:
]

{ #category : #'gt - extensions' }
LeSnippetHolder >> gtSnippetLiveFor: aView [
	<gtView>
	self snippet ifNil: [ ^ aView page ].
	self snippet class isAbstract ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self snippet ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeSnippetHolder >> snippet [
	^ snippet
]

{ #category : #accessing }
LeSnippetHolder >> snippet: anObject [
	snippet := anObject
]

{ #category : #accessing }
LeSnippetHolder >> temporaryDatabase [
	^ temporaryDatabase
]

{ #category : #accessing }
LeSnippetHolder >> temporaryDatabase: anObject [
	temporaryDatabase := anObject
]
