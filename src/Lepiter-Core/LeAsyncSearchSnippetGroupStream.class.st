Class {
	#name : #LeAsyncSearchSnippetGroupStream,
	#superclass : #GtAsyncSearchTypedGroupStream,
	#category : #'Lepiter-Core-Filters'
}

{ #category : #accessing }
LeAsyncSearchSnippetGroupStream >> gtItemsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Items' translated;
		priority: 10;
		stencil: [ | leHighlighters |
			leHighlighters := self leHighlighters.
			BrSimpleList new
				matchParent;
				stream: self asyncSimilarCopy;
				itemStencil: [ LeExpandableSnippetElement new padding: (BlInsets right: 5) ];
				itemDataBinder: [ :element :each | 
					| viewModel |
					viewModel := each asSnippetViewModel.
					viewModel leHighlighters: leHighlighters.
					element snippetViewModel: viewModel ];
				yourself ]
]
