Class {
	#name : #LeSmaCCRewriteSearchResult,
	#superclass : #Object,
	#instVars : [
		'fileResultsStream',
		'parser',
		'directory',
		'lspModel'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Model'
}

{ #category : #accessing }
LeSmaCCRewriteSearchResult >> directory [
	^ directory
]

{ #category : #accessing }
LeSmaCCRewriteSearchResult >> directory: anObject [
	directory := anObject
]

{ #category : #accessing }
LeSmaCCRewriteSearchResult >> fileResultsStream [
	^ fileResultsStream ifNotNil: [ fileResultsStream asyncSimilarCopy ]
]

{ #category : #accessing }
LeSmaCCRewriteSearchResult >> fileResultsStream: anAsyncStream [
	fileResultsStream := anAsyncStream cached
]

{ #category : #accessing }
LeSmaCCRewriteSearchResult >> gtGroupedResultsView: aView [
	<gtView>
	^ aView explicit
		title: 'Grouped results';
		stencil: [ | list editor selectedItem highlightAttribute |
			highlightAttribute := BlTextDecorationAttribute new underline
					beNotOverwritableByStyler;
					color: BrGlamorousColors textHighlightColor;
					thickness: 3.
			editor := BrEditor new
					matchParent;
					beReadOnlyWithSelection;
					aptitude: BrShadowAptitude + BrGlamorousCodeEditorAptitude;
					background: Color white;
					margin: (BlInsets all: 10).
			list := BrGroupedList new.
			list
				margin: (BlInsets all: 10);
				background: Color white;
				when: BrSelectionChanged
					do: [ :event | 
						| newSelection |
						list
							selectedEntityDo: [ :each | newSelection := each isItem ifTrue: [ each object ] ].
						newSelection
							ifNotNil: [ (selectedItem isNil or: [ selectedItem topParent ~~ newSelection topParent ])
									ifTrue: [ newSelection parserClass
											ifNotNil: [ :cls | editor editor styler: cls gtStyler ].
										editor editor text: newSelection completeSource asRopedText ]
									ifFalse: [ editor editor text
											clearAttributes: [ :e | e == highlightAttribute ] ].
								selectedItem := newSelection.
								editor text
									attributes: {highlightAttribute}
									from: selectedItem startPosition
									to: selectedItem stopPosition.
								selectedItem
									gtScrollToPosition: selectedItem startPosition
									inEditor: editor ] ];
				headerElementStencil: [ BrLabel new
						hMatchParent;
						margin: (BlInsets top: 10);
						aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ];
				headerDataBinder: [ :label :each | label text: each domainObject file gtDisplayString ];
				stream: (self fileResultsStream
						collect: [ :each | 
							BrGroup new
								stream: each nodes;
								domainObject: each;
								itemStencil: [ BrLabel new
										padding: (BlInsets left: 10);
										hMatchParent;
										aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude ];
								itemDataBinder: [ :label :node | 
									label
										text: (String
												streamContents: [ :stream | stream nextPutAll: node source ]
												limitedTo: 100) ] ]).
			BrVerticalPane new
				matchParent;
				addChild: list;
				addChild: editor ]
]

{ #category : #accessing }
LeSmaCCRewriteSearchResult >> gtResultsView: aView [
	<gtView>
	^ aView columnedList
		title: 'Results';
		items: [ self fileResultsStream asyncSimilarCopy toArray wait ];
		column: 'File' text: [ :each | each file ];
		column: 'Nodes'
			text: [ :each | 
				| nodeCount |
				nodeCount := each nodes items size.
				nodeCount isZero ifTrue: [ '' ] ifFalse: [ nodeCount ] ]
			width: 100
]

{ #category : #accessing }
LeSmaCCRewriteSearchResult >> lspModel [
	^ lspModel
		ifNil: [ parser
				ifNotNil: [ parser gtLSPModelClass
						ifNotNil: [ :cls | lspModel := cls onDirectory: (self directory ifNil: [ '.' ]) ] ] ]
]

{ #category : #accessing }
LeSmaCCRewriteSearchResult >> parser [
	^ parser
]

{ #category : #accessing }
LeSmaCCRewriteSearchResult >> parser: anObject [
	parser := anObject
]
