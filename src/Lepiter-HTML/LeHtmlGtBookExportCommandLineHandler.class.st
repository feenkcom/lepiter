Class {
	#name : #LeHtmlGtBookExportCommandLineHandler,
	#superclass : #LeHtmlBookExportCommandLineHandler,
	#category : #'Lepiter-HTML-Command Line'
}

{ #category : #accessing }
LeHtmlGtBookExportCommandLineHandler class >> commandName [
	^ 'exportgtbook'
]

{ #category : #accessing }
LeHtmlGtBookExportCommandLineHandler class >> description [
	^ 'export Glamorous Toolkit book into HTML'
]
