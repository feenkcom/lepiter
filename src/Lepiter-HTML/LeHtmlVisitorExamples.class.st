Class {
	#name : #LeHtmlVisitorExamples,
	#superclass : #Object,
	#traits : 'TLeExportResourceAssertions + TLeHtmlContentAssertions + TLeExportLogAssertions',
	#classTraits : 'TLeExportResourceAssertions classTrait + TLeHtmlContentAssertions classTrait + TLeExportLogAssertions classTrait',
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippetWithGlamorousBreadcrumb [
	<gtExample>
	| snippet html resources visitor holder |
	holder := LeExportVisitorExamples new elementSnippetWithGlamorousBreadcrumb.
	snippet := holder snippet.
	resources := holder resources.
	visitor := LeHtmlVisitor new
			context: (LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippetWithInexistentMethod [
	<gtExample>
	| snippet html resources visitor holder |
	holder := LeExportVisitorExamples new elementSnippetWithInexistentMethod.
	snippet := holder snippet.
	resources := holder resources.
	visitor := LeHtmlVisitor new
			context: (LeHtmlContext new resources: resources).

	html := visitor contentsFor: snippet.

	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippetWithSlideshow [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new elementSnippetWithSlideshow.
	snippet := holder snippet.
	resources := holder resources.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
						resources: resources).

	html := visitor contentsFor: snippet.
	
	self assertHtml: html includes: '<img src="gt-figures/1000.png" class="d-block w-100" alt="Slide 1"/>'.
	self assertHtml: html includes: '<img src="gt-figures/1001.png" class="d-block w-100" alt="Slide 2"/>'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureSnippetWithExistingFileReference [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new pictureSnippetWithExistingFileReference.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"'.
	self assertHtml: html includes: '<img class="picture-snippet-image" src="gt-figures/1000.jpg"/>'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureSnippetWithHttps [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new pictureSnippetWithHttps.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.

	self assertHtml: html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"'.
	self assertHtml: html includes: '<img class="picture-snippet-image" src="https://gtoolkit.com/assets/pictures/use-case-rest-api.png"/>'.
	
	^ LeHtmlVisitorHolder new 
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureSnippetWithMissingFileReference [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportVisitorExamples new pictureSnippetWithMissingFileReference.
	snippet := holder snippet.
	resources := holder resources.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: resources).
	
	html := visitor contentsFor: snippet.
	
	self assertHtml: html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"'.
	self assertHtml: html includes: '<img class="picture-snippet-image" src="gt-figures/1000.jpg"/>'.
	
	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> unsupportedSnippet [
	<gtExample>
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
