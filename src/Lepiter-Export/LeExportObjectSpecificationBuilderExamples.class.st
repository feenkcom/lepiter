Class {
	#name : #LeExportObjectSpecificationBuilderExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Specification - Examples'
}

{ #category : #accessing }
LeExportObjectSpecificationBuilderExamples >> elementSpecification [
	<gtExample>
	
	| specifications finder element |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	element := BlElement new size: 100@200; background: Color orange.
	
	finder := LeExportObjectSpecificationBuilder new 
		specifications: specifications;
		object: element;
		find.
		
	self assert: finder specifications equals: specifications.
	self assert: finder object equals: element.
	
	self assert: finder objectSpecification isNotNil.
	self assert: finder objectSpecification specification classKind equals: BlElement.

	^ finder
]

{ #category : #accessing }
LeExportObjectSpecificationBuilderExamples >> presenterSlideShowSpecification [
	<gtExample>
	
	| specifications finder element elementClass |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	element := (GtPresenterSlideShow create: GtTour new) asElement.
	
	elementClass := element class.
	
	finder := LeExportObjectSpecificationBuilder new 
		specifications: specifications;
		object: element;
		find.
		
	self assert: finder specifications equals: specifications.
	self assert: finder object equals: element.
	
	self assert: finder objectSpecification isNotNil.
	self assert: finder objectSpecification specification classKind equals: elementClass.

	^ finder
]

{ #category : #accessing }
LeExportObjectSpecificationBuilderExamples >> snippetElementWithSlideShowsSpecification [
	<gtExample>
	
	| specifications finder element elementClass snippet |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	snippet := LeElementSnippet 
		code: GtPresenterSlideShow name, ' ', #create: asString, ' ', GtTour name, ' new'.
	
	element := LeExportUtility newSnippetElementFor: snippet.
	elementClass := element class.
	
	finder := LeExportObjectSpecificationBuilder new 
		specifications: specifications;
		object: element;
		find.
		
	self assert: finder specifications equals: specifications.
	self assert: finder object equals: element.
	
	self assert: finder objectSpecification isNotNil.
	self assert: finder objectSpecification specification classKind equals: elementClass.
	self assert: finder objectSpecification priority equals: 0.
	self assert: finder objectSpecification allObjectSpecifications size equals: 3.

	^ finder
]
