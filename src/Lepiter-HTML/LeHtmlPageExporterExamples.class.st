Class {
	#name : #LeHtmlPageExporterExamples,
	#superclass : #Object,
	#traits : 'TLeHtmlContentAssertions',
	#classTraits : 'TLeHtmlContentAssertions classTrait',
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeHtmlPageExporterExamples >> exportSamplePage [
	<gtExample>
	<return: #LeHtmlPageExporter>
	| page exporter html |
	page := LeExportSampleData new samplePage.

	exporter := LeHtmlPageExporter new.
	exporter page: page.

	html := exporter contents.

	self assertNotEmptyHtml: html.

	^ exporter
]

{ #category : #examples }
LeHtmlPageExporterExamples >> exportSamplePageFullHtml [
	<gtExample>
	<return: #LeHtmlPageExporter>
	| page exporter html piece |
	page := LeExportSampleData new samplePage.
	piece := LeHtmlPieceExamples new formatPiece.
	piece at: #content put: LeHtmlPagePiece new.
	piece at: #title put: LeHtmlPageTitlePiece new.

	exporter := LeHtmlPageExporter new
			page: page;
			piece: piece.

	html := exporter contents.

	self assertNotEmptyHtml: html.

	^ exporter
]

{ #category : #assertions }
LeHtmlPageExporterExamples >> metaLineStartingWith: aPrefix in: anHtml [
	^ (anHtml lines
		detect: [ :each | each trimBoth beginsWith: aPrefix ]
		ifNone: [ self error: 'HTML must include a line starting with ' , aPrefix ]) trimBoth
]

{ #category : #examples }
LeHtmlPageExporterExamples >> pageWithHtmlTagsInTextSnippetUsedAsPagePreview [
	<gtExample>
	<return: #LeHtmlPageExporter>
	| aPage anExporter anHtml |
	aPage := LePage new.
	aPage title: 'Page with HTML tags in text'.
	"HTML imported as plain text (e.g., from Medium) contains quotes, which used to end the attribute value early."
	aPage snippetBuilder
		string: 'Spend more than <a href="https://lepiter.io/page/">half of the time</a> on reading.';
		add.

	anExporter := LeHtmlPageExporter new
			page: aPage;
			piece: LeHtmlGtBookPiece gtSinglePage.
	anHtml := anExporter contents.

	#('<meta name="description" content="' '<meta property="og:description" content="')
		do: [ :aPrefix | 
			| aLine |
			aLine := self metaLineStartingWith: aPrefix in: anHtml.
			self
				assert: (aLine occurrencesOf: $") = 4
				description: [ 'The attribute value must not contain a raw quote: {1}' format: {aLine} ].
			self
				assert: (aLine endsWith: '">')
				description: [ 'The meta tag must end right after the attribute value: {1}' format: {aLine} ] ].

	^ anExporter
]

{ #category : #examples }
LeHtmlPageExporterExamples >> pageWithSpecialCharactersInTextSnippetUsedAsPagePreview [
	<gtExample>
	<return: #LeHtmlPageExporter>
	| aPage anExporter anHtml |
	aPage := LePage new.
	aPage title: 'Page with special characters'.
	aPage snippetBuilder
		string: 'Say "hi" & bye.';
		add.

	anExporter := LeHtmlPageExporter new
			page: aPage;
			piece: LeHtmlGtBookPiece gtSinglePage.
	anHtml := anExporter contents.

	self
		assertHtml: anHtml
		includes: '<meta name="description" content="Say &quot;hi&quot; &amp; bye.">'.
	self
		assertHtml: anHtml
		includes: '<meta property="og:description" content="Say &quot;hi&quot; &amp; bye.">'.

	^ anExporter
]

{ #category : #examples }
LeHtmlPageExporterExamples >> pageWithSpecialCharactersInTitleUsedAsPageTitle [
	<gtExample>
	<return: #LeHtmlPageExporter>
	| aPage anExporter anHtml |
	aPage := LePage new.
	aPage title: 'Q&A "x"'.
	aPage snippetBuilder
		string: 'Plain.';
		add.

	anExporter := LeHtmlPageExporter new
			page: aPage;
			piece: LeHtmlGtBookPiece gtSinglePage.
	anHtml := anExporter contents.

	self
		assertHtml: anHtml
		includes: '<meta property="og:title" content="Q&amp;A &quot;x&quot;">'.

	^ anExporter
]

{ #category : #examples }
LeHtmlPageExporterExamples >> pageWithTextSnippetUsedAsPagePreview [
	<gtExample>
	<return: #LeHtmlPageExporter>
	| page exporter html piece |
	page := LeExportPageExamples new pageWithTextSnippetUsedAsPagePreview.
	piece := LeHtmlGtBookPiece gtSinglePage.

	exporter := LeHtmlPageExporter new
			page: page;
			piece: piece.

	html := exporter contents.

	self assertNotEmptyHtml: html.
	self
		assertHtml: html
		includes: '<meta name="description" content="GToolkit, Button, action method, is italic.">'.
	self
		assertHtml: html
		includes: '<meta property="og:description" content="GToolkit, Button, action method, is italic.">'.

	^ exporter
]

{ #category : #examples }
LeHtmlPageExporterExamples >> pageWithoutTextSnippetUsesTitleAsPagePreview [
	<gtExample>
	<return: #LeHtmlPageExporter>
	| aPage anExporter anHtml |
	"Without a text snippet, the title is used as the description."
	aPage := LePage new.
	aPage title: 'Say "hi" & bye'.

	anExporter := LeHtmlPageExporter new
			page: aPage;
			piece: LeHtmlGtBookPiece gtSinglePage.
	anHtml := anExporter contents.

	self
		assertHtml: anHtml
		includes: '<meta name="description" content="Say &quot;hi&quot; &amp; bye">'.
	self
		assertHtml: anHtml
		includes: '<meta property="og:description" content="Say &quot;hi&quot; &amp; bye">'.

	^ anExporter
]
