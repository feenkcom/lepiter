Class {
	#name : #LeHtmlTextSnippetPostAbstractVisitorExamples,
	#superclass : #Object,
	#traits : 'TLeHtmlContentAssertions',
	#classTraits : 'TLeHtmlContentAssertions classTrait',
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #'examples - text snippet' }
LeHtmlTextSnippetPostAbstractVisitorExamples >> textSnippetWithClassAnnotation [
	<gtExample>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithClassAnnotation.
	
	visitor := LeHtmlTextSnippetPostAbstractVisitor new
		context: (context := LeHtmlContext new);
		snippet: snippet.
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html equals: 'Button'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlTextSnippetPostAbstractVisitorExamples >> textSnippetWithClassAnnotationAndText [
	<gtExample>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithClassAnnotationAndText.
	
	visitor := LeHtmlTextSnippetPostAbstractVisitor new
		context: (context := LeHtmlContext new);
		snippet: snippet.
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html equals: 'Button has very nice API.'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlTextSnippetPostAbstractVisitorExamples >> textSnippetWithExternalLabelUrlLink [
	<gtExample>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithExternalLabelUrlLink.
	
	visitor := LeHtmlTextSnippetPostAbstractVisitor new
		context: (context := LeHtmlContext new);
		snippet: snippet.
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html equals: 'GToolkit'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]
