"
I exemplify how `gtSymbol` annotations ({{gtClass:LeSymbolAnnotationNode}}) are processed by the export visitors, for example {{gtClass:LeHtmlElementIdBuilder}} in {{gtExample:LeSymbolAnnotationExportExamples>>#headerWithSymbolAnnotationElementId}}.
"
Class {
	#name : #LeSymbolAnnotationExportExamples,
	#superclass : #Object,
	#traits : 'TLeHtmlContentAssertions',
	#classTraits : 'TLeHtmlContentAssertions classTrait',
	#category : #'Lepiter-Snippet-Symbol-Examples'
}

{ #category : #'examples - export' }
LeSymbolAnnotationExportExamples >> exportTextSnippetWithSymbolAnnotation [
	<gtExample>
	<return: #LeExportVisitorHolder>
	| snippet resources visitor fileStore |
	snippet := self textSnippetWithSymbolAnnotation.
	visitor := LeExportVisitor new
			context: (LeExportContext new
					resources: (resources := LeExportResources new);
					fileStore: (fileStore := LeExportMemoryStore new)).

	snippet acceptVisitor: visitor.

	self assert: resources size equals: 0.
	self assert: fileStore hasChildren not.

	^ LeExportVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #'examples - html' }
LeSymbolAnnotationExportExamples >> headerWithSymbolAnnotationElementId [
	<gtExample>
	<return: #LeHtmlElementId>
	| aHeader aResult |
	aHeader := (LeParser parseWithErrors: '### Use {{gtSymbol:asString}} here') parts first.

	aResult := LeHtmlElementIdBuilder new
			contentNode: aHeader;
			build.

	self assert: aResult elementId equals: 'usehere'.
	^ aResult

]

{ #category : #'examples - html' }
LeSymbolAnnotationExportExamples >> htmlHeaderWithSymbolAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet context visitor html |
	snippet := LeTextSnippet string: '### Use {{gtSymbol:asString}} here'.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: LeExportResources new).
	html := visitor contentsFor: snippet.

	self assertHtml: html includes: 'id="usehere"'.
	self
		assertHtml: html
		includes: '<code class="annotation annotation-label annotation-label-symbol">#asString</code>'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #'examples - html' }
LeSymbolAnnotationExportExamples >> htmlTextSnippetWithEmptySymbolAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet context visitor html |
	snippet := LeTextSnippet string: 'Use {{gtSymbol:}} here'.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: LeExportResources new).
	html := visitor contentsFor: snippet.

	self assertHtml: html includes: 'Use '.
	self assertHtml: html includes: ' here'.
	self assert: (html includesSubstring: 'annotation-label-symbol') not.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #'examples - html' }
LeSymbolAnnotationExportExamples >> htmlTextSnippetWithSymbolAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| holder snippet context visitor html |
	holder := self exportTextSnippetWithSymbolAnnotation.
	snippet := holder snippet.

	visitor := LeHtmlVisitor new
			context: (context := LeHtmlContext new resources: holder resources).
	html := visitor contentsFor: snippet.

	self
		assertHtml: html
		includes: '<code class="annotation annotation-label annotation-label-symbol">#asString</code>'.
	self assert: context log asArray isEmpty.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #'examples - html' }
LeSymbolAnnotationExportExamples >> postAbstractTextSnippetWithSymbolAnnotation [
	<gtExample>
	<return: #LeHtmlVisitorHolder>
	| snippet visitor html |
	snippet := self textSnippetWithSymbolAnnotation.

	visitor := LeHtmlTextSnippetPostAbstractVisitor new
			context: LeHtmlContext new;
			snippet: snippet.
	html := visitor contentsFor: snippet.

	self assertHtml: html equals: 'Use #asString here'.

	^ LeHtmlVisitorHolder new
		visitor: visitor;
		snippet: snippet

]

{ #category : #'examples - registration' }
LeSymbolAnnotationExportExamples >> registrationIsIdempotent [
	<gtExample>
	<return: #Array>
	| registries before |
	registries := {
		LeHtmlTextSnippetVisitor componentVisitorClasses -> LeSymbolAnnotationHtmlVisitor.
		LeHtmlTextSnippetPostAbstractVisitor componentVisitorClasses -> LeSymbolAnnotationHtmlPostAbstractVisitor }.
	before := registries collect: [ :each | each key copy ].
	[ LeSymbolAnnotationHtmlVisitor
		initialize;
		initialize.
	LeSymbolAnnotationHtmlPostAbstractVisitor
		initialize;
		initialize.
	registries
		do: [ :each | self assert: (each key occurrencesOf: each value) equals: 1 ] ]
		ensure: [ registries
				with: before
				do: [ :each :classes | 
					each key
						removeAll;
						addAll: classes ] ].
	^ registries

]

{ #category : #'examples - snippet' }
LeSymbolAnnotationExportExamples >> textSnippetWithSymbolAnnotation [
	<gtExample>
	<return: #LeTextSnippet>
	^ LeTextSnippet string: 'Use {{gtSymbol:asString}} here'

]
