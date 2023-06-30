Class {
	#name : #LeTextualSnippetLink,
	#superclass : #LeTextualLink,
	#category : #'Lepiter-Core-Links'
}

{ #category : #visiting }
LeTextualSnippetLink >> acceptVisitor: aVisitor [

	^ aVisitor visitModel: self
]

{ #category : #'api - testing' }
LeTextualSnippetLink >> isTextualSnippetLink [
	^ true
]

{ #category : #accessing }
LeTextualSnippetLink >> printOn: aStream [
	self targetReference ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Snippet Link: ';
		print: self targetUID
]

{ #category : #'api - accessing' }
LeTextualSnippetLink >> targetSnippetUid [
	<return: #String>
	^ self targetReference snippetUid
]

{ #category : #'api - accessing' }
LeTextualSnippetLink >> targetSnippetUid: aString64 [
	self assert: [ aString64 notNil ].
	self assert: [ targetReference isNil ].
	
	targetReference := LeLinkSnippetUidReference 
		forSnippetUid: (LeUID new uidString: aString64).
	targetReference explicitLink: self
]

{ #category : #'api - accessing' }
LeTextualSnippetLink >> targetUID [
	^ self targetSnippetUid
]
