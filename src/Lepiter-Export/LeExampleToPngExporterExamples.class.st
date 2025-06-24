"
I exemplify {{gtClass:LeExampleToPngExporter}}. 
"
Class {
	#name : #LeExampleToPngExporterExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Resources - Examples'
}

{ #category : #examples }
LeExampleToPngExporterExamples >> exportGtFilter [
	<gtExample>
	<return: #LeExampleToPngExporter>
	| anExample aFileReference anExporter |
	anExample := (GtSearchClassFilterExamples >> #classesInCurrentPackageFilter)
			gtExample.
	aFileReference := FileSystem memory workingDirectory / 'picture.png'.

	anExporter := LeExampleToPngExporter new
			example: anExample;
			fileReference: aFileReference;
			withoutScripter;
			export.

	self
		assert: aFileReference exists
		description: [ 'File must exist: {1}' format: {aFileReference} ].
	self
		assert: aFileReference size isZero not
		description: [ 'File must not be empty: {1}' format: {aFileReference} ].

	^ anExporter
]

{ #category : #examples }
LeExampleToPngExporterExamples >> exportGtFilter_Scripter [
	<gtExample>
	<return: #LeExampleToPngExporter>
	| anExample aFileReference anExporter |
	anExample := (GtSearchClassFilterExamples >> #classesInCurrentPackageFilter)
			gtExample.
	aFileReference := FileSystem memory workingDirectory / 'picture.png'.

	anExporter := LeExampleToPngExporter new
			example: anExample;
			fileReference: aFileReference;
			withScripter;
			export.

	self
		assert: aFileReference exists
		description: [ 'File must exist: {1}' format: {aFileReference} ].
	self
		assert: aFileReference size isZero not
		description: [ 'File must not be empty: {1}' format: {aFileReference} ].

	^ anExporter
]

{ #category : #examples }
LeExampleToPngExporterExamples >> exportGtHistory [
	<gtExample>
	<return: #LeExampleToPngExporter>
	| anExample aFileReference anExporter |
	anExample := (GtTour >> #timelineElement) gtExample.
	aFileReference := FileSystem memory workingDirectory / 'picture.png'.

	anExporter := LeExampleToPngExporter new
			example: anExample;
			fileReference: aFileReference;
			previewSelector: #gtLiveFor:;
			withoutScripter;
			export.

	self
		assert: aFileReference exists
		description: [ 'File must exist: {1}' format: {aFileReference} ].
	self
		assert: aFileReference size isZero not
		description: [ 'File must not be empty: {1}' format: {aFileReference} ].

	^ anExporter
]

{ #category : #examples }
LeExampleToPngExporterExamples >> exportGtHistory_Scripter [
	<gtExample>
	<return: #LeExampleToPngExporter>
	| anExample aFileReference anExporter |
	anExample := (GtTour >> #timelineElement) gtExample.
	aFileReference := FileSystem memory workingDirectory / 'picture.png'.

	anExporter := LeExampleToPngExporter new
			example: anExample;
			fileReference: aFileReference;
			previewSelector: #gtLiveFor:;
			withScripter;
			export.

	self
		assert: aFileReference exists
		description: [ 'File must exist: {1}' format: {aFileReference} ].
	self
		assert: aFileReference size isZero not
		description: [ 'File must not be empty: {1}' format: {aFileReference} ].

	^ anExporter
]

{ #category : #examples }
LeExampleToPngExporterExamples >> exportMethodCoder [
	<gtExample>
	<return: #LeExampleToPngExporter>
	| anExample aFileReference anExporter |
	anExample := (GtPharoMethodCoderExamples >> #forThisMethodCoder) gtExample.
	aFileReference := FileSystem memory workingDirectory / 'picture.png'.

	anExporter := LeExampleToPngExporter new
			example: anExample;
			fileReference: aFileReference;
			previewSelector: #gtLiveFor:;
			withoutScripter;
			export.

	self
		assert: aFileReference exists
		description: [ 'File must exist: {1}' format: {aFileReference} ].
	self
		assert: aFileReference size isZero not
		description: [ 'File must not be empty: {1}' format: {aFileReference} ].

	^ anExporter
]

{ #category : #examples }
LeExampleToPngExporterExamples >> exportMethodCoder_Scripter [
	<gtExample>
	<return: #LeExampleToPngExporter>
	| anExample aFileReference anExporter |
	anExample := (GtPharoMethodCoderExamples >> #forThisMethodCoder) gtExample.
	aFileReference := FileSystem memory workingDirectory / 'picture.png'.

	anExporter := LeExampleToPngExporter new
			example: anExample;
			fileReference: aFileReference;
			previewSelector: #gtLiveFor:;
			withScripter;
			export.

	self
		assert: aFileReference exists
		description: [ 'File must exist: {1}' format: {aFileReference} ].
	self
		assert: aFileReference size isZero not
		description: [ 'File must not be empty: {1}' format: {aFileReference} ].

	^ anExporter
]
