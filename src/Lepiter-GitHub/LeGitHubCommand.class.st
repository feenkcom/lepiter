Class {
	#name : #LeGitHubCommand,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'userName',
		'projectName'
	],
	#category : 'Lepiter-GitHub-Client'
}

{ #category : #communication }
LeGitHubCommand >> download [
	^ Dictionary new
]

{ #category : #'api - execution' }
LeGitHubCommand >> execute [
	<return: #LeGitHubResponse>
	^ [ 
		LeGitHubSuccess new rawData: self download.
	] on: IceGitHubError, IceAuthenticationError do: [ :anException | 
		LeGitHubError new exception: anException ]
]

{ #category : #'api - accessing' }
LeGitHubCommand >> projectName [
	^ projectName
]

{ #category : #'api - accessing' }
LeGitHubCommand >> projectName: anObject [
	projectName := anObject
]

{ #category : #'api - accessing' }
LeGitHubCommand >> userName [
	^ userName
]

{ #category : #'api - accessing' }
LeGitHubCommand >> userName: anObject [
	userName := anObject
]
