Class {
	#name : #LePageExampleHolder,
	#superclass : #Object,
	#instVars : [
		'page',
		'temporaryDatabase'
	],
	#category : #'Lepiter-Core-Examples-Models'
}

{ #category : #accessing }
LePageExampleHolder >> children [
	^ page children
]

{ #category : #accessing }
LePageExampleHolder >> database [
	^ page database
]

{ #category : #'gt - extensions' }
LePageExampleHolder >> gtPageLiveFor: aView [
	<gtView>
	self page ifNil: [ ^ aView page ].
	self page class isAbstract ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
LePageExampleHolder >> gtSnippetAttachmentsFor: aView [
	<gtView>
	^ aView forward
		title: 'Attachments';
		priority: 20;
		object: [ self page ];
		view: #gtSnippetAttachmentsFor:
]

{ #category : #'gt - extensions' }
LePageExampleHolder >> gtSnippetsFor: aView [
	<gtView>
	self page ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Snippets';
		priority: 10;
		object: [ self page ];
		view: #gtSnippetsFor:
]

{ #category : #accessing }
LePageExampleHolder >> page [
	^ page
]

{ #category : #accessing }
LePageExampleHolder >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LePageExampleHolder >> temporaryDatabase [
	^ temporaryDatabase
]

{ #category : #accessing }
LePageExampleHolder >> temporaryDatabase: anObject [
	temporaryDatabase := anObject
]
