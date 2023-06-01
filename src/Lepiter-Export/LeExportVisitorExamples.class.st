Class {
	#name : #LeExportVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #accessing }
LeExportVisitorExamples >> snippetElementWithSlideShowsSpecification [
	<gtExample>
	
	| specifications snippet context visitor result |
	specifications := LeExportSpecificationsExamples new snippetSpecifications.
	snippet := LeElementSnippet 
		code: GtPresenterSlideShow name, ' ', #create: asString, ' ', GtTour name, ' new'.
	context := LeExportContext new.
	context specifications: specifications.
	
	visitor := LeExportVisitor new 
		context: context.
		
	result := snippet acceptVisitor: visitor.

	^ visitor
]
