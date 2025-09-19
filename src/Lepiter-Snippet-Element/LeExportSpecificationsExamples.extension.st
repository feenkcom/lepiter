Extension { #name : #LeExportSpecificationsExamples }

{ #category : #'*Lepiter-Snippet-Element' }
LeExportSpecificationsExamples >> snippetSpecifications [
	<gtExample>
	<return: #LeExportSpecifications>
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

	^ specifications
]
