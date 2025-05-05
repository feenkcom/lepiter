Extension { #name : #LeContentAttachmentsExample }

{ #category : #'*Lepiter-Snippet-Picture' }
LeContentAttachmentsExample >> databaseDefaultAttachments [
	"Get all attachments used in a given database must be a default behavior."

	<gtExample>
	<return: #LeContentAttachmentsHolder>
	| temporaryDatabase attachments attachmentOne attachmentTwo database |
	temporaryDatabase := LeModelExamples new
			databaseWithTwoPagesHavingPictureSnippets.
	database := temporaryDatabase database.

	attachments := database attachments get.

	self assert: attachments isNotNil.
	self assert: attachments size equals: 2.

	attachmentOne := attachments items
			detect: [ :each | each name endsWith: 'feenk.png' ].

	self assert: attachmentOne snippets size equals: 2.

	attachmentTwo := attachments items
			detect: [ :each | each name endsWith: 'gtoolkit.png' ].

	self assert: attachmentTwo snippets size equals: 2.

	^ LeContentAttachmentsHolder new
		attachments: attachments;
		content: database;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeContentAttachmentsExample >> pageOneAllAttachments [
	<gtExample>
	<return: #LeContentAttachmentsHolder>
	| pageHolder snippet attachments attachmentOne attachmentTwo page |
	pageHolder := LeModelExamples new pageOneWithTwoAttachmentPictures.
	page := pageHolder page.

	attachments := page attachments
			all;
			get.

	snippet := page children first.

	self assert: (snippet urlString endsWith: 'feenk.png').
	self assert: attachments isNotNil.
	self assert: attachments size equals: 2.

	attachmentOne := attachments items
			detect: [ :each | each name endsWith: 'feenk.png' ].

	self assert: attachmentOne snippets size equals: 2.
	self assert: attachmentOne snippets first == snippet.
	self
		assert: attachmentOne snippets second == snippet children first children first.

	attachmentTwo := attachments items
			detect: [ :each | each name endsWith: 'gtoolkit.png' ].

	self assert: attachmentTwo snippets size equals: 1.
	self assert: attachmentTwo snippets first == snippet children first.

	^ LeContentAttachmentsHolder new
		attachments: attachments;
		content: page;
		temporaryDatabase: pageHolder temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeContentAttachmentsExample >> pageOneDefaultAttachments [
	"Get all attachments used in a given page must be a default behavior."

	<gtExample>
	<return: #LeContentAttachmentsHolder>
	| pageHolder snippet attachments attachmentOne attachmentTwo page |
	pageHolder := LeModelExamples new pageOneWithTwoAttachmentPictures.
	page := pageHolder page.

	attachments := page attachments get.

	snippet := page children first.

	self assert: (snippet urlString endsWith: 'feenk.png').
	self assert: attachments isNotNil.
	self assert: attachments size equals: 2.

	attachmentOne := attachments items
			detect: [ :each | each name endsWith: 'feenk.png' ].

	self assert: attachmentOne snippets size equals: 2.
	self assert: attachmentOne snippets first == snippet.
	self
		assert: attachmentOne snippets second == snippet children first children first.

	attachmentTwo := attachments items
			detect: [ :each | each name endsWith: 'gtoolkit.png' ].

	self assert: attachmentTwo snippets size equals: 1.
	self assert: attachmentTwo snippets first == snippet children first.

	^ LeContentAttachmentsHolder new
		attachments: attachments;
		content: page;
		temporaryDatabase: pageHolder temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeContentAttachmentsExample >> pageTwoDefaultAttachments [
	"Get all attachments used in a given page should be a default behavior."

	<gtExample>
	<return: #LeContentAttachmentsHolder>
	| pageHolder snippet attachments attachmentOne page |
	pageHolder := LeModelExamples new pageTwoWithOneAttachmentPictures.
	page := pageHolder page.

	attachments := page attachments get.

	snippet := page children first.

	self assert: (snippet urlString endsWith: 'gtoolkit.png').
	self assert: attachments isNotNil.
	self assert: attachments size equals: 1.

	attachmentOne := attachments items
			detect: [ :each | each name endsWith: 'gtoolkit.png' ].

	self assert: attachmentOne snippets size equals: 1.
	self assert: attachmentOne snippets first == snippet.

	^ LeContentAttachmentsHolder new
		attachments: attachments;
		content: page;
		temporaryDatabase: pageHolder temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeContentAttachmentsExample >> pictureSnippetAllAttachments [
	<gtExample>
	<return: #LeContentAttachmentsHolder>
	| page snippet attachments attachmentOne attachmentTwo |
	page := LeModelExamples new pageOneWithTwoAttachmentPictures.
	snippet := page children first.

	self assert: (snippet urlString endsWith: 'feenk.png').

	attachments := snippet attachments
			all;
			get.

	self assert: attachments isNotNil.
	self assert: attachments size equals: 2.

	attachmentOne := attachments items
			detect: [ :each | each name endsWith: 'feenk.png' ].

	self assert: attachmentOne snippets size equals: 2.
	self assert: attachmentOne snippets first == snippet.
	self
		assert: attachmentOne snippets second == snippet children first children first.

	attachmentTwo := attachments items
			detect: [ :each | each name endsWith: 'gtoolkit.png' ].

	self assert: attachmentTwo snippets size equals: 1.
	self assert: attachmentTwo snippets first == snippet children first.

	^ LeContentAttachmentsHolder new
		attachments: attachments;
		content: snippet;
		temporaryDatabase: page temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeContentAttachmentsExample >> pictureSnippetLocalAttachments [
	<gtExample>
	<return: #LeContentAttachmentsHolder>
	| page snippet attachments attachmentOne |
	page := LeModelExamples new pageOneWithTwoAttachmentPictures.
	snippet := page children first.

	self assert: (snippet urlString endsWith: 'feenk.png').

	attachments := snippet attachments
			local;
			get.

	self assert: attachments isNotNil.
	self assert: attachments size equals: 1.

	attachmentOne := attachments items
			detect: [ :each | each name endsWith: 'feenk.png' ].

	self assert: attachmentOne snippets size equals: 1.
	self assert: attachmentOne snippets first == snippet.

	^ LeContentAttachmentsHolder new
		attachments: attachments;
		content: snippet;
		temporaryDatabase: page temporaryDatabase
]
