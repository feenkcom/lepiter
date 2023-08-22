Class {
	#name : #LeSnippetAttachments,
	#superclass : #Object,
	#instVars : [
		'snippet',
		'attachments',
		'iterator'
	],
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #'double dispatch' }
LeSnippetAttachments >> addSnippet: aSnippet attachmentNamed: aName [
	attachments
		detect: [ :each | each name = aName ]
		ifFound: [ :aSnippetAttachment | aSnippetAttachment snippet: aSnippet ]
		ifNone: [ 
			| anAttachment |
			anAttachment := LeSnippetAttachment new
				snippet: aSnippet;
				name: aName.
			attachments add: anAttachment ]
]

{ #category : #'api - initialization' }
LeSnippetAttachments >> all [
	self iterator: LeSnippetAllAttachmentsIterator new
]

{ #category : #'api - enumerating' }
LeSnippetAttachments >> get [
	attachments := OrderedCollection new.
	iterator snippet: snippet attachmentsInto: self.
	^ attachments
]

{ #category : #initialization }
LeSnippetAttachments >> initialize [
	super initialize.
	iterator := LeSnippetLocalAttachmentsIterator new.
]

{ #category : #'api - initialization' }
LeSnippetAttachments >> iterator: anObject [
	iterator := anObject
]

{ #category : #'api - initialization' }
LeSnippetAttachments >> local [
	self iterator: LeSnippetLocalAttachmentsIterator new
]

{ #category : #accessing }
LeSnippetAttachments >> snippet [
	^ snippet
]

{ #category : #accessing }
LeSnippetAttachments >> snippet: anObject [
	snippet := anObject
]
