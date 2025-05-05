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
	<return: #LeHtmlVisitorHolder>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithClassAnnotation.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: (context := LeHtmlContext new);
			snippet: snippet.

	html := visitor contentsFor: snippet.

	self assertHtml: html equals: 'BrButton'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlTextSnippetPostAbstractVisitorExamples >> textSnippetWithClassAnnotationLabeledAndText [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new
			textSnippetWithClassAnnotationLabeledAndText.

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
	<return: #LeHtmlVisitorHolder>
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

{ #category : #'examples - text snippet' }
LeHtmlTextSnippetPostAbstractVisitorExamples >> textSnippetWithExternalUrlLink [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithExternalUrlLink.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: (context := LeHtmlContext new);
			snippet: snippet.

	html := visitor contentsFor: snippet.

	self assertHtml: html equals: 'https://gtoolkit.com'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlTextSnippetPostAbstractVisitorExamples >> textSnippetWithMethodAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithMethodAnnotation.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: (context := LeHtmlContext new);
			snippet: snippet.

	html := visitor contentsFor: snippet.

	self assertHtml: html equals: 'BrButton'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlTextSnippetPostAbstractVisitorExamples >> textSnippetWithMethodAnnotationLabeled [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithMethodAnnotationLabeled.

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
LeHtmlTextSnippetPostAbstractVisitorExamples >> textSnippetWithPackageAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithPackageAnnotation.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: (context := LeHtmlContext new);
			snippet: snippet.

	html := visitor contentsFor: snippet.

	self assertHtml: html equals: BrButton package name asString.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlTextSnippetPostAbstractVisitorExamples >> textSnippetWithPackageAnnotationLabeled [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithPackageAnnotationLabeled.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: (context := LeHtmlContext new);
			snippet: snippet.

	html := visitor contentsFor: snippet.

	self assertHtml: html equals: 'Button package'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]
