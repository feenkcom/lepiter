Class {
	#name : #LeMarkdownExporterExamples,
	#superclass : #Object,
	#category : #'Lepiter-Markdown-Examples'
}

{ #category : #examples }
LeMarkdownExporterExamples >> exampleAnnotationLabel [
	<gtExample>
	| page exporter output |
	page := LePage named: 'Label only'.
	page
		addSnippet: (LeTextSnippet
				string: 'Size: {{gtExample:LeMarkdownExporterExamples>>#labelValue|label=#size}}.').
	exporter := LeMarkdownPageExporter new
			page: page;
			export.
	self assert: (exporter contents includesSubstring: 'Size: 3.').
	self assert: exporter diagnostics isEmpty.
	exporter context resources do: [ :each | self assert: each isOptionalResource ].
	output := FileSystem memory root.
	LeExportResourcesDirectorySaver new
		resources: exporter context resources;
		rootDirectory: output;
		save.
	self assert: output children isEmpty.
	^ exporter
]

{ #category : #examples }
LeMarkdownExporterExamples >> exampleAnnotationPreview [
	<gtExample>
	| page exporter resource |
	page := LePage named: 'Preview'.
	page
		addSnippet: (LeTextSnippet string: '{{gtExample:LeMarkdownExporterExamples>>#labelValue}}').
	exporter := LeMarkdownPageExporter new page: page.
	exporter buildResources.
	resource := nil.
	exporter context resources do: [ :each | resource := each ].
	self assert: resource isOptionalResource.
	exporter exportMarkdown.
	self assert: resource isOptionalResource not.
	self
		assert: (exporter contents
				includesSubstring: String lf , '![](<' , resource pathName , '>)' , String lf).
	^ exporter
]

{ #category : #examples }
LeMarkdownExporterExamples >> exampleSnippetLocalExport [
	<gtExample>
	| page output temporary snippet resources |
	page := LePage named: 'Example preview'.
	snippet := LeExampleSnippet new
			exampleBehaviorName: self class name;
			exampleSelector: #previewElement;
			noCode: true;
			previewExpanded: true.
	page addSnippet: snippet.
	temporary := GtTemporaryDirectory new.
	output := LeMarkdownPageExporter exportPage: page to: temporary reference.
	output optionAt: GtTemporaryDirectory put: temporary.
	self assert: (output pageFile contents includesSubstring: '![Example](<').
	self assert: output exporter diagnostics isEmpty.
	resources := OrderedCollection new.
	output resources
		do: [ :each | each source == snippet ifTrue: [ resources add: each ] ].
	self assert: resources size equals: 1.
	resources
		do: [ :each | 
			self assert: each state isReady.
			self assert: (output directory / each pathName) exists ].
	^ output
]

{ #category : #examples }
LeMarkdownExporterExamples >> externalPicture [
	<gtExample>
	| page exporter |
	page := LePage named: 'Picture'.
	page
		addSnippet: (LePictureSnippet new
				urlString: 'https://example.org/picture.png';
				caption: 'A [picture]').
	exporter := LeMarkdownPageExporter new
			page: page;
			export.
	self
		assert: (exporter contents
				includesSubstring: '![A \[picture\]](<https://example.org/picture.png>)').
	^ exporter
]

{ #category : #examples }
LeMarkdownExporterExamples >> inlineImage [
	<gtExample>
	| page exporter |
	page := LePage named: 'Inline image'.
	page
		addSnippet: (LeTextSnippet string: '![Caption](https://example.org/image.png)').
	exporter := LeMarkdownPageExporter new
			page: page;
			export.
	self
		assert: (exporter contents
				includesSubstring: '![Caption](<https://example.org/image.png>)').
	^ exporter
]

{ #category : #fixtures }
LeMarkdownExporterExamples >> labelValue [
	<gtExample>
	^ #(1 2 3)
]

{ #category : #examples }
LeMarkdownExporterExamples >> linkedBook [
	<gtExample>
	| database first second book |
	database := LeDatabase new.
	first := LePage named: 'First'.
	second := LePage named: 'Second'.
	first addSnippet: (LeTextSnippet string: 'Read [[Second]].').
	database
		addPage: first;
		addPage: second.
	book := LeMarkdownBookExporter new
			database: database;
			mainPage: first;
			export.
	self assert: book exporters size equals: 2.
	self
		assert: (book exporters
				anySatisfy: [ :each | each contents includesSubstring: '[Second](<' ]).
	self assert: (book exporters allSatisfy: [ :each | each diagnostics isEmpty ]).
	^ book
]

{ #category : #examples }
LeMarkdownExporterExamples >> localExportConvenience [
	<gtExample>
	| database page output temporary |
	database := LeDatabase new.
	page := LePage named: 'Local action'.
	page addSnippet: (LeTextSnippet string: 'A **local** export.').
	page
		addSnippet: (LePictureSnippet new
				urlString: 'https://example.org/image.png';
				caption: 'Image').
	database addPage: page.
	temporary := GtTemporaryDirectory new.
	output := LeMarkdownPageExporter exportPage: page to: temporary reference.
	output optionAt: GtTemporaryDirectory put: temporary.
	self assert: output pageFile exists.
	self assert: output pageFile extension equals: 'md'.
	self assert: output pageFile contents equals: output exporter contents.
	self
		assert: (output pageFile contents includesSubstring: 'A **local** export.').
	self assert: (output optionAt: GtTemporaryDirectory) == temporary.
	self
		assert: (output directory allChildren noneSatisfy: [ :each | each extension = 'html' ]).
	^ output
]

{ #category : #examples }
LeMarkdownExporterExamples >> localExportMarkdownViews [
	<gtExample>
	| output styled source |
	output := self localExportConvenience.
	styled := output gtMarkdownFor: GtPhlowView empty.
	source := output gtMarkdownContentsFor: GtPhlowView empty.
	self assert: styled title equals: 'Markdown'.
	self assert: source title equals: 'Markdown contents'.
	^ output
]

{ #category : #examples }
LeMarkdownExporterExamples >> localImageResolution [
	<gtExample>
	| output styler visitor resource |
	output := self exampleSnippetLocalExport.
	styler := LeLocalFileSnippetStyler new
			rootDirectory: output directory;
			snippetViewModel: LeTextSnippet new asSnippetViewModel.
	visitor := styler visitorForText: output pageFile contents asRopedText.
	resource := nil.
	output resources
		do: [ :each | (each isKindOf: LeExportExampleSnippetResource) ifTrue: [ resource := each ] ].
	self
		assert: (visitor resolveUrl: resource pathName) asFileReference
		equals: output directory / resource pathName.
	self
		assert: (visitor resolveUrl: '<' , resource pathName , '>') asFileReference
		equals: output directory / resource pathName.
	self assert: (visitor resolveUrl: resource pathName) asFileReference exists.
	self
		assert: (LeSnippetStyler new snippetViewModel: LeTextSnippet new asSnippetViewModel)
				imageRootDirectory
		equals: FileLocator workingDirectory resolve.
	styler style: output pageFile contents asRopedText.
	^ output
]

{ #category : #examples }
LeMarkdownExporterExamples >> localPictureSaved [
	<gtExample>
	| image page exporter output files |
	image := FileLocator temp / ('lepiter-markdown-' , UUID new asString , '.png').
	image binaryWriteStreamDo: [ :out | out nextPutAll: #[137 80 78 71] ].
	[ page := LePage named: 'Local picture'.
	page
		addSnippet: (LePictureSnippet new
				urlString: image resolve asUrl asString;
				caption: 'Local').
	exporter := LeMarkdownPageExporter new
			page: page;
			export.
	output := FileSystem memory root / 'export'.
	exporter saveToRootDirectory: output.
	files := output allChildren select: [ :each | each isFile ].
	self assert: (files anySatisfy: [ :each | each extension = 'md' ]).
	self assert: (files anySatisfy: [ :each | each extension = 'png' ]).
	self assert: (exporter contents includesSubstring: '![Local]') ]
		ensure: [ image ensureDelete ].
	^ exporter
]

{ #category : #fixtures }
LeMarkdownExporterExamples >> previewElement [
	<gtExample>
	^ BlElement new
		size: 40 @ 40;
		background: Color blue
]

{ #category : #examples }
LeMarkdownExporterExamples >> separateBookExportPhases [
	<gtExample>
	| database page book |
	database := LeDatabase new.
	page := LePage named: 'Separate book phases'.
	page addSnippet: (LeTextSnippet string: 'Some Markdown').
	database addPage: page.
	book := LeMarkdownBookExporter new
			database: database;
			mainPage: page.
	book buildResources.
	self assert: book exporters first contents isEmpty.
	book exportMarkdown.
	self assert: (book exporters first contents includesSubstring: 'Some Markdown').
	book assembleResources.
	^ book
]

{ #category : #examples }
LeMarkdownExporterExamples >> separatePageExportPhases [
	<gtExample>
	| page exporter resources |
	page := LePage named: 'Separate phases'.
	page
		addSnippet: (LePictureSnippet new
				urlString: 'https://example.org/image.png';
				caption: 'Image').
	exporter := LeMarkdownPageExporter new page: page.
	exporter buildResources.
	self assert: exporter contents isEmpty.
	resources := exporter context resources size.
	exporter exportMarkdown.
	self assert: exporter context resources size equals: resources.
	self assert: (exporter contents includesSubstring: '![Image]').
	exporter assembleResources.
	^ exporter
]

{ #category : #examples }
LeMarkdownExporterExamples >> textAndCode [
	<gtExample>
	| page exporter |
	page := LePage named: 'Markdown export'.
	page addSnippet: (LeTextSnippet string: '**bold** and _italic_').
	page addSnippet: (LePharoSnippet code: '"```" 1 + 2').
	exporter := LeMarkdownPageExporter new
			page: page;
			export.
	self assert: (exporter contents includesSubstring: '**bold** and _italic_').
	self assert: (exporter contents includesSubstring: '````smalltalk').
	self assert: exporter diagnostics isEmpty.
	^ exporter
]

{ #category : #examples }
LeMarkdownExporterExamples >> unresolvedLinkAndAnnotation [
	<gtExample>
	| page exporter |
	page := LePage named: 'Fallbacks'.
	page addSnippet: (LeTextSnippet string: '[[Missing]] {{gtClass:Object}}').
	exporter := LeMarkdownPageExporter new
			page: page;
			export.
	self assert: exporter diagnostics size equals: 2.
	self assert: (exporter contents includesSubstring: 'Missing').
	^ exporter
]
