Class {
	#name : #LeExportPictureResourceBuilder,
	#superclass : #LeExportResourceBuilder,
	#category : #'Lepiter-Export-Resources - Builders'
}

{ #category : #accessing }
LeExportPictureResourceBuilder >> visitExternalImageLink: anExternalImageLink [
	| anUrlUtility anAttachmentFile aPath aResourceState |
	
	"Ignore the link if the URL is empty"
	anExternalImageLink url trimBoth ifEmpty: [ ^ self ].
	
	"Prepare image src"
	anUrlUtility := LeUrlStringUtilityBuilder new
		database: snippet database;
		urlString: anExternalImageLink url;
		build;
		urlStringUtility.
	anUrlUtility isFile ifFalse: [ 
		self addResource: (LeExportExternalImageSnippetResource new
			snippet: snippet;
			source: anExternalImageLink;
			imgSrc: anUrlUtility asString).
		^ anExternalImageLink ].
		
	"Prepare file"
	anAttachmentFile := anUrlUtility asFileReference.
	aPath := self nextPathWithExtension: anAttachmentFile extension.
	
	aResourceState := anAttachmentFile exists
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState problemMessage: 'File does not exist' ].
	
	"Store the resource"
	self addResource: (LeExportFileImageSnippetResource new 
		snippet: snippet;
		source: anExternalImageLink;
		path: aPath;
		reference: anAttachmentFile;
		state: aResourceState).
]

{ #category : #accessing }
LeExportPictureResourceBuilder >> visitPictureSnippet: aLePictureSnippet [
	| anUrlUtility anAttachmentFile aPath aResourceState |
	
	"Prepare image src"
	anUrlUtility := aLePictureSnippet urlStringUtility.
	anUrlUtility isFile ifFalse: [ 
		self addResource: (LeExportExternalImageSnippetResource new
			snippet: aLePictureSnippet;
			imgSrc: aLePictureSnippet urlString).
		^ aLePictureSnippet ].
		
	"Prepare file"
	anAttachmentFile := anUrlUtility asFileReference.
	aPath := self nextPathWithExtension: anAttachmentFile extension.
	
	aResourceState := anAttachmentFile exists
		ifTrue: [ LeExportResourceState ready ]
		ifFalse: [ LeExportResourceState problemMessage: 'File does not exist' ].
	
	"Store the resource"
	self addResource: (LeExportFileImageSnippetResource new 
		snippet: aLePictureSnippet;
		path: aPath;
		reference: anAttachmentFile;
		state: aResourceState).
]
