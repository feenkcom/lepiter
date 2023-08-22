Class {
	#name : #LeSnippetAttachmentsCollector,
	#superclass : #Object,
	#instVars : [
		'attachments',
		'iterator',
		'content'
	],
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #'double dispatch' }
LeSnippetAttachmentsCollector >> addSnippet: aSnippet attachmentNamed: aName [
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
LeSnippetAttachmentsCollector >> all [
	self iterator: LeSnippetAllAttachmentsIterator new
]

{ #category : #accessing }
LeSnippetAttachmentsCollector >> content [
	^ content
]

{ #category : #accessing }
LeSnippetAttachmentsCollector >> content: anObject [
	content := anObject
]

{ #category : #'api - enumerating' }
LeSnippetAttachmentsCollector >> get [
	attachments := OrderedCollection new.
	iterator snippet: content attachmentsInto: self.
	^ LeContentAttachments new 
		content: content;
		scope: iterator scope;
		items: attachments
]

{ #category : #initialization }
LeSnippetAttachmentsCollector >> initialize [
	super initialize.
	iterator := LeSnippetLocalAttachmentsIterator new.
]

{ #category : #'api - initialization' }
LeSnippetAttachmentsCollector >> iterator: anObject [
	iterator := anObject
]

{ #category : #'api - initialization' }
LeSnippetAttachmentsCollector >> local [
	self iterator: LeSnippetLocalAttachmentsIterator new
]
