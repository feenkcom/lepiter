Class {
	#name : #LeGitHubSuccess,
	#superclass : #LeGitHubResponse,
	#category : 'Lepiter-GitHub-Model'
}

{ #category : #'api - accessing' }
LeGitHubSuccess >> atPath: anArray ifAbsent: anAbsentBlock [
	| aResult |
	anArray ifEmpty: [ ^ self rawData ].
	aResult := self rawData 
		at: anArray first
		ifAbsent: [ ^ anAbsentBlock value ].
	anArray allButFirstDo: [ :eachKey |
		aResult isDictionary ifFalse: [ ^ anAbsentBlock value ].
		aResult := aResult 
			at: eachKey
			ifAbsent: [ ^ anAbsentBlock value ] ].
	^ aResult
]

{ #category : #'api - testing' }
LeGitHubSuccess >> isSuccess [
	^ true
]
