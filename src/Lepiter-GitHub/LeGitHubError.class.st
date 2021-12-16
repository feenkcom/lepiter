Class {
	#name : #LeGitHubError,
	#superclass : #LeGitHubResponse,
	#instVars : [
		'exception'
	],
	#category : 'Lepiter-GitHub-Model'
}

{ #category : #'api - accessing' }
LeGitHubError >> atPath: anArray ifAbsent: anAbsentBlock [
	^ anAbsentBlock value
]

{ #category : #'api - accessing' }
LeGitHubError >> exception [
	^ exception
]

{ #category : #'api - accessing' }
LeGitHubError >> exception: anObject [
	exception := anObject
]

{ #category : #'api - accessing' }
LeGitHubError >> message [
	<return: #String>
	^ self exception ifNotNil: #messageText
]
