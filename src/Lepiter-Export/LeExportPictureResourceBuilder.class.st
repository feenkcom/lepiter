Class {
	#name : #LeExportPictureResourceBuilder,
	#superclass : #LeExportResouceBuilder,
	#category : #'Lepiter-Export-Resources - Builders'
}

{ #category : #accessing }
LeExportPictureResourceBuilder >> visitPictureSnippet: aLePictureSnippet [
	| anUrlUtility anAttachmentFile aPath aResourceState |
	
	"Prepare image src"
	anUrlUtility := aLePictureSnippet urlStringUtility.
	anUrlUtility isFile ifFalse: [ 
		self addLocalResource: (LeExportExternalImageSnippetResource new
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
