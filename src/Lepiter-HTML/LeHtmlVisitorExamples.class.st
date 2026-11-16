Class {
	#name : #LeHtmlVisitorExamples,
	#superclass : #Object,
	#traits : 'TLeExportResourceAssertions + TLeHtmlContentAssertions + TLeExportLogAssertions',
	#classTraits : 'TLeExportResourceAssertions classTrait + TLeHtmlContentAssertions classTrait + TLeExportLogAssertions classTrait',
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #'examples - unknown annotations' }
LeHtmlVisitorExamples >> headerWithUnknownAnnotation [
	"The header id ignores annotations (the builder joins the trimmed text parts), the header text keeps the unknown annotation"

	<gtExample>
	<return: #LeHtmlContext>
	| aSnippet aContext html |
	aSnippet := LeTextSnippet string: '# Header {{gtFoo:bar}} text'.

	html := self htmlForTextSnippet: aSnippet context: (aContext := LeHtmlContext new).

	self assertHtml: html includes: '<h2 id="headertext">'.
	self
		assertHtml: html
		includes: '<span class="annotation annotation-unknown">{{gtFoo:bar}}</span>'.
	self assert: aContext log asArray size equals: 1.

	^ aContext

]

{ #category : #private }
LeHtmlVisitorExamples >> htmlForTextSnippet: aSnippet context: aContext [
	| aResources |
	aResources := LeExportResources new.
	aSnippet
		acceptVisitor: (LeExportVisitor new
				context: (LeExportContext new
						resources: aResources;
						fileStore: LeExportMemoryStore new)).
	aContext resources: aResources.

	^ LeHtmlVisitor new
		context: aContext;
		contentsFor: aSnippet

]

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
	self 
		assertHtml: html 
		includes: '&lt;&lt; #BrButton'.

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
	self 
		assertHtml: html 
		includes: '&lt;&lt; #BrButton'.

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
	self 
		assertHtml: html 
		includes: '&lt;&lt; #BrButton'.

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
	self 
		assertHtml: html 
		includes: '&lt;&lt; #BrButton'.

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

{ #category : #'examples - unknown annotations' }
LeHtmlVisitorExamples >> textSnippetWithKnownAndUnknownAnnotations [
	"Well-formed core annotations are exported as before"

	<gtExample>
	<return: #LeHtmlContext>
	| aSnippet aContext html |
	aSnippet := LeTextSnippet string: 'See {{gtClass:BrButton}} and {{gtFoo:bar}} here'.

	html := self htmlForTextSnippet: aSnippet context: (aContext := LeHtmlContext new).

	self assertHtml: html includes: '>BrButton<'.
	self
		assertHtml: html
		includes: ' and <span class="annotation annotation-unknown">{{gtFoo:bar}}</span> here'.
	self assert: aContext log asArray size equals: 1.

	^ aContext

]

{ #category : #'examples - unknown annotations' }
LeHtmlVisitorExamples >> textSnippetWithMalformedAnnotation [
	"A known annotation with a syntax error is written as it was typed and logged"

	<gtExample>
	<return: #LeHtmlContext>
	| aSnippet aContext html |
	aSnippet := LeTextSnippet string: 'See {{gtClass:}} here'.

	html := self htmlForTextSnippet: aSnippet context: (aContext := LeHtmlContext new).

	self
		assertHtml: html
		includes: 'See <span class="annotation annotation-unknown">{{gtClass:}}</span> here'.
	self assert: aContext log asArray size equals: 1.
	self
		assert: aContext log asArray first class
		equals: LeExportUnresolvedAnnotationLogItem.

	^ aContext

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

{ #category : #'examples - unknown annotations' }
LeHtmlVisitorExamples >> textSnippetWithUnknownAnnotation [
	"An unknown annotation is written as it was typed and logged"

	<gtExample>
	<return: #LeHtmlContext>
	| aSnippet aContext html aLogItem |
	aSnippet := LeTextSnippet string: 'See {{gtFoo:bar}} here'.

	html := self htmlForTextSnippet: aSnippet context: (aContext := LeHtmlContext new).

	self
		assertHtml: html
		includes: 'See <span class="annotation annotation-unknown">{{gtFoo:bar}}</span> here'.
	self assert: aContext log asArray size equals: 1.
	aLogItem := aContext log asArray first.
	self assert: aLogItem class equals: LeExportUnresolvedAnnotationLogItem.
	self assert: aLogItem snippet equals: aSnippet.
	self assert: aLogItem annotation class equals: LeDocumenterAnnotationNode.
	self assert: aLogItem isProblemLog.
	self assert: (aLogItem description includesSubstring: '{{gtFoo:bar}}').

	^ aContext

]

{ #category : #'examples - unknown annotations' }
LeHtmlVisitorExamples >> textSnippetWithUnknownAnnotationIsEscaped [
	<gtExample>
	<return: #LeHtmlContext>
	| aSnippet aContext html |
	aSnippet := LeTextSnippet string: 'See {{gtFoo:<b>&}} here'.

	html := self htmlForTextSnippet: aSnippet context: (aContext := LeHtmlContext new).

	self
		assertHtml: html
		includes: 'See <span class="annotation annotation-unknown">{{gtFoo:&lt;b>&amp;}}</span> here'.
	self assert: (html includesSubstring: '<b>') not.

	^ aContext

]

{ #category : #'examples - unknown annotations' }
LeHtmlVisitorExamples >> textSnippetWithUnterminatedAnnotation [
	"An annotation without its closing braces cannot be parsed as an annotation at all.
	The parser answers an error node for the rest of the text, which is written as it was typed and logged."

	<gtExample>
	<return: #LeHtmlContext>
	| aSnippet aContext html |
	aSnippet := LeTextSnippet string: 'See {{gtClass:BrButton'.

	html := self htmlForTextSnippet: aSnippet context: (aContext := LeHtmlContext new).

	self assertHtml: html includes: 'See {{gtClass:BrButton'.
	self assert: aContext log asArray size equals: 1.
	self
		assert: aContext log asArray first class
		equals: LeExportUnsupportedTextSnippetNodeLogItem.
	self assert: aContext log asArray first node isErrorNode.

	^ aContext

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
