Class {
	#name : #LeExportVisitorExamples,
	#superclass : #Object,
	#traits : 'TLeExportResourceAssertions',
	#classTraits : 'TLeExportResourceAssertions classTrait',
	#category : #'Lepiter-Export-Examples'
}

{ #category : #accessing }
LeExportVisitorExamples >> elementSnippetWithZeroSlides [
	<gtExample>
	| specifications snippet context visitor resources allSlides slidesHolder |
	slidesHolder := LeExportSnippetExamples new elementSnippetWithZeroSlides.
	snippet := slidesHolder snippet.
	allSlides := slidesHolder allSlides.
	
	self 
		assert: allSlides isEmpty 
		description: [ 'All slides must be empty' ].

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

	^ visitor
]

{ #category : #accessing }
LeExportVisitorExamples >> pictureSnippetWithExistingFileReference [
	<gtExample>
	| snippet resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithExistingFileReference.
	
	visitor := LeExportVisitor new
			context: (context := LeExportContext new
				resources: (resources := LeExportResources new)).
	
	snippet acceptVisitor: visitor.
	
	self assertResources: resources size: 1.
	self assertReadyResources: resources.
	
	^ visitor
]

{ #category : #accessing }
LeExportVisitorExamples >> pictureSnippetWithHttps [
	<gtExample>
	| snippet resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithHttps.
	
	visitor := LeExportVisitor new
			context: (context := LeExportContext new
				resources: (resources := LeExportResources new)).
	
	snippet acceptVisitor: visitor.
	
	self assertResources: resources size: 0.

	^ visitor
]

{ #category : #accessing }
LeExportVisitorExamples >> pictureSnippetWithMissingFileReference [
	<gtExample>
	| snippet resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithMissingFileReference.
	
	visitor := LeExportVisitor new
			context: (context := LeExportContext new
				resources: (resources := LeExportResources new)).
	
	snippet acceptVisitor: visitor.
	
	self assertResources: resources size: 1.
	self assertFailedResources: resources.
	
	^ visitor
]

{ #category : #accessing }
LeExportVisitorExamples >> snippetElementWithSlideshowSpecification [
	<gtExample>
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

{ #category : #accessing }
LeExportVisitorExamples >> snippetElementWithZeroSlides_PrepareResources [
	<gtExample>
	| resources visitor context |
	visitor := self elementSnippetWithZeroSlides.
	context := visitor context.
	resources := context resources.
	
	context assembler assemble.

	self 
		assert: resources asArray size
		equals: 1.
	self 
		assert: (resources asArray allSatisfy: [ :each | each state isReady ])
		description: [ 'Resource must be ready.' ].
	self 
		assert: resources asArray first state isFailure 
		description: [ 'Resource must have inadequate output (an exception)' ].

	^ visitor
]
