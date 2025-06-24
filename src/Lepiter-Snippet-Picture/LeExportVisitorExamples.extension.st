Extension { #name : #LeExportVisitorExamples }

{ #category : #'*Lepiter-Snippet-Picture' }
LeExportVisitorExamples >> pictureSnippetWithExistingFileReference [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithExistingFileReference.

	visitor := LeExportVisitor new
			context: (context := LeExportContext new resources: (resources := LeExportResources new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertReadyResources: resources.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeExportVisitorExamples >> pictureSnippetWithHttps [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithHttps.

	visitor := LeExportVisitor new
			context: (context := LeExportContext new resources: (resources := LeExportResources new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertReadyResources: resources.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeExportVisitorExamples >> pictureSnippetWithMissingFileReference [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithMissingFileReference.

	visitor := LeExportVisitor new
			context: (context := LeExportContext new resources: (resources := LeExportResources new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertNotReadyResources: resources.
	self assertFailedResources: resources.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeExportVisitorExamples >> pictureSnippetWithMissingFileReference_PrepareResources [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| resources context holder |
	holder := self pictureSnippetWithMissingFileReference.
	context := holder context.
	resources := context resources.

	context assembler assemble.

	self assertNotReadyResources: resources.

	^ holder
]
