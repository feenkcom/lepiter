"
I exemplify {{gtClass:LeExampleToPngExporter}}. 
"
Class {
	#name : #LeExampleToPngExporterExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeExampleToPngExporterExamples >> exportGtHistory [
	<gtExample>
	| anExample aFileReference anExporter |
	anExample := (GtTour >> #timelineElement) gtExample.
	aFileReference := FileSystem memory workingDirectory / 'picture.png'.

	anExporter := LeExampleToPngExporter new
			example: anExample;
			fileReference: aFileReference;
			previewSelector: #gtLiveFor:;
			export.

	self
		assert: aFileReference exists
		description: [ 'File must exist: {1}' format: {aFileReference} ].
	self
		assert: aFileReference size isZero not
		description: [ 'File must not be empty: {1}' format: {aFileReference} ].

	^ anExporter
]
