"
I have examples of the options of {{gtClass:LeHtmlBookExportCommandLineHandler}}. They check the options without exporting a book.
"
Class {
	#name : #LeHtmlBookExportCommandLineHandlerExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

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
