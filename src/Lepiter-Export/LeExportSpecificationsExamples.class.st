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
				classKind: BlElement;
				resourcerClass: LeExportElementResourceBuilder).

	specifications
		addSpecification: (LeExportForwardSpecification new
				classKind: LeSnippetContainerElement;
				forwardTo: #snippetElement;
				condition: #isNotNil).

	specifications
		addSpecification: (LeExportForwardSpecification new
				classKind: LeElementSnippetElement;
				forwardTo: #displayElement;
				condition: #isNotNil).
				
	specifications
		addSpecification: (LeExportClassKindSpecification new
				classKind: GtPresenterSlideShowElement;
				resourcerClass: LeExportPresenterSlideShowElementResourceBuilder).
				
	specifications 
		addSpecification: (LeExportClassKindSpecification new
				classKind: LePictureSnippet;
				resourcerClass: LeExportPictureResourceBuilder).

	^ specifications
]
