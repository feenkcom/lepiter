Extension { #name : #LeHtmlVisitorExamples }

{ #category : #'*Lepiter-Snippet-Picture' }
LeHtmlVisitorExamples >> pageWithHeaderMatchingFigureId [
	"The header 'Figure picture1' has the slug 'figure-picture1', which is the id of the picture 'picture1'.
	The figure keeps its id, because links from other pages compute it from the reference only.
	The headers get a suffix instead, before and after the picture."

	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| aPage aPicture resources visitor html |
	aPage := LePage named: 'Figure ids'.
	aPage addSnippet: (LeTextSnippet string: '# Figure picture1').
	aPicture := LePictureSnippet new
			urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png';
			reference: 'picture1'.
	aPage addSnippet: aPicture.
	aPage addSnippet: (LeTextSnippet string: '# Figure picture1').
	aPage addSnippet: (LeTextSnippet string: '# Other header').

	resources := LeExportResources new.
	aPage
		acceptVisitor: (LeExportVisitor new
				context: (LeExportContext new
						resources: resources;
						fileStore: LeExportMemoryStore new)).
	self assertResources: resources size: 1.

	visitor := LeHtmlVisitor new context: (LeHtmlContext new resources: resources).
	html := visitor contentsFor: aPage.

	self assertHtml: html includes: '<h2 id="figure-picture12">'.
	self assertHtml: html includes: '<h2 id="figure-picture13">'.
	self assertHtml: html includes: '<h2 id="other-header">'.
	self
		assertHtml: html
		includes: '<figure id="figure-picture1" class="snippet picture-snippet '.
	self assert: (html includesSubstring: '<h2 id="figure-picture1">') not.
	self
		assert: visitor elementIds asArray
		equals: #('figure-picture1' 'figure-picture12' 'figure-picture13' 'other-header').

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: aPicture

]

{ #category : #'*Lepiter-Snippet-Picture' }
LeHtmlVisitorExamples >> pageWithHeadersAndPictureWithoutReference [
	"A picture without a reference has no id, so it reserves nothing and headers keep their slugs"

	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| aPage aPicture resources visitor html |
	aPage := LePage named: 'Figure ids'.
	aPage addSnippet: (LeTextSnippet string: '# Figure picture1').
	aPicture := LePictureSnippet new
			urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png'.
	aPage addSnippet: aPicture.

	resources := LeExportResources new.
	aPage
		acceptVisitor: (LeExportVisitor new
				context: (LeExportContext new
						resources: resources;
						fileStore: LeExportMemoryStore new)).

	visitor := LeHtmlVisitor new context: (LeHtmlContext new resources: resources).
	html := visitor contentsFor: aPage.

	self assertHtml: html includes: '<h2 id="figure-picture1">'.
	self assertHtml: html includes: '<figure class="snippet picture-snippet '.
	self assert: visitor elementIds asArray equals: #('figure-picture1').

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: aPicture

]

{ #category : #'*Lepiter-Snippet-Picture' }
LeHtmlVisitorExamples >> pictureReferenceElementIds [
	<gtExample>
	<return: #Array>
	| theIds |
	theIds := #('fig1' 'My Figure 1' 'picture_2' '--x--')
		collect: [ :each | LeHtmlFigureImageWriter elementIdForPictureReference: each ].

	self assert: theIds equals: #('figure-fig1' 'figure-my-figure-1' 'figure-picture-2' 'figure-x').

	^ theIds

]

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
LeHtmlVisitorExamples >> pictureSnippetWithHttpsAndReference [
	"A picture snippet with a reference gets an element id, so gtPictureReference annotations can link to it"

	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet html resources context visitor |
	snippet := LeExportSnippetExamples new pictureSnippetWithHttps.
	snippet reference: 'fig1'.
	visitor := LeExportVisitor new
			context: (LeExportContext new resources: (resources := LeExportResources new)).
	snippet acceptVisitor: visitor.
	self assertResources: resources size: 1.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: resources).
	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		beginsWith: '<figure id="figure-fig1" class="snippet picture-snippet fullWidth"'.
	self
		assertHtml: html
		includes: '<img class="picture-snippet-image" src="https://gtoolkit.com/assets/pictures/use-case-rest-api.png"/>'.
	self assert: (visitor elementIds includes: 'figure-fig1').

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
