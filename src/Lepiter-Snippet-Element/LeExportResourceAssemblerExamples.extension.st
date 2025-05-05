Extension { #name : #LeExportResourceAssemblerExamples }

{ #category : #'*Lepiter-Snippet-Element' }
LeExportResourceAssemblerExamples >> snippetElementWithSlideshowSpecification [
	<gtExample>
	<return: #LeExportResourcesAssembler>
	| resourcer resources assembler |
	resourcer := LeExportResourceBuilderExamples new
			snippetElementWithSlideshowSpecification.
	resources := resourcer resources.

	self
		assert: resources size > 0
		description: [ 'There must be at least one resource' ].

	assembler := LeExportResourcesAssembler new
			resources: resources;
			assemble.

	^ assembler
]
