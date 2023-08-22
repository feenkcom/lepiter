Class {
	#name : #LeSnippetAttachmentsExample,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Attachments'
}

{ #category : #accessing }
LeSnippetAttachmentsExample >> pageAllAttachments [
	<gtExample>
	| page snippet attachments attachmentOne attachmentTwo |
	page := LeModelExamples new pageWithTwoAttachmentPictures.
	
	attachments := page attachments all; get.
	
	snippet := page children first.

	self assert: (snippet urlString endsWith: 'feenk.png').
	self assert: attachments isNotNil.
	self assert: attachments size equals: 2.
	
	attachmentOne := attachments detect: [ :each | each name endsWith: 'feenk.png' ].
	
	self assert: attachmentOne snippets size equals: 2.
	self assert: attachmentOne snippets first == snippet.
	self assert: attachmentOne snippets second == snippet children first children first.

	attachmentTwo := attachments detect: [ :each | each name endsWith: 'gtoolkit.png' ].
	
	self assert: attachmentTwo snippets size equals: 1.
	self assert: attachmentTwo snippets first == snippet children first.

	^ LeSnippetHolder new
		snippet: snippet;
		temporaryDatabase: page temporaryDatabase
]

{ #category : #accessing }
LeSnippetAttachmentsExample >> pictureSnippetAllAttachments [
	<gtExample>
	| page snippet attachments attachmentOne attachmentTwo |
	page := LeModelExamples new pageWithTwoAttachmentPictures.
	snippet := page children first.

	self assert: (snippet urlString endsWith: 'feenk.png').
	
	attachments := snippet attachments all; get.
	
	self assert: attachments isNotNil.
	self assert: attachments size equals: 2.
	
	attachmentOne := attachments detect: [ :each | each name endsWith: 'feenk.png' ].
	
	self assert: attachmentOne snippets size equals: 2.
	self assert: attachmentOne snippets first == snippet.
	self assert: attachmentOne snippets second == snippet children first children first.

	attachmentTwo := attachments detect: [ :each | each name endsWith: 'gtoolkit.png' ].
	
	self assert: attachmentTwo snippets size equals: 1.
	self assert: attachmentTwo snippets first == snippet children first.

	^ LeSnippetHolder new
		snippet: snippet;
		temporaryDatabase: page temporaryDatabase
]

{ #category : #accessing }
LeSnippetAttachmentsExample >> pictureSnippetLocalAttachments [
	<gtExample>
	| page snippet attachments attachmentOne |
	page := LeModelExamples new pageWithTwoAttachmentPictures.
	snippet := page children first.

	self assert: (snippet urlString endsWith: 'feenk.png').
	
	attachments := snippet attachments local; get.
	
	self assert: attachments isNotNil.
	self assert: attachments size equals: 1.
	
	attachmentOne := attachments detect: [ :each | each name endsWith: 'feenk.png' ].
	
	self assert: attachmentOne snippets size equals: 1.
	self assert: attachmentOne snippets first == snippet.
	
	^ LeSnippetHolder new
		snippet: snippet;
		temporaryDatabase: page temporaryDatabase
]
