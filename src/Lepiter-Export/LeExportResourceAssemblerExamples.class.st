Class {
	#name : #LeExportResourceAssemblerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Resources - Examples'
}

{ #category : #examples }
LeExportResourceAssemblerExamples >> snippetElementWithSlideshowSpecification [
	<gtExample>
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
