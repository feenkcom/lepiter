Class {
	#name : #LeHtmlVisitorExamples,
	#superclass : #Object,
	#traits : 'TLeExportResourceAssertions + TLeHtmlContentAssertions',
	#classTraits : 'TLeExportResourceAssertions classTrait + TLeHtmlContentAssertions classTrait',
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippet_PresenterSlideShow [
	<gtExample>
	| snippet html resources context visitor holder |
	holder := LeExportSnippetExamples new elementSnippetWithSlideshow.
	snippet := holder snippet.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
						resources: (resources := LeExportResources new)).

	html := visitor contentsFor: snippet.
	
	self assertResources: resources size: holder allSlides size.

	self assertHtml: html includes: '<img src="gt-figures/1001.png" class="d-block w-100" alt="Slide 2"/>'.
	
	^ visitor
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippet_Successful [
	<gtExample>
	| snippet html resources visitor holder |
	holder := LeExportSnippetExamples new elementSnippetWithGlamorousBreadcrumb.
	snippet := holder snippet.
	visitor := LeHtmlVisitor new
			context: (LeHtmlContext new resources: (resources := LeExportResources new)).

	html := visitor contentsFor: snippet.

	self assertResources: resources size: 1.
	self assertNotReadyResources: resources.

	self assert: html isNotEmpty description: [ 'HTML output must be non-empty' ].

	self assertHtml: html includes: '<figure class="snippet picture-snippet'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>'.

	^ visitor
]

{ #category : #'examples - element snippet' }
LeHtmlVisitorExamples >> elementSnippet_Successful_PrepareResources [
	<gtExample>
	| resources visitor context |
	visitor := self elementSnippet_Successful.
	context := visitor context.
	resources := context resources.
	context assembler assemble.
	
	self assertReadyResources: resources.

	^ visitor
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureSnippet_SuccessfulWithFileReference [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithExistingFileReference.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: (resources := LeExportResources new)).
	
	html := visitor contentsFor: snippet.
	
	self assertResources: resources size: 1.
	self assertReadyResources: resources.
	
	self assertHtml: html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"'.
	self assertHtml: html includes: '<img class="picture-snippet-image" src="gt-figures/1000.jpg"/>'.
	
	^ visitor
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureSnippet_SuccessfulWithHttp [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithHttps.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: (resources := LeExportResources new)).
	
	html := visitor contentsFor: snippet.

	self assertResources: resources size: 0.
	
	self assertHtml: html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"'.
	self assertHtml: html includes: '<img class="picture-snippet-image" src="https://gtoolkit.com/assets/pictures/use-case-rest-api.png"/>'.
	
	^ visitor
]

{ #category : #'examples - picture snippet' }
LeHtmlVisitorExamples >> pictureSnippet_SuccessfulWithMissingFileReference [
	<gtExample>
	| snippet html resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithMissingFileReference.
	
	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new
				resources: (resources := LeExportResources new)).
	
	html := visitor contentsFor: snippet.
	
	self assertResources: resources size: 1.
	self assertNotReadyResources: resources.
	self assertFailedResources: resources.
	
	self assertHtml: html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"'.
	self assertHtml: html includes: '<img class="picture-snippet-image" src="gt-figures/1000.jpg"/>'.
	
	^ visitor
]
