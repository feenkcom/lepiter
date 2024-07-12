Class {
	#name : #LeSnippetGroup,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'Lepiter-Snippets'
}

{ #category : #accessing }
LeSnippetGroup >> gtByPageFor: aView [
	<gtView>
	| groups list |
	^ aView explicit
		title: 'By page';
		stencil: [ groups := (self items groupedBy: #page) associations asAsyncStream
					collect: [ :each | 
						BrGroup new
							stream: each value asAsyncStream;
							domainObject: each key;
							itemStencil: [ BrVerticalPane new hMatchParent vFitContent ];
							itemDataBinder: [ :aPane :aSnippet | 
								| viewModel aSnippetElement |
								viewModel := aSnippet asSnippetViewModel.
								aSnippetElement := viewModel snippetView asElement.
								aSnippetElement snippetViewModel: viewModel.
								aPane removeChildren.
								aPane addChild: aSnippetElement ];
							shouldShowWithoutItems: true ].
			list := BrGroupedList new.
			list
				margin: (BlInsets all: 10);
				headerElementStencil: [ BrLabel new
						margin: (BlInsets top: 20);
						aptitude: (BrGlamorousLabelAptitude new foreground: Color gray)
								+ (BrStyleCommonAptitude new
										default: [ :aStyle | 
											aStyle
												geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
												border: BlBorder empty ];
										hovered: [ :aStyle | aStyle border: (BlBorder paint: list theme button hoveredBorderColor width: 1) ]);
						when: BlClickEvent
							do: [ :e | 
								| page |
								page := e currentTarget viewModel model.
								e currentTarget phlow spawnObject: page ] ];
				headerDataBinder: [ :aLabel :eachItem | 
					aLabel viewModel model: eachItem domainObject.
					aLabel text: eachItem domainObject title ];
				stream: groups ]
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
