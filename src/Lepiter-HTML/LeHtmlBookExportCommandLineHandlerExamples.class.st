"
I have examples of the options of {{gtClass:LeHtmlBookExportCommandLineHandler}}. They check the options without exporting a book.
"
Class {
	#name : #LeHtmlBookExportCommandLineHandlerExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeHtmlBookExportCommandLineHandlerExamples >> baseUrlOption [
	<gtExample>
	<return: #LeHtmlBookExportCommandLineHandler>
	| aHandler |
	aHandler := self handlerWithArguments: #('exportbook' '--base-url= https://book.example.org ').

	self
		assert: aHandler optionBaseUrl = 'https://book.example.org'
		description: [ 'The base URL option must be trimmed, but it is {1}' format: {aHandler optionBaseUrl printString} ].

	^ aHandler
]

{ #category : #examples }
LeHtmlBookExportCommandLineHandlerExamples >> baseUrlOptionIsOptional [
	<gtExample>
	<return: #LeHtmlBookExportCommandLineHandler>
	| aHandler |
	aHandler := self handlerWithArguments: #('exportbook').

	self
		assert: aHandler optionBaseUrl isNil
		description: [ 'The base URL is not defined by default, the default of the URL piece is used' ].

	^ aHandler
]

{ #category : #examples }
LeHtmlBookExportCommandLineHandlerExamples >> glamorousToolkitBookSiteName [
	<gtExample>
	<return: #LeHtmlGtBookExportCommandLineHandler>
	| aHandler |
	aHandler := LeHtmlGtBookExportCommandLineHandler new
			commandLine: (CommandLineArguments withArguments: #('exportgtbook')).

	self
		assert: aHandler optionSiteName = 'gtoolkit book'
		description: [ 'The Glamorous Toolkit book keeps its site name, but it is {1}' format: {aHandler optionSiteName} ].

	^ aHandler
]

{ #category : #examples }
LeHtmlBookExportCommandLineHandlerExamples >> handlerClass [
	^ LeHtmlBookExportCommandLineHandler
]

{ #category : #examples }
LeHtmlBookExportCommandLineHandlerExamples >> handlerWithArguments: anArray [
	^ self handlerClass new
		commandLine: (CommandLineArguments withArguments: anArray)
]

{ #category : #examples }
LeHtmlBookExportCommandLineHandlerExamples >> siteNameOption [
	<gtExample>
	<return: #LeHtmlBookExportCommandLineHandler>
	| aHandler |
	aHandler := self handlerWithArguments: #('exportbook' '--site-name= Rewilding Book ').

	self
		assert: aHandler optionSiteName = 'Rewilding Book'
		description: [ 'The site name option must be trimmed, but it is {1}' format: {aHandler optionSiteName} ].

	^ aHandler
]

{ #category : #examples }
LeHtmlBookExportCommandLineHandlerExamples >> siteNameOptionIsOptional [
	<gtExample>
	<return: #LeHtmlBookExportCommandLineHandler>
	| aHandler |
	aHandler := self handlerWithArguments: #('exportbook').

	self
		assert: aHandler optionSiteName isNil
		description: [ 'The site name is not defined by default, the database name is used' ].

	^ aHandler
]
