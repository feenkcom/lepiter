Class {
	#name : #LeExportSpecificationsStart,
	#superclass : #Object,
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #specifications }
LeExportSpecificationsStart >> elementSpecification [
	<leExportSpecification>
	^ LeExportClassKindSpecification new
		classKind: BlElement;
		resourcerClass: LeExportElementResourceBuilder
]

{ #category : #specifications }
LeExportSpecificationsStart >> snippetContainerElementSpecification [
	<leExportSpecification>
	^ LeExportForwardSpecification new
		classKind: LeSnippetContainerElement;
		forwardTo: #snippetElement;
		condition: #isNotNil
]
