Class {
	#name : #LeTextualSnippetLink,
	#superclass : #LeTextualLink,
	#category : #'Lepiter-Core-Links'
}

{ #category : #'api - testing' }
LeTextualSnippetLink >> isTextualSnippetLink [
	^ true
]

{ #category : #accessing }
LeTextualSnippetLink >> printOn: aStream [
	self targetReference ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Snippet Link: ';
		nextPutAll: self targetUID
]

{ #category : #'api - accessing' }
LeTextualSnippetLink >> targetSnippetUid [
	<return: #String>
	^ self targetReference snippetUid uid
]

{ #category : #'api - accessing' }
LeTextualSnippetLink >> targetSnippetUid: aString [
	self assert: [ aString notNil ].
	self assert: [ targetReference isNil ].
	
	targetReference := LeLinkSnippetUidReference 
		forSnippetUid: (LeUID new uid: aString).
	targetReference explicitLink: self
]

{ #category : #'api - accessing' }
LeTextualSnippetLink >> targetUID [
	^ self targetSnippetUid
]
