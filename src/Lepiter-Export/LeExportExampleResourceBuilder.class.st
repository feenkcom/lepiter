Class {
	#name : #LeExportExampleResourceBuilder,
	#superclass : #LeExportResourceBuilder,
	#category : #'Lepiter-Export-Resources - Builders'
}

{ #category : #accessing }
LeExportExampleResourceBuilder >> visitExampleSnippet: aLeExampleSnippet [
	| aFile aPath aHeight |
	
	"Prepare height"
	aHeight := aLeExampleSnippet previewHeight.
		
	"Prepare file"
	aPath := self nextPath.
	aFile := self nextFileReferenceTo: aPath.
	
	"Store the resource"
	self addResource: (LeExportExampleSnippetResource new 
		snippet: aLeExampleSnippet;
		path: aPath;
		reference: aFile;
		height: aHeight).
]
