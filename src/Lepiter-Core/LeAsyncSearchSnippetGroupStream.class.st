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
		stencil: [ | highlighter leHighlighter |
			highlighter := self highlighter.
			leHighlighter := self leHighlighter.
			BrSimpleList new
				matchParent;
				stream: self asyncSimilarCopy;
				itemStencil: [ LeExpandableSnippetElement new padding: (BlInsets right: 5) ];
				itemDataBinder: [ :element :each | 
					| viewModel |
					viewModel := each asSnippetViewModel.
					highlighter ifNotNil: [ viewModel highlighter: highlighter ].
					leHighlighter ifNotNil: [ viewModel leHighlighter: leHighlighter ].
					element snippetViewModel: viewModel ];
				yourself ]
]
