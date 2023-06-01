Class {
	#name : #LeExportVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #accessing }
LeExportVisitorExamples >> snippetElementWithSlideshowSpecification [
	<gtExample>
	| specifications snippet context visitor result resources allSlides slidesHolder |
	slidesHolder := LeExportSnippetExamples new snippetElementWithSlideshow.
	snippet := slidesHolder snippet.
	allSlides := slidesHolder allSlides.

	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	resources := LeExportResources new.

	context := LeExportContext new.
	context specifications: specifications.
	context resources: resources.

	visitor := LeExportVisitor new context: context.

	result := snippet acceptVisitor: visitor.

	self assert: resources asArray size equals: allSlides size.
	self 
		assert: (resources asArray allSatisfy: [ :each | each state isReady not ])
		description: [ 'Resource must NOT be ready.' ].

	^ visitor
]

{ #category : #accessing }
LeExportVisitorExamples >> snippetElementWithSlideshowSpecification_PrepareResources [
	<gtExample>
	| resources visitor context |
	visitor := self snippetElementWithSlideshowSpecification.
	context := visitor context.
	resources := context resources.
	
	context assembler assemble.

	self 
		assert: resources asArray size > 1
		description: [ 'Slide show must have more than one slide' ].
	self 
		assert: (resources asArray allSatisfy: [ :each | each state isReady ])
		description: [ 'Resource must be ready.' ].

	^ visitor
]
