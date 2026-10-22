"
I have examples of {{gtClass:LeHtmlBookExporter}}. They export a small book that is kept in memory and check the HTML of its pages.
"
Class {
	#name : #LeHtmlBookExporterExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeHtmlBookExporterExamples >> bookWithBaseUrl [
	<gtExample>
	<return: #String>
	| anHtml |
	anHtml := self
			exportedMainPageHtmlWithTemplate: '<meta property="og:url" content="{{urlAttribute}}">'
			siteName: nil
			baseUrl: 'https://book.example.org'.

	self
		assert: anHtml = '<meta property="og:url" content="https://book.example.org/index.html">'
		description: [ 'The URL must be based on the base URL, but the HTML is {1}' format: {anHtml} ].

	^ anHtml
]

{ #category : #examples }
LeHtmlBookExporterExamples >> bookWithSiteName [
	<gtExample>
	<return: #String>
	| anHtml |
	anHtml := self exportedMainPageHtmlWithSiteName: 'Rewilding "Book"'.

	self
		assert: anHtml = '<meta property="og:site_name" content="Rewilding &quot;Book&quot;">'
		description: [ 'The exported site name must be escaped, but the HTML is {1}' format: {anHtml} ].

	^ anHtml
]

{ #category : #examples }
LeHtmlBookExporterExamples >> bookWithoutBaseUrl [
	<gtExample>
	<return: #String>
	| anHtml |
	anHtml := self
			exportedMainPageHtmlWithTemplate: '<meta property="og:url" content="{{urlAttribute}}">'
			siteName: nil
			baseUrl: nil.

	self
		assert: anHtml = '<meta property="og:url" content="https://book.gtoolkit.com/index.html">'
		description: [ 'The default base URL must be used, but the HTML is {1}' format: {anHtml} ].

	^ anHtml
]

{ #category : #examples }
LeHtmlBookExporterExamples >> bookWithoutSiteName [
	<gtExample>
	<return: #String>
	| anHtml |
	anHtml := self exportedMainPageHtmlWithSiteName: nil.

	self
		assert: anHtml = '<meta property="og:site_name" content="My book">'
		description: [ 'The name of the database must be used, but the HTML is {1}' format: {anHtml} ].

	^ anHtml
]

{ #category : #examples }
LeHtmlBookExporterExamples >> exportedMainPageHtmlWithSiteName: aSiteName [
	"The template writes only the site name."

	^ self
		exportedMainPageHtmlWithTemplate: '<meta property="og:site_name" content="{{siteNameAttribute}}">'
		siteName: aSiteName
		baseUrl: nil
]

{ #category : #examples }
LeHtmlBookExporterExamples >> exportedMainPageHtmlWithTemplate: aTemplate siteName: aSiteName baseUrl: aBaseUrl [
	"Export a book named 'My book' with one page and answer the HTML of that page."

	| someExamples |
	someExamples := LeContentExamples new.
	^ [ | aDatabase aPage anExporter theOutputs |
		aDatabase := someExamples basicDatabaseWithMonitor.
		aDatabase databaseName: 'My book'.
		aPage := LePage named: 'Main page'.
		aPage snippetBuilder
			string: 'Hello.';
			add.
		aDatabase addPage: aPage.
		anExporter := LeHtmlBookExporter new
				database: aDatabase;
				mainPage: aPage;
				piece: (LeHtmlGtBookPiece new
						template: aTemplate;
						yourself);
				siteName: aSiteName;
				baseUrl: aBaseUrl;
				integerSequencer;
				export;
				yourself.
		theOutputs := anExporter resources
				select: [ :each | each isKindOf: LeExportPageOutputResource ].
		self assert: theOutputs size = 1 description: [ 'One page must be exported' ].
		theOutputs first content ] ensure: [ someExamples stopDatabaseMonitor ]
]
