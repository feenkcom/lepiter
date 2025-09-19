Extension { #name : #LeExportObjectSpecificationBuilderExamples }

{ #category : #'*Lepiter-Snippet-Element' }
LeExportObjectSpecificationBuilderExamples >> elementSpecification [
	<gtExample>
	<return: #LeExportObjectSpecificationBuilder>
	| specifications finder element |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	element := BlElement new
			size: 100 @ 200;
			background: Color orange.

	finder := LeExportObjectSpecificationBuilder new
			specifications: specifications;
			object: element;
			find.

	self assert: finder specifications equals: specifications.
	self assert: finder object equals: element.

	self assert: finder objectSpecification isNotNil.
	self
		assert: finder objectSpecification specification classKind
		equals: BlElement.

	^ finder
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportObjectSpecificationBuilderExamples >> presenterSlideshowSpecification [
	<gtExample>
	<return: #LeExportObjectSpecificationBuilder>
	| specifications finder element elementClass holder |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	holder := LeExportSnippetExamples new elementSnippetWithSlideshow.
	element := holder slideshow asElement.

	elementClass := element class.

	finder := LeExportObjectSpecificationBuilder new
			specifications: specifications;
			object: element;
			find.

	self assert: finder specifications equals: specifications.
	self assert: finder object equals: element.

	self assert: finder objectSpecification isNotNil.
	self
		assert: finder objectSpecification specification classKind
		equals: elementClass.

	^ finder
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportObjectSpecificationBuilderExamples >> snippetElementWithSlideshowSpecification [
	<gtExample>
	<return: #LeExportObjectSpecificationBuilder>
	| specifications finder element elementClass snippet holder |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.

	holder := LeExportSnippetExamples new elementSnippetWithSlideshow.
	snippet := holder snippet.
	element := LeExportUtility newSnippetElementFor: snippet.
	elementClass := element class.

	finder := LeExportObjectSpecificationBuilder new
			specifications: specifications;
			object: element;
			find.

	self assert: finder specifications equals: specifications.
	self assert: finder object equals: element.

	self assert: finder objectSpecification isNotNil.
	self
		assert: finder objectSpecification specification classKind
		equals: elementClass.
	self assert: finder objectSpecification priority equals: 0.
	self assert: finder objectSpecification allObjectSpecifications size equals: 3.

	^ finder
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportObjectSpecificationBuilderExamples >> snippetElementWithZeroSlidesSpecification [
	<gtExample>
	<return: #LeExportObjectSpecificationBuilder>
	| specifications finder element elementClass snippet holder |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.

	holder := LeExportSnippetExamples new elementSnippetWithZeroSlides.
	snippet := holder snippet.
	element := LeExportUtility newSnippetElementFor: snippet.
	elementClass := element class.

	finder := LeExportObjectSpecificationBuilder new
			specifications: specifications;
			object: element;
			find.

	self assert: finder specifications equals: specifications.
	self assert: finder object equals: element.

	self assert: finder objectSpecification isNotNil.
	self
		assert: finder objectSpecification specification classKind = BlElement
		description: [ 'Unexpected specification: {1}'
				format: {finder objectSpecification specification} ].
	self assert: finder objectSpecification priority equals: 1.

	^ finder
]
