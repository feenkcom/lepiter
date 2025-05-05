Class {
	#name : #LeExportVisitorExamples,
	#superclass : #Object,
	#traits : 'TLeExportResourceAssertions + TLeExportFileStoreAssertions + TLeExportLogAssertions',
	#classTraits : 'TLeExportResourceAssertions classTrait + TLeExportFileStoreAssertions classTrait + TLeExportLogAssertions classTrait',
	#category : #'Lepiter-Export-Examples'
}

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithClassAnnotation [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := LeExportSnippetExamples new textSnippetWithClassAnnotation.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 0.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithClassAnnotationCollapsed [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := LeExportSnippetExamples new textSnippetWithClassAnnotationCollapsed.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 0.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithClassAnnotationExpanded [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := LeExportSnippetExamples new textSnippetWithClassAnnotationExpanded.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 0.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithClassAnnotationLabeledAndText [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := LeExportSnippetExamples new
			textSnippetWithClassAnnotationLabeledAndText.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 0.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithExampleAnnotation [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore resource |
	snippet := LeExportSnippetExamples new textSnippetWithExampleAnnotation.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertNotReadyResources: resources.

	self assertFileStoreIsEmpty: fileStore.

	resource := resources asArray first.
	self
		assert: resource wantsCodeOutput
		description: [ 'Example annotation code output must be wanted' ].
	self
		assert: resource wantsPreviewOutput not
		description: [ 'Example annotation preview output must be NOT wanted' ].

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithExampleAnnotationWithLabel [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore resource |
	snippet := LeExportSnippetExamples new
			textSnippetWithExampleAnnotationWithLabel.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertNotReadyResources: resources.

	self assertFileStoreIsEmpty: fileStore.

	resource := resources asArray anyOne.
	self
		assert: resource wantsCodeOutput not
		description: [ 'Example annotation code output must be NOT wanted' ].
	self
		assert: resource wantsPreviewOutput not
		description: [ 'Example annotation preview output must be NOT wanted' ].

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithExampleAnnotationWithPreviewExpanded [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore resource |
	snippet := LeExportSnippetExamples new
			textSnippetWithExampleAnnotationWithPreviewExpanded.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertNotReadyResources: resources.

	self assertFileStoreIsEmpty: fileStore.

	resource := resources asArray first.
	self
		assert: resource wantsCodeOutput
		description: [ 'Example annotation code output must be wanted' ].
	self
		assert: resource wantsPreviewOutput
		description: [ 'Example annotation preview output must be wanted' ].

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithImageLinkWithAbsolutePath [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources context visitor fileStore |
	snippet := LeExportSnippetExamples new textSnippetWithImageLinkWithAbsolutePath.

	visitor := LeExportVisitor new
			context: (context := LeExportContext new
						resources: (resources := LeExportResources new);
						fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertReadyResources: resources.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithImageLinkWithRelativeAttachmentPath [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources context visitor fileStore |
	snippet := LeExportSnippetExamples new
			textSnippetWithImageLinkWithRelativeAttachmentPath.

	visitor := LeExportVisitor new
			context: (context := LeExportContext new
						resources: (resources := LeExportResources new);
						fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertReadyResources: resources.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithImageLinkWithRelativeAttachmentPathWithTwoSlashes [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources context visitor fileStore |
	snippet := LeExportSnippetExamples new
			textSnippetWithImageLinkWithRelativeAttachmentPathWithTwoSlashes.

	visitor := LeExportVisitor new
			context: (context := LeExportContext new
						resources: (resources := LeExportResources new);
						fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertReadyResources: resources.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithMethodAnnotation [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := LeExportSnippetExamples new textSnippetWithMethodAnnotation.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 0.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithMethodAnnotationCollapsed [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := LeExportSnippetExamples new textSnippetWithMethodAnnotationCollapsed.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 0.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithMethodAnnotationExpanded [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := LeExportSnippetExamples new textSnippetWithMethodAnnotationExpanded.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 0.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeExportVisitorExamples >> textSnippetWithWordAnnotation [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := LeExportSnippetExamples new textSnippetWithWordAnnotation.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 0.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]
