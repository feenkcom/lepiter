Class {
	#name : #LeExportElementResourceBuilder,
	#superclass : #LeExportResourceBuilder,
	#instVars : [
		'elementHeight'
	],
	#category : #'Lepiter-Export-Resources - Builders'
}

{ #category : #visiting }
LeExportElementResourceBuilder >> visitElementSnippet: aLeElementSnippet [
	| aPath aFileReference aResource |
	
	"Compute height"
	elementHeight := LeExportUtility elementSnippetHeightFor: aLeElementSnippet.	
	
	"Prepare file"
	aPath := self nextPath.
	aFileReference := self nextFileReferenceTo: aPath.

	aResource := LeExportElementSnippetResource new
			snippet: snippet;
			element: objectSpecification object;
			path: aPath;
			height: elementHeight;
			reference: aFileReference.
			
	self addResource: aResource.

	^ aLeElementSnippet
]
