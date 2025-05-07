Class {
	#name : #GtSearchSnippetItemType,
	#superclass : #GtSearchCodeEntityItemType,
	#category : #'Lepiter-Core-Filters'
}

{ #category : #api }
GtSearchSnippetItemType >> bindElement: aCoderElement toEntity: aCodeEntity fromFilter: aFilter [
	| viewModel |
	viewModel := self
			createViewModelForEntity: aCodeEntity
			fromFilter: aFilter .
	aCoderElement snippetViewModel: viewModel.
	^ aCoderElement
]

{ #category : #api }
GtSearchSnippetItemType >> createElement [ 
	^ LeExpandableSnippetElement new 
			padding: (BlInsets right: 5)
]

{ #category : #api }
GtSearchSnippetItemType >> createViewModelForEntity: aCodeEntity fromFilter: aFilter [
	| viewModel |
	viewModel := aCodeEntity asSnippetViewModel.
	viewModel leHighlighters: aFilter leHighlighters.
	^ viewModel
]
