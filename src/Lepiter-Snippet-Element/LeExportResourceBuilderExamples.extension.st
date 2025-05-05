Extension { #name : #LeExportResourceBuilderExamples }

{ #category : #'*Lepiter-Snippet-Element' }
LeExportResourceBuilderExamples >> snippetElementWithSlideshowSpecification [
	<gtExample>
	<return: #LeExportPresenterSlideShowElementResourceBuilder>
	| finder element snippet resourcer objectSpecification resources sequencer fileStore createdResources |
	finder := LeExportObjectSpecificationBuilderExamples new
			snippetElementWithSlideshowSpecification.

	objectSpecification := finder objectSpecification.
	element := objectSpecification object.
	snippet := element snippetViewModel snippetModel.

	resources := LeExportResources new.
	sequencer := LeExportIntegerSequencer new.
	fileStore := LeExportMemoryStore new.

	resourcer := objectSpecification resourcer
			resources: resources;
			sequencer: sequencer;
			fileStore: fileStore;
			snippet: snippet;
			build.

	createdResources := resourcer createdResources resources.

	self
		assert: resourcer allSlides isNotNil
		description: [ 'All slides must be non-nil' ].
	self
		assert: resourcer allSlides size > 1
		description: [ 'All slides must be bigger than one' ].
	self assert: createdResources size equals: resourcer allSlides size.

	^ resourcer
]
