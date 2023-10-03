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
LeSnippetAttachment >> basename [
	<return: #String>
	^ self fileReference basename
]

{ #category : #accessing }
LeSnippetAttachment >> contents [
	<return: #ByteArray>
	^ self fileReference binaryContents
]

{ #category : #accessing }
LeSnippetAttachment >> database [
	<return: #LeDatabase>
	self
		assert: [ self snippets size isZero not ]
		description: [ 'Snippet attachment must have at least one snippet' ].

	^ self snippets anyOne database
]

{ #category : #accessing }
LeSnippetAttachment >> delete [
	self fileReference parent ensureDeleteAll
]

{ #category : #accessing }
LeSnippetAttachment >> fileReference [
	^ self database resolveDbFile: self name
]

{ #category : #accessing }
LeSnippetAttachment >> gtSnippetsFor: aView [
	<gtView>
	
	^ aView columnedList title: 'Snippets'; tooltip: 'Snippets using this attachment';
	items: [ self snippets ];
	column: 'Index' text: [ :_ :anIndex | anIndex ] width: 40;
	column: 'Name' text: #contentAsString weight: 2;
	column: 'Page' text: [ :aSnippet | aSnippet page ifNotNil: #title ]
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

{ #category : #accessing }
LeSnippetAttachment >> uidString [
	<return: #String>
	| aSplit |
	aSplit := $/ split: (self name ifNil: [ '' ]).
	self
		assert: [ aSplit size = 3 ]
		description: [ 'Attachment name must have three parts divided by the slash (/) character: {1}'
				format: {self name} ].
	
	^ aSplit second
]
