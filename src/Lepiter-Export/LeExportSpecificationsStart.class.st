Class {
	#name : #LeExportSpecificationsStart,
	#superclass : #Object,
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #specifications }
LeExportSpecificationsStart >> elementSnippetElementSpecification [
	<leExportSpecification>
	^ LeExportForwardSpecification new
		classKind: LeElementSnippetElement;
		forwardTo: #displayElement;
		condition: #isNotNil
]

{ #category : #specifications }
LeExportSpecificationsStart >> elementSpecification [
	<leExportSpecification>
	^ LeExportClassKindSpecification new
		classKind: BlElement;
		resourcerClass: LeExportElementResourceBuilder
]

{ #category : #specifications }
LeExportSpecificationsStart >> presenterSlideShowElementSpecification [
	<leExportSpecification>
	^ LeExportClassKindSpecification new
		classKind: GtPresenterSlideShowElement;
		resourcerClass: LeExportPresenterSlideShowElementResourceBuilder
]

{ #category : #specifications }
LeExportSpecificationsStart >> snippetContainerElementSpecification [
	<leExportSpecification>
	^ LeExportForwardSpecification new
		classKind: LeSnippetContainerElement;
		forwardTo: #snippetElement;
		condition: #isNotNil
]
