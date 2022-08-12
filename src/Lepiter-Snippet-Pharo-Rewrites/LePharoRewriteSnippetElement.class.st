Class {
	#name : #LePharoRewriteSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'rewriteElement'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Element'
}

{ #category : #private }
LePharoRewriteSnippetElement >> createSourceEditor: anUpdateSymbol [
	| element completionStrategy completionController |
	element := BrEditor new.
	element vFitContent.
	element hMatchParent.
	element
		aptitude: BrGlamorousCodeEditorAptitude + BrGlamorousEditableLabelAptitude.
	element editor
		styler: self styler;
		when: BrTextEditorInsertedEvent do: [ :event | self perform: anUpdateSymbol ];
		when: BrTextEditorDeletedEvent do: [ :event | self perform: anUpdateSymbol ];
		when: BlInfiniteDataSourceChanged
			do: [ :event | self perform: anUpdateSymbol ].
	completionStrategy := GtPharoPatternCompletionStrategy new.
	completionStrategy isMethod: false.
	completionController := GtCompletionController
			on: element
			strategy: completionStrategy.
	completionController install.
	^ element
]

{ #category : #initialization }
LePharoRewriteSnippetElement >> initialize [
	super initialize.
	rewriteElement := BrVerticalPane new.
	rewriteElement padding: (BlInsets all: 5).
	rewriteElement vFitContent.
	rewriteElement hMatchParent.
	rewriteElement
		addChild: (BrLabel new
				text: 'Search:' asRopedText;
				aptitude: BrGlamorousLabelAptitude;
				yourself).
	rewriteElement
		addChild: (self createSourceEditor: #updateSearch)
		as: #searchEditor.
	rewriteElement
		addChild: (BrButton new
				margin: (BlInsets top: 3 bottom: 3);
				beSmallSize;
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons playinspect asElement;
				label: 'Search' asString;
				action: [ rewriteElement phlow spawnObject: self snippet executeSearch ])
		as: #searchButton.
	rewriteElement
		addChild: (BrLabel new
				text: 'Replace:' asRopedText;
				aptitude: BrGlamorousLabelAptitude;
				yourself).
	rewriteElement
		addChild: (self createSourceEditor: #updateReplace)
		as: #replaceEditor.
	rewriteElement
		addChild: (BrButton new
				margin: (BlInsets top: 3 bottom: 3);
				beSmallSize;
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons playinspect asElement;
				label: 'Replace' asString;
				action: [ rewriteElement phlow spawnObject: self snippet executeRewrite ])
		as: #replaceButton
]

{ #category : #'api - snippet view model' }
LePharoRewriteSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	rewriteElement
		childNamed: #searchEditor
		ifFound: [ :editor | 
			editor editor text asString ~= self snippet search
				ifTrue: [ editor editor text: self snippet search asRopedText ] ].
	rewriteElement
		childNamed: #replaceEditor
		ifFound: [ :editor | 
			editor editor text asString ~= self snippet replace
				ifTrue: [ editor editor text: self snippet replace asRopedText ] ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> replaceEditorDo: block [
	rewriteElement childNamed: #replaceEditor ifFound: block
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchEditorDo: block [
	rewriteElement childNamed: #searchEditor ifFound: block
]

{ #category : #'api - view' }
LePharoRewriteSnippetElement >> snippetContent [
	^ rewriteElement
]

{ #category : #'api - view' }
LePharoRewriteSnippetElement >> snippetToolbar [
	^ nil
]

{ #category : #private }
LePharoRewriteSnippetElement >> styler [
	| styler |
	styler := GtCompositeSmaCCASTStyler forParser: GtPharoPatternParser.
	styler stylers: {GtPharoPatternStyler new}.
	styler startingState: GtPharoParser startingStateForMethodSequence.
	^ styler
]

{ #category : #private }
LePharoRewriteSnippetElement >> updateReplace [
	self
		replaceEditorDo: [ :editor | 
			| replaceString |
			replaceString := editor editor text asString.
			replaceString ~= self snippet replace
				ifTrue: [ self snippet replace: replaceString ] ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> updateSearch [
	self
		searchEditorDo: [ :editor | 
			| searchString |
			searchString := editor editor text asString.
			searchString ~= self snippet search
				ifTrue: [ self snippet search: searchString ] ]
]
