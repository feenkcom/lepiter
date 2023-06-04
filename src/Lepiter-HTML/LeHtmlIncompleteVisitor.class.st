Class {
	#name : #LeHtmlIncompleteVisitor,
	#superclass : #LeHtmlVisitor,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #visiting }
LeHtmlIncompleteVisitor >> visitElementSnippet: aLeElementSnippet [
	"It overrides the method with the purpose to test use cases when unsupported snippets are supposed to be exported"

	^ self visitSnippet: aLeElementSnippet
]
