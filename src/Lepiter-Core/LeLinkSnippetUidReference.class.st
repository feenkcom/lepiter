Class {
	#name : #LeLinkSnippetUidReference,
	#superclass : #LeLinkContentReference,
	#instVars : [
		'snippetUid'
	],
	#category : 'Lepiter-Core-Links'
}

{ #category : #'instance creation' }
LeLinkSnippetUidReference class >> forSnippet: aLeSnippet [
	^ self forContent: aLeSnippet
]

{ #category : #'instance creation' }
LeLinkSnippetUidReference class >> forSnippetUid: aSnippetUid [
	^ self new
		snippetUid: aSnippetUid
]

{ #category : #accessing }
LeLinkSnippetUidReference >> content: aSnippet [
	self assert: [ snippetUid isNil ].
	
	self snippetUid: aSnippet uid.
	super content: aSnippet.
]

{ #category : #accessing }
LeLinkSnippetUidReference >> description [
	^ 'Snippet Reference: '
		,
			(self snippet
				ifNil: [ self snippetUid asString ]
				ifNotNil: [ :aSnippet | aSnippet contentAsString truncateTo: 20 ])
]

{ #category : #testing }
LeLinkSnippetUidReference >> isReferencingContent: aLeContent [ 
	self assert: [ aLeContent notNil ].
	
	^ (super isReferencingContent: aLeContent) and: [ 
			aLeContent isSnippet and: [
				aLeContent uid = self snippetUid ] ]
]

{ #category : #testing }
LeLinkSnippetUidReference >> isSnippetReference [
	^ true
]

{ #category : #printing }
LeLinkSnippetUidReference >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '(';
		print: self description;
		nextPutAll: ')'
]

{ #category : #actions }
LeLinkSnippetUidReference >> resolveInDatabase: aDatabase [
	self assert: [ self snippetUid notNil ].
	self assert: [ self content isNil ].
	
	aDatabase 
		blockWithUID: self snippetUid
		ifPresent: [ :aSnippet | 
			self basicContent: aSnippet ] 
		ifAbsent: [ self inform: 'Could not find snippet for uid ', self snippetUid asString ]
]

{ #category : #accessing }
LeLinkSnippetUidReference >> snippet [
	^ self content
]

{ #category : #accessing }
LeLinkSnippetUidReference >> snippetUid [
	^ snippetUid
]

{ #category : #accessing }
LeLinkSnippetUidReference >> snippetUid: anUid [
	self assert: [ anUid notNil ].
	self assert: [ snippetUid isNil ].
	self 
		assert: [ self snippet isNil ] 
		description: 'There should be not snippet when setting the uid'.
	
	snippetUid := anUid
]

{ #category : #accessing }
LeLinkSnippetUidReference >> targetId [
	^ self snippetUid
]
