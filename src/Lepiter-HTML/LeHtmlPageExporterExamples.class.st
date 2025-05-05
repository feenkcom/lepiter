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
