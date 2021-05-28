"
I am an abstract class.
See ${class:LeWordExplanation}$.
"
Class {
	#name : #LeWordData,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'Lepiter-Snippet-Words-Model'
}

{ #category : #'gt-extensions' }
LeWordData >> gtRawDataFor: aView [
	<gtView>
	self rawData ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Raw Data';
		priority: 20;
		object: [ self rawData ];
		view: #gtItemsFor:
]

{ #category : #accessing }
LeWordData >> rawData [
	^ rawData
]

{ #category : #accessing }
LeWordData >> rawData: anObject [
	rawData := anObject
]
