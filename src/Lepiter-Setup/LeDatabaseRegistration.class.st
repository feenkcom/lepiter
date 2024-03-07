Class {
	#name : #LeDatabaseRegistration,
	#superclass : #Object,
	#instVars : [
		'pragma',
		'showSelector',
		'path'
	],
	#category : #'Lepiter-Setup-Support'
}

{ #category : #accessing }
LeDatabaseRegistration >> directory [
	^ FileLocator gtResource withPath: path
]

{ #category : #'gt - extensions' }
LeDatabaseRegistration >> gtLiveFor: aView [
	<gtView>
	self path ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self directory ];
		view: self showSelector;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect object'
			action: [ :aButton | aButton phlow spawnObject: self object ]
]

{ #category : #'gt - extensions' }
LeDatabaseRegistration >> gtSourceCodeFor: aView [
	<gtView>
	self pragma ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Source Code';
		priority: 5;
		object: [ self pragma ];
		view: #gtSourceFor:
]

{ #category : #building }
LeDatabaseRegistration >> object [
	^ self objectBuilder cull: self pragma
]

{ #category : #accessing }
LeDatabaseRegistration >> path [
	^ path
]

{ #category : #accessing }
LeDatabaseRegistration >> path: anObject [
	path := anObject
]

{ #category : #accessing }
LeDatabaseRegistration >> pragma [

	^ pragma
]

{ #category : #accessing }
LeDatabaseRegistration >> pragma: anObject [

	pragma := anObject
]

{ #category : #accessing }
LeDatabaseRegistration >> showSelector [
	path ifNil: [ ^ #gtLiveFor: ].
	^ self directory exists
		ifTrue: [ #gtInspectLepiterDatabaseFor: ]
		ifFalse: [ #gtTreeFor: ]
]
