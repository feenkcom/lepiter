Extension { #name : #LeExportVisitorExamples }

{ #category : #'*Lepiter-Snippet-Example' }
LeExportVisitorExamples >> exampleSnippetCodeWithPreview [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet context visitor resources |
	snippet := LeExportSnippetExamples new exampleSnippetCodeWithPreview.

	resources := LeExportResources new.

	context := LeExportContext new.
	context resources: resources.

	visitor := LeExportVisitor new context: context.

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertNotReadyResources: resources.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Example' }
LeExportVisitorExamples >> exampleSnippetCodeWithPreview_PrepareResources [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| holder context resources |
	holder := self exampleSnippetCodeWithPreview.
	context := holder context.
	resources := holder resources.

	context assembler assemble.

	self assertResources: resources size: 1.
	self assertReadyResources: resources.

	^ holder
]
