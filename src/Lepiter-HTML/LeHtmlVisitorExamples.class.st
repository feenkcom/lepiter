Class {
	#name : #LeHtmlVisitorExamples,
	#superclass : #Object,
	#traits : 'TLeExportResourceAssertions + TLeHtmlContentAssertions + TLeExportLogAssertions',
	#classTraits : 'TLeExportResourceAssertions classTrait + TLeHtmlContentAssertions classTrait + TLeExportLogAssertions classTrait',
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> textSnippetWithExampleAnnotation [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithExampleAnnotation.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html includes: ' <div class="snippet textual-snippet code-snippet pharo-snippet documentWidth">'.
	self assertHtml: html includes: 'BrExamplesShowroom>>#glamorousLargeButton'.
	self assertHtml: html includes: BrExamplesShowroom name.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> textSnippetWithExampleAnnotationWithLabel [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithExampleAnnotationWithLabel.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '<div class="snippet textual-snippet text-snippet">'.
	self assertHtml: html includes: '<code class="example_inlined">'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> textSnippetWithExampleAnnotationWithPreviewExpanded [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithExampleAnnotationWithPreviewExpanded.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html includes: '<div class="snippet textual-snippet code-snippet pharo-snippet documentWidth">'.
	self assertHtml: html includes: 'BrExamplesShowroom>>#glamorousLargeButton'.
	self assertHtml: html includes: BrExamplesShowroom name.
	self assertHtml: html includes: 'src="gt-figures/1000.png"'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> textSnippetWithImageLinkWithAbsolutePath [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithImageLinkWithAbsolutePath.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self assertHtml: html includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.
	self assertHtml: html includes: '<figcaption class="picture-snippet-caption">Attachment Image Link</figcaption>'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> textSnippetWithImageLinkWithRelativeAttachmentPath [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithImageLinkWithRelativeAttachmentPath.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self assertHtml: html includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.
	self assertHtml: html includes: '<figcaption class="picture-snippet-caption">Attachment Image Link</figcaption>'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> textSnippetWithImageLinkWithRelativeAttachmentPathWithTwoSlashes [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithImageLinkWithRelativeAttachmentPathWithTwoSlashes.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self assertHtml: html includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.
	self assertHtml: html includes: '<figcaption class="picture-snippet-caption">Attachment Image Link</figcaption>'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> textSnippetWithWordAnnotation [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithWordAnnotation.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]
