Class {
	#name : #LePharoRewriteSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'rewriteElement'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Element'
}

{ #category : #private }
LePharoRewriteSnippetElement >> addStatementAfter: aNode [
	| stmt |
	stmt := self safePatternVariableIn: aNode basedOn: '``.Stmt'.
	self insertCodeInSearch: '.' , String cr , stmt at: aNode stopPosition + 1
]

{ #category : #private }
LePharoRewriteSnippetElement >> addStatementBefore: aNode [
	| stmt |
	stmt := self safePatternVariableIn: aNode basedOn: '``.Stmt'.
	self insertCodeInSearch: stmt , '.' , String cr at: aNode startPosition
]

{ #category : #private }
LePharoRewriteSnippetElement >> addStatementsAfter: aNode [
	| stmt |
	stmt := self safePatternVariableIn: aNode basedOn: '``@.Stmts'.
	self insertCodeInSearch: '.' , String cr , stmt at: aNode stopPosition + 1
]

{ #category : #private }
LePharoRewriteSnippetElement >> addStatementsBefore: aNode [
	| stmts |
	stmts := self safePatternVariableIn: aNode basedOn: '``@.Stmts'.
	self insertCodeInSearch: stmts , '.' , String cr at: aNode startPosition
]

{ #category : #private }
LePharoRewriteSnippetElement >> addTemporaryVariables: aNode [
	| vars code position |
	vars := self safePatternVariableIn: aNode basedOn: '`@temps'.
	code := '| ' , vars , ' |' , String cr.
	position := 1.
	self insertCodeInSearch: code at: position
]

{ #category : #private }
LePharoRewriteSnippetElement >> computeDuplicatesIn: anAst [
	| duplicates senders |
	duplicates := Dictionary new.
	senders := Dictionary new.
	anAst
		withAllNodesDo: [ :each | 
			each
				attributeNamed: #ocurrences
				put: ((duplicates at: each ifAbsentPut: [ OrderedCollection new ])
						add: each;
						yourself).
			(each isErrorNode not and: [ each isMessage ])
				ifTrue: [ each
						attributeNamed: #senders
						put: ((senders at: each ifAbsentPut: [ OrderedCollection new ])
								add: each;
								yourself) ] ]
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertAllToAny: aNode [
	| name |
	name := self safePatternVariableIn: aNode basedOn: '``@any'.
	self replaceAll: aNode with: name
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertAllToAnyMessage: aNode [
	| source messageAndArgs |
	source := self searchSource.
	messageAndArgs := (self safePatternSelectorIn: aNode basedOn: '`@msg:') , ' '
			, (self safePatternVariableIn: aNode basedOn: '``@args').
	(aNode attributeNamed: #senders ifAbsent: [ #() ])
		do: [ :each | 
			self
				convertMessage: each
				to: messageAndArgs
				in: source ].
	self snippet search: source asString.
	self
		convertReplacementSendsOf: aNode selector
		using: [ :each :s | 
			self
				convertMessage: each
				to: messageAndArgs
				in: s ]
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertAllToLiteral: aNode [
	| name |
	name := self safePatternVariableIn: aNode basedOn: '``#literal'.
	self replaceAll: aNode with: name
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertAllToMessage: aNode [
	| source newSelector pattern |
	source := self searchSource.
	pattern := aNode isBinary
			ifTrue: [ '`msg:' ]
			ifFalse: [ aNode selectorParts inject: '' into: [ :sum :each | sum , '`' , each source ] ].
	newSelector := self safePatternSelectorIn: aNode basedOn: pattern.
	(aNode attributeNamed: #senders ifAbsent: [ #() ])
		do: [ :each | 
			self
				convertMessage: each
				toSelector: newSelector
				in: source ].
	self snippet search: source asString.
	self
		convertReplacementSendsOf: aNode selector
		using: [ :each :s | 
			self
				convertMessage: each
				toSelector: newSelector
				in: s ]
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertAllToVariable: aNode [
	| name |
	name := self safePatternVariableIn: aNode basedOn: '`var'.
	self replaceAll: aNode with: name
]

{ #category : #private }
LePharoRewriteSnippetElement >> convertBlockArgs: aNode [
	| source args |
	source := self searchSource.
	args := self safePatternVariableIn: aNode basedOn: '`@args'.
	aNode bar isNil
		ifTrue: [ source insert: ':' , args , ' | ' at: aNode leftBracket stopPosition + 1 ]
		ifFalse: [ source
				replaceFrom: aNode variables first startPosition
				to: aNode variables last stopPosition
				with: args ].
	self snippet search: source asString
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertMessage: aNode to: messageAndArgs in: source [
	| needsParens |
	needsParens := aNode parent parent notNil
			and: [ aNode parent parent isMessage
					or: [ aNode parent parent isMessageSend or: [ aNode parent parent isCascade ] ] ].
	needsParens ifTrue: [ source insert: '(' at: aNode parent startPosition ].
	source
		replaceFrom: aNode startPosition
		to: aNode stopPosition
		with: messageAndArgs , (needsParens ifTrue: [ ')' ] ifFalse: [ '' ])
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertMessage: aNode toSelector: selector in: source [
	aNode isUnary
		ifTrue: [ source
				replaceFrom: aNode startPosition
				to: aNode stopPosition
				with: selector ]
		ifFalse: [ aNode selectorParts
				with: (selector findTokens: #($:))
				do: [ :kw :each | 
					source
						replaceFrom: kw startPosition
						to: kw stopPosition
						with: each , ':' ] ]
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertReplacementSendsOf: selector using: aBlock [
	| source ast originalSource |
	originalSource := self snippet replace.
	ast := self parseExpression: originalSource.
	source := SmaCCString on: originalSource.
	ast
		withAllNodesOfType: GtPharoMessageNode
		do: [ :each | each selector = selector ifTrue: [ aBlock value: each value: source ] ].
	self snippet replace: source asString
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertToAny: aNode [
	| source |
	(self isRepeated: aNode) ifFalse: [ ^ self convertAllToAny: aNode ].
	source := self searchSource.
	source
		replaceFrom: aNode startPosition
		to: aNode stopPosition
		with: (self safePatternVariableIn: aNode basedOn: '``@any').
	self snippet search: source asString
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertToAnyMessage: aNode [
	| source messageAndArgs |
	(aNode attributeNamed: #senders ifAbsent: [ #() ]) size = 1
		ifTrue: [ ^ self convertAllToAnyMessage: aNode ].
	source := self searchSource.
	messageAndArgs := (self safePatternSelectorIn: aNode basedOn: '`@msg:') , ' '
			, (self safePatternVariableIn: aNode basedOn: '``@args').
	self
		convertMessage: aNode
		to: messageAndArgs
		in: source.
	self snippet search: source asString
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertToLiteral: aNode [
	| source |
	(self isRepeated: aNode) ifFalse: [ ^ self convertAllToLiteral: aNode ].
	source := self searchSource.
	source
		replaceFrom: aNode startPosition
		to: aNode stopPosition
		with: (self safePatternVariableIn: aNode basedOn: '``#literal').
	self snippet search: source asString
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertToLiteralOfType: aNode [
	| source |
	source := self searchSource.
	source
		replaceFrom: aNode startPosition
		to: aNode stopPosition
		with: (self safePatternVariableIn: aNode basedOn: '``#literal')
				, ' `{:node | node value class = ' , aNode literalValue class name , '}'.
	self snippet search: source asString
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertToMessage: aNode [
	| source selector pattern |
	(aNode attributeNamed: #senders ifAbsent: [ #() ]) size = 1
		ifTrue: [ ^ self convertAllToMessage: aNode ].
	source := self searchSource.
	pattern := aNode isBinary
			ifTrue: [ '`msg:' ]
			ifFalse: [ aNode selectorParts inject: '' into: [ :sum :each | sum , '`' , each source ] ].
	selector := self safePatternSelectorIn: aNode basedOn: pattern.
	self
		convertMessage: aNode
		toSelector: selector
		in: source.
	self snippet search: source asString
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertToStatement: aNode [
	| source vars stmts1 stmts2 |
	source := self searchSource.
	vars := self safePatternVariableIn: aNode basedOn: '`@temps'.
	stmts1 := self safePatternVariableIn: aNode basedOn: '``@.Before'.
	stmts2 := self safePatternVariableIn: aNode basedOn: '``@.After'.
	source insert: '| ' , vars , ' |' , String cr , stmts1 , '.' , String cr at: 1.
	aNode isReturn ifFalse: [ source append: '.' , String cr , stmts2 ].
	self snippet search: source asString
]

{ #category : #actions }
LePharoRewriteSnippetElement >> convertToVariable: aNode [
	| source |
	(self isRepeated: aNode) ifFalse: [ ^ self convertAllToVariable: aNode ].
	source := self searchSource.
	source
		replaceFrom: aNode startPosition
		to: aNode stopPosition
		with: (self safePatternVariableIn: aNode basedOn: '`var').
	self snippet search: source asString
]

{ #category : #private }
LePharoRewriteSnippetElement >> createContextMenuContentFor: anElement isSearch: aBoolean [
	| menu source position |
	menu := BrGroupedList new.
	menu
		padding: (BlInsets
				top: 2
				left: 10
				bottom: 12
				right: 10).
	menu fitContent.
	menu stream: #() asAsyncStream.
	menu
		headerElementStencil: [ BrLabel new
				margin: (BlInsets top: 10);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ].
	menu
		headerDataBinder: [ :label :each | label text: (self descriptionFor: each domainObject) asRopedText ].
	source := anElement text asString.
	position := 0.
	anElement cursors do: [ :cursor | position := cursor position ].
	[ self
		menuGroupsFor: source
		at: position
		isSearch: aBoolean ] asAsyncPromise
		then: [ :items | 
			items asyncSimilarCopy hasNext await
				then: [ :bool | 
					menu
						enqueueTask: (BlTaskAction new
								action: [ bool
										ifTrue: [ menu stream: items ]
										ifFalse: [ menu dispatchEvent: BrDropdownHideWish new.
											menu fireEvent: BrContextMenuHideWish new ] ]) ] ].
	^ menu
]

{ #category : #initialization }
LePharoRewriteSnippetElement >> createLabel: aString [
	^ BrLabel new
		text: aString asRopedText;
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize
				foreground: Color gray;
				fontSize: 12);
		yourself
]

{ #category : #private }
LePharoRewriteSnippetElement >> createSourceEditor: anUpdateSymbol [
	| element completionStrategy completionController |
	element := BrEditor new.
	element vFitContent.
	element hMatchParent.
	element padding: (BlInsets all: 10).
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
	element userData at: #completionStrategy put: completionStrategy.
	^ element
]

{ #category : #private }
LePharoRewriteSnippetElement >> descriptionFor: aNode [
	| description |
	description := aNode source asString.
	description size > 40
		ifTrue: [ description := (description first: 40) , '...' ].
	^ ((description copyReplaceAll: String cr with: ' ')
		copyReplaceAll: String lf
		with: ' ') copyReplaceAll: '	' with: ' '
]

{ #category : #accessing }
LePharoRewriteSnippetElement >> filterDescriptors [
	snippetViewModel ifNil: [ ^ GtSearchFilter globalFilterDescriptors ].
	^ self snippet filterDescriptorsUsing: self snippetContext
]

{ #category : #initialization }
LePharoRewriteSnippetElement >> initialize [
	| searchEditor replaceEditor scopeElement filtersElement isMethodToggle |
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
	scopeElement addChild: filtersElement as: #filtersElement.
	scopeElement addChild: ((self createLabel: 'for:') margin: (BlInsets top: 5)).
	isMethodToggle := BrToggle new
			aptitude: BrGlamorousButtonExteriorAptitude + BrGlamorousButtonRectangularAptitude
					+ (BrGlamorousButtonLabelAptitude new defaultColor: Color black)
					+ BrGlamorousToggleBackgroundAptitude;
			fitContent;
			beSmallSize;
			margin: (BlInsets top: 5);
			label: 'Full methods';
			when: BrToggleActivatedEvent
				do: [ :anEvent | self snippet isMethodPattern: true ];
			when: BrToggleDeactivatedEvent
				do: [ :anEvent | self snippet isMethodPattern: false ].
	scopeElement addChild: isMethodToggle as: #methodToggle.
	rewriteElement addChild: scopeElement.
	searchEditor := self createSourceEditor: #updateSearch.
	searchEditor userData
		at: #completionStrategy
		ifPresent: [ :strategy | strategy hasImplicitVariables: true ].
	searchEditor when: BlBlurEvent do: [ :event | self updateReplaceVariables ].
	searchEditor
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				content: [ self createContextMenuContentFor: searchEditor isSearch: true ]).
	searchEditor
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination primaryR;
				repeatable: false;
				action: [ self renameSearchItem ]).
	rewriteElement addChild: searchEditor as: #searchEditor.
	rewriteElement
		addChild: (BrButton new
				margin: (BlInsets top: 3 bottom: 10);
				beSmallSize;
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons playinspect asElement;
				label: 'Search' asString;
				action: [ rewriteElement phlow
						spawnObject: (self snippet executeSearchInFilter: self searchFilter) ])
		as: #searchButton.
	rewriteElement addChild: (self createLabel: 'Replace with:').
	replaceEditor := self createSourceEditor: #updateReplace.
	replaceEditor
		addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
				content: [ self createContextMenuContentFor: replaceEditor isSearch: false ]).
	replaceEditor
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination primaryR;
				repeatable: false;
				action: [ self renameReplaceItem ]).
	rewriteElement addChild: replaceEditor as: #replaceEditor.
	rewriteElement
		addChild: (BrButton new
				margin: (BlInsets top: 3 bottom: 3);
				beSmallSize;
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons playinspect asElement;
				label: 'Replace' asString;
				action: [ (self snippet executeRewriteInFilter: self searchFilter)
						then: [ :obj | rewriteElement inUIProcessDo: [ rewriteElement phlow spawnObject: obj ] ] ])
		as: #replaceButton
]

{ #category : #private }
LePharoRewriteSnippetElement >> insertCodeInSearch: code at: position [
	| source |
	source := self searchSource.
	source insert: code at: position.
	self snippet search: source asString
]

{ #category : #testing }
LePharoRewriteSnippetElement >> isRepeated: aNode [
	^ (aNode attributeNamed: #ocurrences ifAbsent: [ #() ]) size > 1
]

{ #category : #private }
LePharoRewriteSnippetElement >> menuGroupsFor: aString at: anInteger isSearch: aBoolean [
	| ast node editor |
	aBoolean
		ifTrue: [ self searchEditorDo: [ :each | editor := each ] ]
		ifFalse: [ self replaceEditorDo: [ :each | editor := each ] ].
	ast := self parseExpression: aString.
	node := ast.
	ast
		allNodesDo: [ :each | (each sourceInterval includes: anInteger) ifTrue: [ node := each ] ].
	node ifNil: [ ast := node ].
	^ (({node} , node allParents) asAsyncStream
		collect: [ :each | 
			| items |
			items := aBoolean
					ifTrue: [ self searchMenuItemsFor: each at: anInteger ]
					ifFalse: [ self replaceMenuItemsFor: each ].
			items isEmpty
				ifTrue: [ nil ]
				ifFalse: [ BrGroup new
						stream: items asAsyncStream;
						domainObject: each;
						itemStencil: [ | label |
							label := BrLabel new.
							label margin: (BlInsets left: 15).
							label hMatchParent.
							label vFitContent.
							label
								aptitude: BrGlamorousLabelAptitude
										+ (BrStyleCommonAptitude new
												hovered: [ :aStyle | aStyle background: self theme item selectedColor ]).
							label
								when: BlClickEvent
								do: [ :event | 
									event consumed: true.
									label
										withAllParentsDetect: [ :e | e isKindOf: BrGroupedList ]
										ifFound: [ :menu | 
											menu fireEvent: BrDropdownHideWish new.
											menu fireEvent: BrContextMenuHideWish new ]
										ifNone: [  ].
									label userData
										at: #menuItem
										ifPresent: [ :item | item action cull: editor cull: event ] ].
							label
								when: BlMouseEnterEvent
								do: [ :anEvent | 
									label userData
										at: #menuItem
										ifPresent: [ :item | item hoverAction ifNotNil: [ :hover | hover cull: editor cull: anEvent ] ] ].
							label
								when: BlMouseLeaveEvent
								do: [ :anEvent | 
									label userData
										at: #menuItem
										ifPresent: [ :item | item leaveAction ifNotNil: [ :leave | leave cull: editor cull: anEvent ] ] ].
							label ];
						itemDataBinder: [ :label :item | 
							label text: item title asRopedText.
							label userData at: #menuItem put: item.
							label ];
						shouldShowWithoutItems: false ] ]) select: [ :each | each notNil ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> menuItem: aString for: aNode action: aBlock [
	^ GtCoderContextMenuAction new
		title: aString asRopedText;
		action: aBlock;
		hoverAction: [ :element | 
			(element editor text from: aNode startPosition to: aNode stopPosition)
				attributes: {GtPharoSourceCoder nodeHighlight} ];
		leaveAction: [ :element | element editor text removeAttribute: GtPharoSourceCoder nodeHighlight ];
		yourself
]

{ #category : #accessing }
LePharoRewriteSnippetElement >> nodeIn: aTextElement [
	| ast |
	aTextElement editor cursors
		do: [ :cursor | 
			| node |
			ast := self parseExpression: aTextElement editor text asString.
			node := nil.
			ast
				withAllNodesDo: [ :each | 
					(each sourceInterval includes: cursor position) ifTrue: [ node := each ].
					(each startPosition - 1 = cursor position
						and: [ cursor position = 0
								or: [ (aTextElement editor text at: cursor position) isSeparator ] ])
						ifTrue: [ node := each ] ].
			^ node ].
	^ nil
]

{ #category : #'api - snippet view model' }
LePharoRewriteSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	self updateSearchEditor.
	self updateReplaceEditor.
	self updateScope.
	self updateReplaceVariables.
	self updateMethodToggle
]

{ #category : #private }
LePharoRewriteSnippetElement >> parseExpression: aString [
	| ast |
	ast := GtPharoPatternParser
			parseWithErrors: aString
			startingAt: self startingStateForParser.
	self computeDuplicatesIn: ast.
	^ ast
]

{ #category : #initialization }
LePharoRewriteSnippetElement >> renameReplaceItem [
	self
		replaceEditorDo: [ :element | 
			(self nodeIn: element)
				ifNotNil: [ :node | 
					node isVariable ifTrue: [ ^ self renameReplaceVariable: node ].
					(node isMessage and: [ (self replaceSelectorPartIndexFor: node) > 0 ])
						ifTrue: [ ^ self renameReplaceSelector: node ] ] ]
]

{ #category : #initialization }
LePharoRewriteSnippetElement >> renameReplaceSelector: aNode [
	| position |
	position := self replaceSelectorPartIndexFor: aNode.
	self
		searchEditorDo: [ :searchElement | 
			self
				replaceEditorDo: [ :replaceElement | 
					| action searchIntervals replaceIntervals |
					searchIntervals := OrderedCollection
							with: (aNode selectorParts at: position) sourceInterval.
					(aNode attributeNamed: #senders)
						do: [ :each | 
							each == aNode
								ifFalse: [ searchIntervals add: (each selectorParts at: position) sourceInterval ] ].
					action := GtCompositeRenameAction
							locations: searchIntervals
							element: replaceElement.
					replaceIntervals := OrderedCollection new.
					(self parseExpression: searchElement editor text)
						allNodesOfType: GtPharoMessageNode
						do: [ :each | 
							each selector = aNode selector
								ifTrue: [ replaceIntervals add: (each selectorParts at: position) sourceInterval ] ].
					action addLocations: replaceIntervals to: searchElement editor.
					action install ] ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> renameReplaceVariable: aNode [
	self
		searchEditorDo: [ :searchElement | 
			self
				replaceEditorDo: [ :replaceElement | 
					| action intervals replaceIntervals |
					intervals := OrderedCollection with: aNode sourceInterval.
					(aNode attributeNamed: #ocurrences)
						do: [ :each | each == aNode ifFalse: [ intervals add: each sourceInterval ] ].
					action := GtCompositeRenameAction
							locations: intervals
							element: replaceElement.
					replaceIntervals := OrderedCollection new.
					(self parseExpression: searchElement editor text)
						allNodesOfType: GtPharoVariableNode
						do: [ :each | each = aNode ifTrue: [ replaceIntervals add: each sourceInterval ] ].
					action addLocations: replaceIntervals to: searchElement editor.
					action install ] ]
]

{ #category : #initialization }
LePharoRewriteSnippetElement >> renameSearchItem [
	self
		searchEditorDo: [ :element | 
			(self nodeIn: element)
				ifNotNil: [ :node | 
					node isVariable ifTrue: [ ^ self renameSearchVariable: node ].
					(node isMessage and: [ (self searchSelectorPartIndexFor: node) > 0 ])
						ifTrue: [ ^ self renameSearchSelector: node ] ] ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> renameSearchSelector: aNode [
	| position |
	position := self searchSelectorPartIndexFor: aNode.
	self
		searchEditorDo: [ :searchElement | 
			self
				replaceEditorDo: [ :replaceElement | 
					| action searchIntervals replaceIntervals |
					searchIntervals := OrderedCollection
							with: (aNode selectorParts at: position) sourceInterval.
					(aNode attributeNamed: #senders)
						do: [ :each | 
							each == aNode
								ifFalse: [ searchIntervals add: (each selectorParts at: position) sourceInterval ] ].
					action := GtCompositeRenameAction
							locations: searchIntervals
							element: searchElement.
					replaceIntervals := OrderedCollection new.
					(self parseExpression: replaceElement editor text)
						allNodesOfType: GtPharoMessageNode
						do: [ :each | 
							each selector = aNode selector
								ifTrue: [ replaceIntervals add: (each selectorParts at: position) sourceInterval ] ].
					action addLocations: replaceIntervals to: replaceElement editor.
					action install ] ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> renameSearchVariable: aNode [
	self
		searchEditorDo: [ :searchElement | 
			self
				replaceEditorDo: [ :replaceElement | 
					| action searchIntervals replaceIntervals |
					searchIntervals := OrderedCollection with: aNode sourceInterval.
					(aNode attributeNamed: #ocurrences)
						do: [ :each | each == aNode ifFalse: [ searchIntervals add: each sourceInterval ] ].
					action := GtCompositeRenameAction
							locations: searchIntervals
							element: searchElement.
					replaceIntervals := OrderedCollection new.
					(self parseExpression: replaceElement editor text)
						allNodesOfType: GtPharoVariableNode
						do: [ :each | each = aNode ifTrue: [ replaceIntervals add: each sourceInterval ] ].
					action addLocations: replaceIntervals to: replaceElement editor.
					action install ] ]
]

{ #category : #actions }
LePharoRewriteSnippetElement >> replaceAll: aNode with: name [
	| source |
	source := self searchSource.
	(aNode attributeNamed: #ocurrences)
		do: [ :each | 
			source
				replaceFrom: each startPosition
				to: each stopPosition
				with: name ].
	self snippet search: source asString.
	self updateReplaceExpressionMatching: aNode with: name
]

{ #category : #private }
LePharoRewriteSnippetElement >> replaceEditorDo: block [
	rewriteElement childNamed: #replaceEditor ifFound: block
]

{ #category : #private }
LePharoRewriteSnippetElement >> replaceMenuItemsFor: aNode [
	| items searchNode |
	items := OrderedCollection new.
	aNode isErrorNode ifTrue: [ ^ items ].
	aNode isVariable
		ifTrue: [ items
				add: (self
						menuItem: 'Rename variable'
						for: aNode
						action: [ self renameReplaceVariable: aNode ]).
			(aNode variableName beginsWith: '`') ifTrue: [ ^ items ] ].
	(aNode isMessage
		and: [ aNode selectorParts anySatisfy: [ :each | each source beginsWith: '`' ] ])
		ifTrue: [ ^ items ].
	(self parseExpression: self snippet search)
		withAllNodesDo: [ :each | each = aNode ifTrue: [ searchNode := each ] ].
	searchNode ifNil: [ ^ items ].
	aNode attributeNamed: #searchNode put: searchNode.
	(aNode isValueNode or: [ aNode isReturn ])
		ifTrue: [ self replaceMenuItemsForValue: aNode into: items ].
	aNode isLiteral ifTrue: [ self replaceMenuItemsForLiteral: aNode into: items ].
	aNode isVariable
		ifTrue: [ self replaceMenuItemsForVariable: aNode into: items ].
	aNode isMessageSend
		ifTrue: [ aNode message attributeNamed: #searchNode put: searchNode message.
			self replaceMenuItemsForMessage: aNode message into: items ].
	(aNode isMessage and: [ aNode parent isCascade ])
		ifTrue: [ self replaceMenuItemsForMessage: aNode into: items ].
	^ items
]

{ #category : #private }
LePharoRewriteSnippetElement >> replaceMenuItemsForLiteral: aNode into: items [
	| searchNode |
	searchNode := aNode attributeNamed: #searchNode.
	items
		add: (self
				menuItem: 'Match all occurrences as literal'
				for: aNode
				action: [ self convertAllToLiteral: searchNode ])
]

{ #category : #private }
LePharoRewriteSnippetElement >> replaceMenuItemsForMessage: aNode into: items [
	| searchNode |
	searchNode := aNode attributeNamed: #searchNode.
	items
		add: (self
				menuItem: 'Match any message for all senders'
				for: aNode
				action: [ self convertAllToAnyMessage: searchNode ]).
	items
		add: (self
				menuItem: 'Match ' , aNode arguments size printString
						, ' argument message for all senders'
				for: aNode
				action: [ self convertAllToMessage: searchNode ])
]

{ #category : #private }
LePharoRewriteSnippetElement >> replaceMenuItemsForValue: aNode into: items [
	| searchNode |
	searchNode := aNode attributeNamed: #searchNode.
	(searchNode parent notNil
		and: [ searchNode parent isSequence and: [ searchNode parent parent isNil ] ])
		ifFalse: [ items
				add: (self
						menuItem: 'Match all occurrences as anything'
						for: aNode
						action: [ self convertAllToAny: searchNode ]) ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> replaceMenuItemsForVariable: aNode into: items [
	| searchNode |
	searchNode := aNode attributeNamed: #searchNode.
	items
		add: (self
				menuItem: 'Match all occurrences as variable'
				for: aNode
				action: [ self convertAllToVariable: searchNode ])
]

{ #category : #private }
LePharoRewriteSnippetElement >> replaceSelectorPartIndexFor: aNode [
	self
		replaceEditorDo: [ :element | ^ self selectorPartIndexFor: aNode in: element ].
	^ 0
]

{ #category : #actions }
LePharoRewriteSnippetElement >> safePatternSelectorIn: aNode basedOn: aString [
	| selectors current index |
	selectors := Set new.
	aNode topParent
		withAllNodesDo: [ :each | 
			each isMessage
				ifTrue: [ selectors
						add: (each selectorParts inject: '' into: [ :sum :kw | sum , kw source ]) ] ].
	current := aString.
	index := 1.
	[ selectors includes: current ]
		whileTrue: [ current := aString last = $:
					ifTrue: [ aString allButLast , index printString , ':' ]
					ifFalse: [ aString , index printString ].
			index := index + 1 ].
	^ current
]

{ #category : #actions }
LePharoRewriteSnippetElement >> safePatternVariableIn: aNode basedOn: aString [
	| vars current index |
	vars := Set new.
	aNode topParent
		withAllNodesDo: [ :each | (each isKindOf: GtPharoVariableNode) ifTrue: [ vars add: each variableName ] ].
	current := aString.
	index := 1.
	[ vars includes: current ]
		whileTrue: [ current := aString , index printString.
			index := index + 1 ].
	^ current
]

{ #category : #initialization }
LePharoRewriteSnippetElement >> saveScope [
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

{ #category : #accessing }
LePharoRewriteSnippetElement >> scope [
	^ (snippetViewModel ifNotNil: [ self snippet ])
		ifNotNil: [ :snippet | snippet scope ]
]

{ #category : #accessing }
LePharoRewriteSnippetElement >> scopeLabel [
	^ ((snippetViewModel ifNotNil: [ self snippet ])
		ifNotNil: [ :snippet | snippet scope ifNotNil: [ :scope | scope trim ifEmpty: [ nil ] ] ])
		ifNil: [ 'All methods' ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchEditorDo: block [
	rewriteElement childNamed: #searchEditor ifFound: block
]

{ #category : #initialization }
LePharoRewriteSnippetElement >> searchFilter [
	| filters |
	filters := OrderedCollection new.
	rewriteElement
		childNamed: #filtersElement
		ifFound: [ :filtersElement | 
			filtersElement
				filtersDo: [ :descriptor :value | filters add: (descriptor newFilterWithValue: value) ] ].
	^ filters ifEmpty: [ nil ] ifNotEmpty: [ filters reduce: [ :a :b | a | b ] ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchMenuItemsFor: aNode at: anInteger [
	| items position |
	items := OrderedCollection new.
	aNode isErrorNode ifTrue: [ ^ items ].
	aNode isVariable
		ifTrue: [ items
				add: (self
						menuItem: 'Rename variable'
						for: aNode
						action: [ self renameSearchVariable: aNode ]).
			(aNode variableName beginsWith: '`') ifTrue: [ ^ items ] ].
	aNode isMessage
		ifTrue: [ (position := self searchSelectorPartIndexFor: aNode) > 0
				ifTrue: [ items
						add: (self
								menuItem: 'Rename selector'
								for: (aNode selectorParts at: position)
								action: [ self renameSearchSelector: aNode ]) ].
			(aNode selectorParts anySatisfy: [ :each | each source beginsWith: '`' ])
				ifTrue: [ ^ items ] ].
	(aNode isValueNode or: [ aNode isReturn ])
		ifTrue: [ self searchMenuItemsForValue: aNode into: items ].
	aNode isLiteral ifTrue: [ self searchMenuItemsForLiteral: aNode into: items ].
	aNode isVariable ifTrue: [ self searchMenuItemsForVariable: aNode into: items ].
	aNode isMessageSend
		ifTrue: [ self searchMenuItemsForMessage: aNode message into: items ].
	(aNode isMessage and: [ aNode parent isCascade ])
		ifTrue: [ self searchMenuItemsForMessage: aNode into: items ].
	aNode isBlock ifTrue: [ self searchMenuItemsForBlock: aNode into: items ].
	aNode isSequence
		ifTrue: [ self
				searchMenuItemsForSequence: aNode
				at: anInteger
				into: items ].
	^ items
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchMenuItemsForBlock: aNode into: items [ 
	items
		add: (self
				menuItem: 'Match block with any arguments'
				for: aNode
				action: [ self convertBlockArgs: aNode ]).
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchMenuItemsForLiteral: aNode into: items [
	items
		add: (self
				menuItem: 'Match literal'
				for: aNode
				action: [ self convertToLiteral: aNode ]).
	(self isRepeated: aNode)
		ifTrue: [ items
				add: (self
						menuItem: 'Match all occurrences as literal'
						for: aNode
						action: [ self convertAllToLiteral: aNode ]) ].
	items
		add: (self
				menuItem: 'Match literal of type ' , aNode literalValue class name
				for: aNode
				action: [ self convertToLiteralOfType: aNode ])
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchMenuItemsForMessage: aNode into: items [
	| hasMultiple |
	hasMultiple := (aNode attributeNamed: #senders ifAbsent: [ #() ]) size > 1.
	items
		add: (self
				menuItem: 'Match any message'
				for: aNode
				action: [ self convertToAnyMessage: aNode ]).
	hasMultiple
		ifTrue: [ items
				add: (self
						menuItem: 'Match any message for all senders'
						for: aNode
						action: [ self convertAllToAnyMessage: aNode ]) ].
	items
		add: (self
				menuItem: 'Match ' , aNode arguments size printString , ' argument message'
				for: aNode
				action: [ self convertToMessage: aNode ]).
	hasMultiple
		ifTrue: [ items
				add: (self
						menuItem: 'Match ' , aNode arguments size printString
								, ' argument message for all senders'
						for: aNode
						action: [ self convertAllToMessage: aNode ]) ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchMenuItemsForSequence: aNode at: anInteger into: items [
	| position previousWasList |
	(anInteger < aNode startPosition and: [ aNode variables isEmpty ])
		ifTrue: [ items
				add: (self
						menuItem: 'Add temporary variables'
						for: aNode
						action: [ self addTemporaryVariables: aNode ]) ].
	position := aNode leftBar
			ifNil: [ -1 ]
			ifNotNil: [ aNode rightBar stopPosition ].
	previousWasList := false.
	aNode statements
		doWithIndex: [ :each :i | 
			| isStatementList |
			isStatementList := each isErrorNode not
					and: [ each isVariable and: [ each isStatementListPattern ] ].
			(anInteger > position and: [ anInteger < each startPosition ])
				ifTrue: [ items
						add: (self
								menuItem: 'Add statement'
								for: aNode
								action: [ self addStatementBefore: each ]).
					(previousWasList or: [ isStatementList ])
						ifFalse: [ items
								add: (self
										menuItem: 'Add statements'
										for: aNode
										action: [ self addStatementsBefore: each ]) ] ].
			previousWasList := isStatementList.
			position := each stopPosition ].
	(aNode stopPosition <= anInteger
		and: [ aNode statements notEmpty
				and: [ aNode statements last isErrorNode or: [ aNode statements last isReturn not ] ] ])
		ifTrue: [ items
				add: (self
						menuItem: 'Add statement'
						for: aNode
						action: [ self addStatementAfter: aNode ]).
			previousWasList
				ifFalse: [ items
						add: (self
								menuItem: 'Add statements'
								for: aNode
								action: [ self addStatementsAfter: aNode ]) ] ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchMenuItemsForValue: aNode into: items [
	(aNode parent notNil
		and: [ aNode parent isSequence
				and: [ aNode parent parent isNil
						and: [ aNode parent statements size = 1 and: [ aNode parent variables isEmpty ] ] ] ])
		ifTrue: [ items
				add: (self
						menuItem: 'Match in sequence node'
						for: aNode
						action: [ self convertToStatement: aNode ]) ]
		ifFalse: [ items
				add: (self
						menuItem: 'Match anything'
						for: aNode
						action: [ self convertToAny: aNode ]).
			(self isRepeated: aNode)
				ifTrue: [ items
						add: (self
								menuItem: 'Match all occurrences as anything'
								for: aNode
								action: [ self convertAllToAny: aNode ]) ] ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchMenuItemsForVariable: aNode into: items [
	items
		add: (self
				menuItem: 'Match variable'
				for: aNode
				action: [ self convertToVariable: aNode ]).
	(self isRepeated: aNode)
		ifTrue: [ items
				add: (self
						menuItem: 'Match all occurrences as variable'
						for: aNode
						action: [ self convertAllToVariable: aNode ]) ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> searchSelectorPartIndexFor: aNode [
	self
		searchEditorDo: [ :element | ^ self selectorPartIndexFor: aNode in: element ].
	^ 0
]

{ #category : #actions }
LePharoRewriteSnippetElement >> searchSource [
	self searchEditorDo: [ :each | ^ SmaCCString on: each editor text asString ].
	^ SmaCCString new
]

{ #category : #private }
LePharoRewriteSnippetElement >> selectorPartIndexFor: aNode in: element [
	element editor cursors
		do: [ :each | 
			| parts |
			parts := aNode selectorParts.
			^ (1 to: parts size)
				detect: [ :i | 
					((parts at: i) sourceInterval includes: each position)
						or: [ (parts at: i) startPosition = (each position + 1) ] ]
				ifNone: [ 0 ] ].
	^ 0
]

{ #category : #'api - view' }
LePharoRewriteSnippetElement >> snippetContent [
	^ rewriteElement
]

{ #category : #initialization }
LePharoRewriteSnippetElement >> snippetContext [
	snippetViewModel snippetsCollectionDo: [ :each | ^ each sharedSnippetContext ].
	^ nil
]

{ #category : #'api - view' }
LePharoRewriteSnippetElement >> snippetToolbar [
	^ nil
]

{ #category : #'api - snippet view model' }
LePharoRewriteSnippetElement >> startingStateForParser [
	^ self snippet isMethodPattern
		ifTrue: [ GtPharoParser startingStateForMethod ]
		ifFalse: [ GtPharoParser startingStateForMethodSequence ]
]

{ #category : #private }
LePharoRewriteSnippetElement >> styler [
	| styler |
	styler := GtCompositeSmaCCASTStyler forParser: GtPharoPatternParser.
	styler stylers: {GtPharoPatternStyler new}.
	styler startingState: GtPharoParser startingStateForMethodSequence.
	^ styler
]

{ #category : #accessing }
LePharoRewriteSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	self snippetViewModel weak
		when: LePharoRewriteSnippetSearchChanged
			send: #updateSearchEditor
			to: self;
		when: LePharoRewriteSnippetReplaceChanged
			send: #updateReplaceEditor
			to: self;
		when: LePharoRewriteSnippetScopeChanged
			send: #updateScope
			to: self;
		when: LePharoRewriteSnippetIsMethodPatternChanged
			send: #updateMethodToggle
			to: self
]

{ #category : #accessing }
LePharoRewriteSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.
	self snippetViewModel unsubscribe: self
]

{ #category : #'api - snippet view model' }
LePharoRewriteSnippetElement >> updateMethodToggle [
	| isMethod startingState |
	isMethod := self snippet isMethodPattern.
	rewriteElement
		childNamed: #methodToggle
		ifFound: [ :toggle | 
			toggle isActivated = isMethod
				ifFalse: [ toggle activated: self snippet isMethodPattern ] ].
	startingState := self startingStateForParser.
	self
		searchEditorDo: [ :editor | 
			editor editor styler startingState: startingState.
			editor editor styleText.
			editor userData
				at: #completionStrategy
				ifPresent: [ :strategy | strategy isMethod: isMethod ] ].
	self
		replaceEditorDo: [ :editor | 
			editor editor styler startingState: startingState.
			editor editor styleText.
			editor userData
				at: #completionStrategy
				ifPresent: [ :strategy | strategy isMethod: isMethod ] ]
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

{ #category : #'api - snippet view model' }
LePharoRewriteSnippetElement >> updateReplaceEditor [
	rewriteElement
		childNamed: #replaceEditor
		ifFound: [ :editor | 
			editor editor text asString ~= self snippet replace
				ifTrue: [ editor editor text: self snippet replace asRopedText ] ]
]

{ #category : #actions }
LePharoRewriteSnippetElement >> updateReplaceExpressionMatching: aNode with: aString [
	| ast source originalSource |
	originalSource := self snippet replace.
	ast := self parseExpression: originalSource.
	source := SmaCCString on: originalSource.
	ast
		withAllNodesDo: [ :each | 
			each = aNode
				ifTrue: [ source
						replaceFrom: each startPosition
						to: each stopPosition
						with: aString ] ].
	self snippet replace: source asString
]

{ #category : #private }
LePharoRewriteSnippetElement >> updateReplaceVariables [
	| ast vars |
	ast := GtPharoPatternParser
			parseWithErrors: self snippet search
			startingAt: self startingStateForParser.
	vars := GtPrefixTree new.
	ast
		withAllNodesOfType: GtPharoVariableNode
		do: [ :node | (node name source beginsWith: '`') ifTrue: [ vars add: node name source ] ].
	self
		replaceEditorDo: [ :editor | 
			editor userData
				at: #completionStrategy
				ifPresent: [ :strategy | strategy patternVariables: vars ] ]
]

{ #category : #accessing }
LePharoRewriteSnippetElement >> updateScope [
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
LePharoRewriteSnippetElement >> updateSearch [
	self
		searchEditorDo: [ :editor | 
			| searchString |
			searchString := editor editor text asString.
			searchString ~= self snippet search
				ifTrue: [ self snippet search: searchString ] ]
]

{ #category : #'api - snippet view model' }
LePharoRewriteSnippetElement >> updateSearchEditor [
	rewriteElement
		childNamed: #searchEditor
		ifFound: [ :editor | 
			editor editor text asString ~= self snippet search
				ifTrue: [ editor editor text: self snippet search asRopedText.
					self updateReplaceVariables ] ]
]
