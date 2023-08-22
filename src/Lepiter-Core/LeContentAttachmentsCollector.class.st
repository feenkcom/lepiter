Class {
	#name : #LeContentAttachmentsCollector,
	#superclass : #Object,
	#instVars : [
		'attachments',
		'iterator',
		'content'
	],
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #'double dispatch' }
LeContentAttachmentsCollector >> addSnippet: aSnippet attachmentNamed: aName [
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
LeContentAttachmentsCollector >> all [
	self iterator: LeContentAllAttachmentsIterator new
]

{ #category : #accessing }
LeContentAttachmentsCollector >> content [
	^ content
]

{ #category : #accessing }
LeContentAttachmentsCollector >> content: anObject [
	content := anObject
]

{ #category : #'api - enumerating' }
LeContentAttachmentsCollector >> get [
	attachments := OrderedCollection new.
	iterator content: content attachmentsInto: self.
	^ LeContentAttachments new 
		content: content;
		scope: iterator scope;
		items: attachments
]

{ #category : #initialization }
LeContentAttachmentsCollector >> initialize [
	super initialize.
	iterator := LeContentLocalAttachmentsIterator new.
]

{ #category : #'api - initialization' }
LeContentAttachmentsCollector >> iterator: anObject [
	iterator := anObject
]

{ #category : #'api - initialization' }
LeContentAttachmentsCollector >> local [
	self iterator: LeContentLocalAttachmentsIterator new
]
