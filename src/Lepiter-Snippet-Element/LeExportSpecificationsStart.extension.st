Extension { #name : #LeExportSpecificationsStart }

{ #category : #'*Lepiter-Snippet-Element' }
LeExportSpecificationsStart >> elementSnippetElementSpecification [
	<leExportSpecification>
	^ LeExportForwardSpecification new
		classKind: LeElementSnippetElement;
		forwardTo: #displayElement;
		condition: #isNotNil
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportSpecificationsStart >> presenterSlideShowElementSpecification [
	<leExportSpecification>
	^ LeExportClassKindSpecification new
		classKind: GtPresenterSlideShowElement;
		resourcerClass: LeExportPresenterSlideShowElementResourceBuilder
]
