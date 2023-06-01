Class {
	#name : #LeExportObjectSpecificationBuilderExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Specification - Examples'
}

{ #category : #'examples - specifications' }
LeExportObjectSpecificationBuilderExamples >> elementSpecification [
	<gtExample>
	
	| specifications builder element |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	element := BlElement new size: 100@200; background: Color orange.
	
	builder := LeExportObjectSpecificationBuilder new 
		specifications: specifications;
		object: element;
		build.
		
	self assert: builder specifications equals: specifications.
	self assert: builder object equals: element.
	

	^ builder
]

{ #category : #'examples - specifications' }
LeExportObjectSpecificationBuilderExamples >> specifications [
	<gtExample>
	
	| specifications |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	

	^ specifications
]
