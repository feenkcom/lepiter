Extension { #name : #LeHtmlVisitorExamples }

{ #category : #'*Lepiter-Snippet-Picture' }
LeHtmlVisitorExamples >> pictureSnippetWithExistingFileReference [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new pictureSnippetWithExistingFileReference.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		beginsWith: '<figure class="snippet picture-snippet fullWidth"'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.jpg"/>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeHtmlVisitorExamples >> pictureSnippetWithHttps [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new pictureSnippetWithHttps.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		beginsWith: '<figure class="snippet picture-snippet fullWidth"'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="https://gtoolkit.com/assets/pictures/use-case-rest-api.png"/>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeHtmlVisitorExamples >> pictureSnippetWithMissingFileReference [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new pictureSnippetWithMissingFileReference.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		beginsWith: '<figure class="snippet picture-snippet fullWidth"'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.jpg"/>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]
