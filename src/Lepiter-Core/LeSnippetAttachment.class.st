Class {
	#name : #LeSnippetAttachment,
	#superclass : #Object,
	#instVars : [
		'name',
		'snippets'
	],
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #accessing }
LeSnippetAttachment >> database [
	<return: #LeDatabase>
	self
		assert: [ self snippets size isZero not ]
		description: [ 'Snippet attachment must have at least one snippet' ].

	^ self snippets anyOne database
]

{ #category : #accessing }
LeSnippetAttachment >> fileReference [
	^ self database resolveDbFile: self name
]

{ #category : #accessing }
LeSnippetAttachment >> name [
	^ name
]

{ #category : #accessing }
LeSnippetAttachment >> name: aString [
	name := aString
]

{ #category : #accessing }
LeSnippetAttachment >> printOn: aStream [
	super printOn: aStream.

	self name ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self name asString;
		nextPut: $)
]

{ #category : #accessing }
LeSnippetAttachment >> snippet: aSnippet [
	snippets := self snippets copyWith: aSnippet
]

{ #category : #accessing }
LeSnippetAttachment >> snippets [
	^ snippets ifNil: [ snippets := #() ]
]

{ #category : #accessing }
LeSnippetAttachment >> snippets: aCollection [
	snippets := aCollection
]
