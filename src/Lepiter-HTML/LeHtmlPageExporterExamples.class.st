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
	| page exporter context html |
	page := LeExportSampleData new samplePage.
	context := LeHtmlContext new page: page.
	
	exporter := LeHtmlPageExporter new.
	exporter context: context.

	html := exporter contents.

	"self assertNotEmptyHtml: html."

	^ exporter
]

{ #category : #examples }
LeHtmlPageExporterExamples >> exportSamplePageFullHtml [
	<gtExample>
	| page exporter context html piece |
	page := LeExportSampleData new samplePage.
	piece := LeHtmlPieceExamples new formatPiece.
	piece at: #content put: LeHtmlPagePiece new.
	piece at: #title put: LeHtmlPageTitlePiece new.
	context := LeHtmlContext new page: page.
	
	exporter := LeHtmlPageExporter new
		context: context;
		piece: piece.

	html := exporter contents.

	self assertNotEmptyHtml: html.

	^ exporter
]
