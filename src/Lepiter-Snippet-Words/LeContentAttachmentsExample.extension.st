Extension { #name : #LeContentAttachmentsExample }

{ #category : #'*Lepiter-Snippet-Words' }
LeContentAttachmentsExample >> wordSnippetAttachments [
	<gtExample>
	<return: #LeContentAttachmentsHolder>
	| page snippet attachments attachmentOne |
	page := LeModelExamples new pageThreeWithOneWordAttachment.
	snippet := page children first.

	attachments := snippet attachments
			local;
			get.

	self assert: attachments isNotNil.
	self assert: attachments size equals: 1.

	attachmentOne := attachments items
			detect: [ :each | each name endsWith: LeWordSnippet explanationAttachmentFileName ].

	self assert: attachmentOne snippets size equals: 1.
	self assert: attachmentOne snippets first == snippet.

	^ LeContentAttachmentsHolder new
		attachments: attachments;
		content: snippet;
		temporaryDatabase: page temporaryDatabase
]
