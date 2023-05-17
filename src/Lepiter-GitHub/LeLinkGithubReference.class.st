Class {
	#name : #LeLinkGithubReference,
	#superclass : #LeLinkExternalReference,
	#instVars : [
		'userName',
		'projectName',
		'rawData'
	],
	#category : #'Lepiter-GitHub-Model'
}

{ #category : #communication }
LeLinkGithubReference >> download [
	^ Dictionary new
]

{ #category : #'gt-extensions' }
LeLinkGithubReference >> gtLiveFor: aView [
	<gtView>
	^ aView forward
		title: 'Raw data';
		priority: 20;
		object: [ self rawData ];
		view: #gtItemsFor:;
		actionButtonIcon: BrGlamorousVectorIcons browse
			label: 'GitHub'
			tooltip: 'Browse on GitHub'
			action: [ :aButton | self visitPage ]
]

{ #category : #printing }
LeLinkGithubReference >> printDetailsOn: aStream [
	aStream 
		nextPutAll: self userName asString;
		nextPut: $/;
		nextPutAll: self projectName asString
]

{ #category : #printing }
LeLinkGithubReference >> printOn: aStream [
	super printOn: aStream.
	aStream  nextPut: $(.
	self printDetailsOn: aStream.
	aStream  nextPut: $)
]

{ #category : #accessing }
LeLinkGithubReference >> projectName [
	^ projectName
]

{ #category : #accessing }
LeLinkGithubReference >> projectName: anObject [
	projectName := anObject
]

{ #category : #accessing }
LeLinkGithubReference >> rawData [
	^ rawData ifNil: [ rawData := self download ]
]

{ #category : #accessing }
LeLinkGithubReference >> urlString [
	^ String streamContents: [ :aStream |
		aStream 
			nextPutAll: 'https://github.com/';
			nextPutAll: self userName asString;
			nextPut: $/;
			nextPutAll: self projectName asString ]
]

{ #category : #accessing }
LeLinkGithubReference >> userName [
	^ userName
]

{ #category : #accessing }
LeLinkGithubReference >> userName: anObject [
	userName := anObject
]

{ #category : #communication }
LeLinkGithubReference >> visitPage [
	^ WebBrowser openOn: self urlString
]
