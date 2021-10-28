Class {
	#name : #LeUIUtility,
	#superclass : #Object,
	#category : 'Lepiter-UI-Utility'
}

{ #category : #'api - snippet elements' }
LeUIUtility class >> elementForSnippet: aSnippet [
	"I am for a testing purposes. 
	I should be used only in examples and other testing use cases"

	^ self elementForSnippetViewModel: aSnippet asSnippetViewModel
]

{ #category : #'api - snippet elements' }
LeUIUtility class >> elementForSnippetViewModel: aSnippetViewModel [
	"I am for a testing purposes. 
	I should be used only in examples and other testing use cases"
	| aSnippetElement |
	aSnippetElement := aSnippetViewModel snippetView asElement.
	aSnippetElement snippetViewModel: aSnippetViewModel.
	^ aSnippetElement 
]
