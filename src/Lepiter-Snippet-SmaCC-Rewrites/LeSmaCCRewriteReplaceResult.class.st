Class {
	#name : #LeSmaCCRewriteReplaceResult,
	#superclass : #Object,
	#instVars : [
		'fileResultsStream'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Model'
}

{ #category : #accessing }
LeSmaCCRewriteReplaceResult >> fileResultsStream [
	^ fileResultsStream ifNotNil: [ fileResultsStream asyncSimilarCopy ]
]

{ #category : #accessing }
LeSmaCCRewriteReplaceResult >> fileResultsStream: anAsyncStream [
	fileResultsStream := anAsyncStream cached
]

{ #category : #accessing }
LeSmaCCRewriteReplaceResult >> gtFilesListFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Files';
		items: [ self fileResultsStream ];
		column: 'File' text: [ :each | each file gtDisplayString ];
		column: 'Changed'
			text: [ :each | each hasChanges printString ]
			width: 100
]

{ #category : #accessing }
LeSmaCCRewriteReplaceResult >> gtResultsFor: aView [
	<gtView>
	^ aView explicit
		priority: 10;
		title: 'Changes';
		stencil: [ | pane applyButton changes |
			pane := BrVerticalPane new.
			pane matchParent.
			pane padding: (BlInsets all: 10).
			changes := GtPhlowView empty list
					items: [ self fileResultsStream select: [ :each | each hasChanges ] ];
					itemStencil: [ BrVerticalPane new
							vFitContentLimited;
							hMatchParent;
							margin: (BlInsets all: 1);
							background: Color white ];
					itemDataBinder: [ :element :each :i | 
						element
							removeChildren;
							addChild: each asElementWithExpander ].
			changes asElementDo: [ :element | pane addChild: element ].
			applyButton := BrButton new
					icon: BrGlamorousVectorIcons accept;
					beSmallSize;
					aptitude: BrGlamorousButtonWithIconAptitude new;
					label: 'Save';
					margin: (BlInsets
							top: 0
							left: 10
							bottom: 10
							right: 0);
					action: [ applyButton disable.
						(self fileResultsStream do: [ :each | each saveChanges ]) await
							then: [ :ignore | pane enqueueTask: [ applyButton enable ] asBlTask ]
							otherwise: [ :ex | 
								self inform: ex gtDisplayString.
								pane enqueueTask: [ applyButton enable ] asBlTask ] ];
					yourself.
			pane addChild: applyButton.
			pane ]
]
