"
Executable Markdown table parsing and regression examples.
"
Class {
	#name : #LeMarkdownTableExamples,
	#superclass : #Object,
	#category : #'Lepiter-Parser-Examples'
}

{ #category : #examples }
LeMarkdownTableExamples >> alignmentAndOptionalPipes [
	<gtExample>
	| root table |
	root := LeParser parse: 'left | middle | right | default', String lf,
		':--- | :---: | ---: | ---', String lf,
		'a | *b* | `c` | [[Page]]'.
	table := root parts first.
	self assert: table class equals: LeTableNode.
	self assert: table alignments asArray equals: #(left center right default).
	self assert: table rows first cells size equals: 4.
	self assert: (table rows first cells second parts anySatisfy: [ :each | each isKindOf: LeItalicNode ]).
	self assert: (table rows first cells third parts anySatisfy: [ :each | each isKindOf: LeInlineCodeNode ]).
	self assert: (table rows first cells fourth parts anySatisfy: [ :each | each isKindOf: LeDoubleBracketLinkNode ]).
	^ root
]

{ #category : #examples }
LeMarkdownTableExamples >> emptyCellsWithoutWhitespace [
	<gtExample>
	| root table |
	root := LeParser parse: '||x||', String lf, '|---|---|---|', String lf, '||||', String lf.
	table := root parts first.
	self assert: table header cells size equals: 3.
	self assert: table header cells first parts isEmpty.
	self assert: table rows first cells size equals: 3.
	table rows first cells do: [ :cell | self assert: cell parts isEmpty. self assert: cell source equals: '' ].
	^ root
]

{ #category : #examples }
LeMarkdownTableExamples >> escapedAndCodePipes [
	<gtExample>
	| root table |
	root := LeParser parse: '| a | b |', String lf, '| --- | --- |', String lf,
		'| a\|b | `c|d` |', String lf, '| ``a`|b`` | e |'.
	table := root parts first.
	self assert: table rows size equals: 2.
	table rows do: [ :row | self assert: row cells size equals: 2 ].
	self assert: table rows first cells second contentSource trimBoth equals: '`c|d`'.
	^ root
]

{ #category : #examples }
LeMarkdownTableExamples >> grammarProducesCompleteTree [
	<gtExample>
	| table |
	table := self sample.
	self assert: ((LeParser >> #reduceActionForTable1:) sourceCode includesSubstring: 'LeTableNode new').
	self assert: table header parent == table.
	self assert: table separator parent == table.
	table rows do: [ :row |
		self assert: row parent == table.
		row cells do: [ :cell |
			self assert: cell parent == row.
			self assert: cell text isNil.
			cell parts do: [ :part | self assert: part parent == cell ] ] ].
	^ table
]

{ #category : #examples }
LeMarkdownTableExamples >> headerOnlyAndEmptyCells [
	<gtExample>
	| root table |
	root := LeParser parse: '| | x | |', String lf, '|---|---|---|'.
	table := root parts first.
	self assert: table class equals: LeTableNode.
	self assert: table rows isEmpty.
	self assert: table header cells size equals: 3.
	self assert: table header cells first parts first source equals: ' '.
	^ root
]

{ #category : #examples }
LeMarkdownTableExamples >> nonTables [
	<gtExample>
	| root |
	{ 'a | b'. '| a | b |', String lf, '| -- | --- |'. '| a | b |', String lf, '| --- |'. '`a|b`', String lf, '---|---'. '| a | b |', String lf, '| --- | x |' } do: [ :source |
		root := LeParser parse: source.
		self assert: (root parts noneSatisfy: [ :each | each isKindOf: LeTableNode ]).
		self assert: root source equals: source ].
	^ root
]

{ #category : #examples }
LeMarkdownTableExamples >> sample [
	<gtExample>
	| source root table bold |
	source := '| | Before | Now |', String lf,
		'|---|---|---|', String lf,
		'| classes | 31,477 | 31,477 |', String lf,
		'| traits | 807 | 807 |', String lf,
		'| total | 32,284 | 32,284 |', String lf,
		'| methods | 340,322 | **340,319** |', String lf,
		'| methodsIncludingTraitCopies | 436,835 | **436,832** |'.
	root := LeParser parse: source.
	self assert: root parts size equals: 1.
	table := root parts first.
	self assert: table class equals: LeTableNode.
	self assert: table source equals: source.
	self assert: table header cells size equals: 3.
	self assert: table rows size equals: 5.
	self assert: table header cells first contentSource trimBoth isEmpty.
	bold := table rows fourth cells third parts detect: [ :each | each isKindOf: LeBoldNode ].
	self assert: bold source equals: '**340,319**'.
	self assert: bold parts first source equals: '340,319'.
	self assert: bold parent equals: table rows fourth cells third.
	self assert: table startPosition equals: 1.
	self assert: table stopPosition equals: source size.
	^ table
]

{ #category : #examples }
LeMarkdownTableExamples >> sourcePositionsAndTraversal [
	<gtExample>
	| table root |
	table := self sample.
	root := table topParent.
	table withAllNodesDo: [ :node |
		self assert: node startPosition >= table startPosition.
		self assert: node stopPosition <= table stopPosition.
		node allTokens do: [ :token |
			self assert: (root source copyFrom: token startPosition to: token stopPosition) equals: token value ] ].
	self assert: (table allNodesOfType: LeBoldNode) size equals: 2.
	self assert: (table allNodesOfType: LeTableCellNode) size equals: 21.
	LeContentNodeVisitor new accept: table.
	^ table
]

{ #category : #examples }
LeMarkdownTableExamples >> surroundingTextAndLineEndings [
	<gtExample>
	| root |
	{ String lf. String cr. String crlf } do: [ :eol |
		| table source |
		source := 'Before', eol, '| a | b |', eol, '| --- | --- |', eol, '| | **x** |', eol, 'After', eol.
		root := LeParser parse: source.
		table := root parts detect: [ :each | each isKindOf: LeTableNode ].
		self assert: table header cells size equals: 2.
		self assert: table rows size equals: 1.
		self assert: table startPosition equals: 'Before' size + eol size + 1.
		self assert: root parts first source equals: 'Before'.
		self assert: (table rows first cells second parts detect: [ :each | each isKindOf: LeBoldNode ]) source equals: '**x**'.
		self assert: root source equals: source ].
	^ root
]
