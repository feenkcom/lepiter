Extension { #name : #LeExportVisitorExamples }

{ #category : #'*Lepiter-Snippet-Element' }
LeExportVisitorExamples >> elementSnippetWithGlamorousBreadcrumb [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor holder fileStore |
	holder := LeExportSnippetExamples new elementSnippetWithGlamorousBreadcrumb.
	snippet := holder snippet.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertNotReadyResources: resources.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportVisitorExamples >> elementSnippetWithGlamorousBreadcrumb_AssembleResources [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| resources holder context |
	holder := self elementSnippetWithGlamorousBreadcrumb.
	context := holder context.
	resources := holder resources.

	context assembler assemble.

	self assertReadyResources: resources.
	self assertFileStoreIsNotEmpty: holder fileStore.

	^ holder
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportVisitorExamples >> elementSnippetWithInexistentMethod [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := LeExportSnippetExamples new elementSnippetWithInexistentMethod.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 1.
	self assertNotReadyResources: resources.

	self assertFileStoreIsEmpty: fileStore.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportVisitorExamples >> elementSnippetWithInexistentMethod_AssembleResources [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| resources holder context |
	holder := self elementSnippetWithInexistentMethod.
	context := holder context.
	resources := holder resources.

	context assembler assemble.

	self assertReadyResources: resources.
	self assertFileStoreIsNotEmpty: holder fileStore.

	^ holder
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportVisitorExamples >> elementSnippetWithSlideshow [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| specifications snippet context visitor resources allSlides slidesHolder |
	slidesHolder := LeExportSnippetExamples new elementSnippetWithSlideshow.
	snippet := slidesHolder snippet.
	allSlides := slidesHolder allSlides.

	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	resources := LeExportResources new.

	context := LeExportContext new.
	context specifications: specifications.
	context resources: resources.

	visitor := LeExportVisitor new context: context.

	snippet acceptVisitor: visitor.

	self assertResources: resources size: allSlides size.
	self assertNotReadyResources: resources.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportVisitorExamples >> elementSnippetWithSlideshow_PrepareResources [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| resources context holder |
	holder := self elementSnippetWithSlideshow.
	context := holder context.
	resources := context resources.

	context assembler assemble.

	self assertReadyResources: resources.

	^ holder
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportVisitorExamples >> elementSnippetWithZeroSlides [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| specifications snippet context visitor resources allSlides slidesHolder |
	slidesHolder := LeExportSnippetExamples new elementSnippetWithZeroSlides.
	snippet := slidesHolder snippet.
	allSlides := slidesHolder allSlides.

	self assert: allSlides isEmpty description: [ 'All slides must be empty' ].

	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	resources := LeExportResources new.

	context := LeExportContext new.
	context specifications: specifications.
	context resources: resources.

	visitor := LeExportVisitor new context: context.

	snippet acceptVisitor: visitor.

	self assert: resources asArray size equals: 1.
	self
		assert: (resources asArray allSatisfy: [ :each | each state isReady not ])
		description: [ 'Resource must NOT be ready.' ].

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportVisitorExamples >> snippetElementWithZeroSlides_PrepareResources [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| resources visitor context |
	visitor := self elementSnippetWithZeroSlides.
	context := visitor context.
	resources := context resources.

	context assembler assemble.

	self assert: resources asArray size equals: 1.
	self
		assert: (resources asArray allSatisfy: [ :each | each state isReady ])
		description: [ 'Resource must be ready.' ].
	self
		assert: resources asArray first state isFailure
		description: [ 'Resource must have inadequate output (an exception)' ].

	^ visitor
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportVisitorExamples >> unsupportedSnippet [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor holder fileStore log |
	holder := LeExportSnippetExamples new elementSnippetWithGlamorousBreadcrumb.
	snippet := holder snippet.
	visitor := LeExportIncompleteVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new);
					log: (log := LeExportLog new)).

	snippet acceptVisitor: visitor.

	self assertResources: resources size: 0.
	self assertFileStoreIsEmpty: fileStore.	"Export visitor do not care about unsupported snippets.
	It is expected that most snippets do not generate resources."
	self assertLog: log size: 0.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet
]
