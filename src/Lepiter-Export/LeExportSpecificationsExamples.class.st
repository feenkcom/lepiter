Class {
	#name : #LeExportSpecificationsExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Specification - Examples'
}

{ #category : #examples }
LeExportSpecificationsExamples >> snippetSpecifications [
	<gtExample>
	| specifications |
	specifications := LeExportSpecifications new.
	
	specifications
		addSpecification: (LeExportClassKindSpecification new
				classKind: BlElement).

	specifications
		addSpecification: (LeExportForwardSpecification new
				classKind: LeSnippetContainerElement;
				forwardTo: #snippetElement).

	specifications
		addSpecification: (LeExportForwardSpecification new
				classKind: LeElementSnippetElement;
				forwardTo: #displayElement).
				
	specifications
		addSpecification: (LeExportClassKindSpecification new
				classKind: GtPresenterSlideShowElement;
				resourcerClass: LeExportPresenterSlideShowElementResourceBuilder).

	^ specifications
]
