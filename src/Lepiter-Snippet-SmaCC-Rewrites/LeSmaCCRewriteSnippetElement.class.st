Class {
	#name : #LeSmaCCRewriteSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'rewriteElement'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Element'
}

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> createDropDownButton: aString [
	| button |
	button := BrButton new.
	button
		aptitude: BrTextLabelAptitude new glamorousRegularFont glamorousCodeSmallSize
				+ BrGlamorousButtonIconAptitude + BrGlamorousButtonLayoutAptitude
				+ BrGlamorousButtonRectangularAptitude.
	button vExact: 20.
	button padding: (BlInsets left: 4 right: 2).
	button label: aString.
	button icon: BrGlamorousVectorIcons downwards.
	button beSmallSize.
	^ button
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> createLabel: aString [
	^ BrLabel new
		text: aString asRopedText;
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
				foreground: Color gray;
				fontSize: 12);
		yourself
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> createParserDropDown [
	| button dropDownLook |
	button := self createDropDownButton: self parserLabel.
	button background: BrGlamorousColors neutralBackgroundColor.
	dropDownLook := BrGlamorousWithExplicitDropdownAptitude
			handle: [ self createDropDownButton: self parserLabel ]
			content: [ BrSimpleList new
					vFitContentLimited;
					padding: (BlInsets all: 5);
					itemStencil: [ BrButton new
							beSmallSize;
							aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
							action: [ :aButton :aButtonModel | 
								button label: aButton label asString.
								self snippet parser: aButton label asString asSymbol.
								aButton fireEvent: BrDropdownHideWish new ] ];
					itemDataBinder: [ :element :each | element label: each name ];
					items: (SmaCCGLRParser availableParsers asSortedCollection: [ :a :b | a name < b name ]);
					yourself ].
	dropDownLook doNotHideWidget.
	button addAptitude: dropDownLook.
	button margin: (BlInsets top: 3).
	^ button
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> createSourceEditor: anUpdateSymbol [
	| element |
	element := BrEditor new.
	element vFitContent.
	element hMatchParent.
	element padding: (BlInsets all: 10).
	element
		aptitude: BrGlamorousCodeEditorAptitude + BrGlamorousEditableLabelAptitude.
	element editor
		when: BrTextEditorInsertedEvent do: [ :event | self perform: anUpdateSymbol ];
		when: BrTextEditorDeletedEvent do: [ :event | self perform: anUpdateSymbol ];
		when: BlInfiniteDataSourceChanged
			do: [ :event | self perform: anUpdateSymbol ].
	^ element
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> filterDescriptors [
	snippetViewModel ifNil: [ ^ #() ].
	^ self snippet filterDescriptorsUsing: self snippetContext
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> initialize [
	| searchEditor replaceEditor scopeElement filtersElement |
	super initialize.
	rewriteElement := BrVerticalPane new.
	rewriteElement padding: (BlInsets all: 5).
	rewriteElement vFitContent.
	rewriteElement hMatchParent.
	scopeElement := BrHorizontalPane new.
	scopeElement hMatchParent.
	scopeElement vFitContent.
	scopeElement margin: (BlInsets bottom: 2).
	scopeElement
		addChild: ((self createLabel: 'Search in:') margin: (BlInsets top: 5)).
	filtersElement := GtFiltersElement new.
	filtersElement hFitContent.
	filtersElement descriptors: [ self filterDescriptors ].
	filtersElement when: GtFiltersChangedEvent do: [ :event | self saveScope ].
	filtersElement padding: (BlInsets top: 1).
	scopeElement addChild: filtersElement as: #filtersElement.
	scopeElement addChild: ((self createLabel: 'using:') margin: (BlInsets top: 5)).
	scopeElement addChild: self createParserDropDown as: #parserButton.
	scopeElement addChild: BrHorizontalPane new fitContent as: #startingState.
	rewriteElement addChild: scopeElement.
	searchEditor := self createSourceEditor: #updateSearch.
	rewriteElement addChild: searchEditor as: #searchEditor.
	rewriteElement
		addChild: (BrButton new
				margin: (BlInsets top: 3 bottom: 10);
				beSmallSize;
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons playinspect asElement;
				label: 'Search' asString;
				action: [ rewriteElement phlow
						spawnObject: (self snippet executeSearchIn: self searchFiles) ])
		as: #searchButton.
	rewriteElement addChild: (self createLabel: 'Replace with:').
	replaceEditor := self createSourceEditor: #updateReplace.
	rewriteElement addChild: replaceEditor as: #replaceEditor.
	rewriteElement
		addChild: (BrButton new
				margin: (BlInsets top: 3 bottom: 3);
				beSmallSize;
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons playinspect asElement;
				label: 'Replace' asString;
				action: [ rewriteElement phlow
						spawnObject: (self snippet executeReplaceIn: self searchFiles) ])
		as: #replaceButton
]

{ #category : #accessing }
LeSmaCCRewriteSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	self updateSearchEditor.
	self updateReplaceEditor.
	self updateScope.
	self updateParser.
	self updateStartingState
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> parserClass [
	^ snippetViewModel ifNotNil: [ snippetViewModel snippetModel parserClass ]
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> parserLabel [
	^ (snippetViewModel ifNotNil: [ snippetViewModel snippetModel parser ])
		ifNil: [ 'Select parser' ]
]

{ #category : #private }
LeSmaCCRewriteSnippetElement >> replaceEditorDo: block [
	rewriteElement childNamed: #replaceEditor ifFound: block
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> saveScope [
	rewriteElement
		childNamed: #filtersElement
		ifFound: [ :filtersElement | 
			self snippet
				scope: (String
						streamContents: [ :stream | 
							stream nextPutAll: '#('.
							filtersElement
								filtersDo: [ :descriptor :value | 
									value
										ifNil: [ stream store: descriptor name ]
										ifNotNil: [ stream
												nextPutAll: '#(';
												store: descriptor name;
												space;
												store: value;
												nextPut: $) ].
									stream space ].
							stream nextPut: $) ]) ]
]

{ #category : #private }
LeSmaCCRewriteSnippetElement >> searchEditorDo: block [
	rewriteElement childNamed: #searchEditor ifFound: block
]

{ #category : #accessing }
LeSmaCCRewriteSnippetElement >> searchFiles [
	| files |
	files := OrderedCollection new.
	rewriteElement
		childNamed: #filtersElement
		ifFound: [ :filtersElement | 
			filtersElement
				filtersDo: [ :descriptor :value | 
					| ref |
					ref := descriptor newFilterWithValue: value.
					ref isCollection ifTrue: [ files addAll: ref ] ifFalse: [ files add: ref ] ] ].
	^ files
]

{ #category : #accessing }
LeSmaCCRewriteSnippetElement >> snippetContent [
	^ rewriteElement
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> snippetContext [
	snippetViewModel snippetsCollectionDo: [ :each | ^ each sharedSnippetContext ].
	^ nil
]

{ #category : #accessing }
LeSmaCCRewriteSnippetElement >> snippetToolbar [
	^ nil
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> startingStateIndex [
	^ (snippetViewModel
		ifNil: [ 1 ]
		ifNotNil: [ snippetViewModel snippetModel startingStateIndex ]) max: 1
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> startingStateLabel [
	^ (snippetViewModel ifNotNil: [ snippetViewModel snippetModel startingState ])
		ifNil: [ '*any*' ]
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	self snippetViewModel weak
		when: LeSmaCCRewriteSnippetSearchChanged
			send: #updateSearchEditor
			to: self;
		when: LeSmaCCRewriteSnippetReplaceChanged
			send: #updateReplaceEditor
			to: self;
		when: LeSmaCCRewriteSnippetScopeChanged
			send: #updateScope
			to: self;
		when: LeSmaCCRewriteSnippetParserChanged
			send: #updateParser
			to: self;
		when: LeSmaCCRewriteSnippetStartingStateChanged
			send: #updateStartingState
			to: self
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> updateParser [
	rewriteElement
		childNamed: #parserButton
		ifFound: [ :each | each label: self parserLabel ].
	self updateStyler
]

{ #category : #private }
LeSmaCCRewriteSnippetElement >> updateReplace [
	self
		replaceEditorDo: [ :editor | 
			| replaceString |
			replaceString := editor editor text asString.
			replaceString ~= self snippet replace
				ifTrue: [ self snippet replace: replaceString ] ]
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> updateReplaceEditor [
	rewriteElement
		childNamed: #replaceEditor
		ifFound: [ :editor | 
			editor editor text asString ~= self snippet replace
				ifTrue: [ editor editor text: self snippet replace asRopedText ] ]
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> updateScope [
	rewriteElement
		childNamed: #filtersElement
		ifFound: [ :filtersElement | 
			| descriptors |
			descriptors := self filterDescriptors.
			filtersElement clearFilters.
			self snippet
				filterDescriptorNamesAndValuesDo: [ :name :value | 
					(descriptors detect: [ :each | each name = name ] ifNone: [  ])
						ifNotNil: [ :descriptor | filtersElement addFilterForDescriptor: descriptor andValue: value ] ] ]
]

{ #category : #private }
LeSmaCCRewriteSnippetElement >> updateSearch [
	self
		searchEditorDo: [ :editor | 
			| searchString |
			searchString := editor editor text asString.
			searchString ~= self snippet search
				ifTrue: [ self snippet search: searchString ] ]
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> updateSearchEditor [
	rewriteElement
		childNamed: #searchEditor
		ifFound: [ :editor | 
			editor editor text asString ~= self snippet search
				ifTrue: [ editor editor text: self snippet search asRopedText ] ]
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> updateStartingState [
	rewriteElement
		childNamed: #startingState
		ifFound: [ :pane | 
			| button dropDownLook |
			pane removeChildren.
			self snippet parserClass
				ifNotNil: [ :cls | 
					pane addChild: ((self createLabel: 'as:') margin: (BlInsets top: 5)).
					button := self createDropDownButton: self startingStateLabel.
					button background: BrGlamorousColors neutralBackgroundColor.
					dropDownLook := BrGlamorousWithExplicitDropdownAptitude
							handle: [ self createDropDownButton: self startingStateLabel ]
							content: [ BrSimpleList new
									vFitContentLimited;
									padding: (BlInsets all: 5);
									itemStencil: [ BrButton new
											beSmallSize;
											aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonLabelAptitude;
											action: [ :aButton :aButtonModel | 
												button label: aButton label asString.
												self snippet startingState: aButton label asString asSymbol.
												aButton fireEvent: BrDropdownHideWish new ] ];
									itemDataBinder: [ :element :each | element label: each ];
									items: cls startingStateNames;
									yourself ].
					dropDownLook doNotHideWidget.
					button addAptitude: dropDownLook.
					button margin: (BlInsets top: 3).
					pane addChild: button ] ].
	self updateStyler
]

{ #category : #initialization }
LeSmaCCRewriteSnippetElement >> updateStyler [
	self parserClass
		ifNotNil: [ :cls | 
			self
				searchEditorDo: [ :editor | editor editor styler: (cls gtStyler startingState: self startingStateIndex) ] ]
]
