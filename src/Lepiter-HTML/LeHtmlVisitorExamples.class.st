Class {
	#name : #LeHtmlVisitorExamples,
	#superclass : #Object,
	#traits : 'TLeExportResourceAssertions + TLeHtmlContentAssertions + TLeExportLogAssertions',
	#classTraits : 'TLeExportResourceAssertions classTrait + TLeHtmlContentAssertions classTrait + TLeExportLogAssertions classTrait',
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithClassAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithClassAnnotation.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '>BrButton<'.
	self assertHtml: html includes: 'annotation-sibling-is-collapsed'.
	self
		assertHtml: html
		includes: 'expandable-annotation-view collapsed-annotation-view'.
	self assertHtml: html includes: 'subclass: #BrButton'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithClassAnnotationCollapsed [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithClassAnnotationCollapsed.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '>BrButton<'.
	self assertHtml: html includes: 'annotation-sibling-is-collapsed'.
	self
		assertHtml: html
		includes: 'expandable-annotation-view collapsed-annotation-view'.
	self assertHtml: html includes: 'subclass: #BrButton'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithClassAnnotationExpanded [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithClassAnnotationExpanded.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '>BrButton<'.
	self assertHtml: html includes: 'annotation-sibling-is-expanded'.
	self
		assertHtml: html
		includes: 'expandable-annotation-view expanded-annotation-view'.
	self assertHtml: html includes: 'subclass: #BrButton'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithClassAnnotationLabeledAndText [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new
			textSnippetWithClassAnnotationLabeledAndText.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '>Button<'.
	self assertHtml: html includes: 'annotation-sibling-is-collapsed'.
	self
		assertHtml: html
		includes: 'expandable-annotation-view collapsed-annotation-view'.
	self assertHtml: html includes: 'subclass: #BrButton'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithExampleAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithExampleAnnotation.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		includes: ' <div class="snippet textual-snippet code-snippet pharo-snippet paragraphWidth">'.
	self assertHtml: html includes: 'BrExamplesShowroom>>#glamorousLargeButton'.
	self assertHtml: html includes: BrExamplesShowroom name.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithExampleAnnotationWithLabel [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithExampleAnnotationWithLabel.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		includes: '<div class="snippet textual-snippet text-snippet paragraphWidth">'.
	self assertHtml: html includes: '<code class="example_inlined">'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithExampleAnnotationWithPreviewExpanded [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new
			textSnippetWithExampleAnnotationWithPreviewExpanded.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		includes: '<div class="snippet textual-snippet code-snippet pharo-snippet paragraphWidth">'.
	self assertHtml: html includes: 'BrExamplesShowroom>>#glamorousLargeButton'.
	self assertHtml: html includes: BrExamplesShowroom name.
	self assertHtml: html includes: 'src="gt-figures/1000.png"'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithExternalLabelUrlLink [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor context html |
	snippet := LeExportSnippetExamples new textSnippetWithExternalLabelUrlLink.

	visitor := LeHtmlVisitor new context: (context := LeHtmlContext new).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '<a href="https://gtoolkit.com/">GToolkit</a>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithImageLinkWithAbsolutePath [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithImageLinkWithAbsolutePath.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.
	self
		assertHtml: html
		includes: '<figcaption class="picture-snippet-caption">Attachment Image Link</figcaption>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithImageLinkWithRelativeAttachmentPath [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new
			textSnippetWithImageLinkWithRelativeAttachmentPath.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.
	self
		assertHtml: html
		includes: '<figcaption class="picture-snippet-caption">Attachment Image Link</figcaption>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithImageLinkWithRelativeAttachmentPathWithTwoSlashes [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new
			textSnippetWithImageLinkWithRelativeAttachmentPathWithTwoSlashes.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.
	self
		assertHtml: html
		includes: '<figcaption class="picture-snippet-caption">Attachment Image Link</figcaption>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithMethodAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithMethodAnnotation.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '>BrButton>>#action:<'.
	self assertHtml: html includes: 'annotation-sibling-is-collapsed'.
	self
		assertHtml: html
		includes: 'expandable-annotation-view collapsed-annotation-view'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithMethodAnnotationCollapsed [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithMethodAnnotationCollapsed.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '>BrButton>>#action:<'.
	self assertHtml: html includes: 'annotation-sibling-is-collapsed'.
	self
		assertHtml: html
		includes: 'expandable-annotation-view collapsed-annotation-view'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithMethodAnnotationExpanded [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithMethodAnnotationExpanded.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '>BrButton>>#action:<'.
	self assertHtml: html includes: 'annotation-sibling-is-expanded'.
	self
		assertHtml: html
		includes: 'expandable-annotation-view expanded-annotation-view'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - text snippet' }
LeHtmlVisitorExamples >> textSnippetWithWordAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new textSnippetWithWordAnnotation.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]
