Class {
	#name : #LeGitHubResponse,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'rawData'
	],
	#category : #'Lepiter-GitHub-Model'
}

{ #category : #'api - accessing' }
LeGitHubResponse >> atPath: anArray ifAbsent: anAbsentBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeGitHubResponse >> gtRawDataFor: aView [
	<gtView>
	self rawData ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Raw data';
		priority: 20;
		object: [ self rawData ];
		view: #gtItemsFor:
]

{ #category : #'api - testing' }
LeGitHubResponse >> isSuccess [
	^ false
]

{ #category : #'api - accessing' }
LeGitHubResponse >> message [
	<return: #String>
	^ ''
]

{ #category : #'api - accessing' }
LeGitHubResponse >> rawData [
	^ rawData
]

{ #category : #'api - accessing' }
LeGitHubResponse >> rawData: anObject [
	rawData := anObject
]
