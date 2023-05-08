Class {
	#name : #LeHtmlBookNavigationExportPart,
	#superclass : #Object,
	#traits : 'TLeHtmlPageExportPart',
	#classTraits : 'TLeHtmlPageExportPart classTrait',
	#instVars : [
		'database',
		'pageLinks'
	],
	#category : #'Lepiter-HTML-Helpers'
}

{ #category : #accessing }
LeHtmlBookNavigationExportPart >> database [
	^ database
]

{ #category : #accessing }
LeHtmlBookNavigationExportPart >> database: anObject [
	database := anObject
]

{ #category : #'api - exporting' }
LeHtmlBookNavigationExportPart >> exportBodyContentPrecedingPart: aContext [
	"Export a content that is part of a HTML <body> tag 
	and precedes the main content (the page export)."

	LeHtmlBookNavigationExporter new
		database: database;
		pageLinks: pageLinks;
		selectedPage: aContext page;
		writeStream: aContext stream;
		export
]

{ #category : #accessing }
LeHtmlBookNavigationExportPart >> pageLinks [
	^ pageLinks
]

{ #category : #accessing }
LeHtmlBookNavigationExportPart >> pageLinks: anObject [
	pageLinks := anObject
]
