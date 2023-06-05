Class {
	#name : #LeExportIncompleteVisitor,
	#superclass : #LeExportVisitor,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #visiting }
LeExportIncompleteVisitor >> visitElementSnippet: aLeElementSnippet [
	"It overrides the method with the purpose to test use cases when unsupported snippets are supposed to be exported"

	^ self visitSnippet: aLeElementSnippet
]
