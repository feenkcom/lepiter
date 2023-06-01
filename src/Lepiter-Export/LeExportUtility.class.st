Class {
	#name : #LeExportUtility,
	#superclass : #Object,
	#category : #'Lepiter-Export-Support'
}

{ #category : #accessing }
LeExportUtility class >> newSnippetElementFor: aSnippet [
	"Prepare snippet element"

	| aViewModel aSnippetElement |
	aViewModel := aSnippet asSnippetViewModel.
	aSnippetElement := aViewModel snippetView asElement.
	aSnippetElement snippetViewModel: aViewModel.

	^ aSnippetElement
]
