Extension { #name : #LeHtmlVisitorExamples }

{ #category : #'*Lepiter-Snippet-Element' }
LeHtmlVisitorExamples >> elementSnippetWithGlamorousBreadcrumb [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources visitor holder |
	holder := LeExportVisitorExamples new elementSnippetWithGlamorousBreadcrumb.
	snippet := holder snippet.
	resources := holder resources.
	visitor := LeHtmlVisitor new context: (LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Element' }
LeHtmlVisitorExamples >> elementSnippetWithInexistentMethod [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources visitor holder |
	holder := LeExportVisitorExamples new elementSnippetWithInexistentMethod.
	snippet := holder snippet.
	resources := holder resources.
	visitor := LeHtmlVisitor new context: (LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Element' }
LeHtmlVisitorExamples >> elementSnippetWithSlideshow [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new elementSnippetWithSlideshow.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		includes: '<img src="gt-figures/1000.png" class="d-block w-100" alt="Slide 1"/>'.
	self
		assertHtml: html
		includes: '<img src="gt-figures/1001.png" class="d-block w-100" alt="Slide 2"/>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Element' }
LeHtmlVisitorExamples >> unsupportedSnippet [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources visitor holder log |
	holder := LeExportVisitorExamples new unsupportedSnippet.
	snippet := holder snippet.
	resources := holder resources.
	visitor := LeHtmlIncompleteVisitor new
			context: (LeHtmlContext new
					resources: resources;
					log: (log := LeExportLog new)).

	html := visitor contentsFor: snippet.

	self assertEmptyHtml: html.
	self assertLog: log size: 1.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]
