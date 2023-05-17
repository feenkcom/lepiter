Class {
	#name : #LeJupyterRawEntity,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'Lepiter-Translator-JupyterNotebook'
}

{ #category : #'gt-extensions' }
LeJupyterRawEntity >> gtRawDataFor: aView [
	<gtView>
	self rawData ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Raw data';
		priority: 20;
		object: [ self rawData ];
		view: #gtItemsFor:
]

{ #category : #accessing }
LeJupyterRawEntity >> rawData [
	^ rawData
]

{ #category : #accessing }
LeJupyterRawEntity >> rawData: anObject [
	rawData := anObject
]
