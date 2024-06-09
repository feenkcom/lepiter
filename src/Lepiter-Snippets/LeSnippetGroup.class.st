Class {
	#name : #LeSnippetGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'Lepiter-Snippets'
}

{ #category : #accessing }
LeSnippetGroup >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ BrSimpleList new
				matchParent;
				items: self items;
				itemStencil: [ BrVerticalPane new
						hMatchParent;
						padding: (BlInsets all: 10);
						vFitContent ];
				itemDataBinder: [ :aPane :aSnippet | 
					| viewModel aSnippetElement |
					viewModel := aSnippet asSnippetViewModel.
					aSnippetElement := viewModel snippetView asElement.
					aSnippetElement snippetViewModel: viewModel.
					aPane removeChildren.
					aPane
						addChild: (BrLabel new
								aptitude: (BrGlamorousLabelAptitude new foreground: Color gray)
										+ (BrStyleCommonAptitude new
												default: [ :aStyle | 
													aStyle
														geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
														border: BlBorder empty ];
												hovered: [ :aStyle | aStyle border: (BlBorder paint: aPane theme button hoveredBorderColor width: 1) ]);
								when: BlClickEvent do: [:e | e target phlow spawnObject: aSnippet page ];
								text: aSnippet page title).
					aPane addChild: aSnippetElement ] ]
]

{ #category : #accessing }
LeSnippetGroup >> gtSnippetsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Snippets';
		items: [ self items ];
		column: 'Snippet' text: #gtDisplayString;
		column: 'Page' text: [:each | each page gtDisplayString ];
		contextItemLabel: 'Inspect page' action: [ :widget :each | widget phlow spawnObject: each page ]
]
