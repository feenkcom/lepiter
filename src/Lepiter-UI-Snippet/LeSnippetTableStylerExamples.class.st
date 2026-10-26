"
Executable examples for Markdown table adornments and their columned list rendering.
"
Class {
	#name : #LeSnippetTableStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Examples'
}

{ #category : #examples }
LeSnippetTableStylerExamples >> adornmentBuildsList [
	<gtExample>
	| text attribute list |
	text := self styledTable.
	text findAttributesSuchThat: [ :each | (each isKindOf: BrTextAdornmentDynamicAttribute) and: [ each shouldAppend ] ] indicesDo: [ :start :end :each | attribute := each ].
	list := attribute stencil build.
	self assert: list class equals: BrColumnedList.
	self assert: list columns size equals: 3.
	^ list
]

{ #category : #examples }
LeSnippetTableStylerExamples >> alignedAndRaggedRows [
	<gtExample>
	| table list styler |
	table := (LeParser parse: 'left | middle | right', String lf, ':--- | :---: | ---:', String lf, 'a | b', String lf, 'c | d | e | extra') parts first.
	styler := self styler.
	list := styler tableElementFor: table.
	self assert: list columns size equals: 3.
	self assert: (styler tableCellTextFor: nil) asString equals: ''.
	#(left center right) do: [ :alignment | self assert: (styler tableLabelFor: table rows first cells first alignment: alignment) isNotNil ].
	list hExact: 600.
	^ list
]

{ #category : #examples }
LeSnippetTableStylerExamples >> boldCell [
	<gtExample>
	| table text |
	table := LeMarkdownTableExamples new sample.
	text := self styler tableCellTextFor: table rows fourth cells third.
	self assert: text asString equals: '**340,319**'.
	self assert: (text hasAttributeSuchThat: [ :attribute | attribute isKindOf: BlFontWeightAttribute ]).
	^ text
]

{ #category : #examples }
LeSnippetTableStylerExamples >> cellStylingPreservesOriginalTree [
	<gtExample>
	| table cell originalSource originalStart text |
	table := LeMarkdownTableExamples new sample.
	cell := table rows fourth cells third.
	originalSource := cell source.
	originalStart := cell startPosition.
	text := self styler tableCellTextFor: cell.
	self assert: text asString equals: originalSource trimBoth.
	self assert: cell source equals: originalSource.
	self assert: cell startPosition equals: originalStart.
	self assert: cell parent == table rows fourth.
	^ text
]

{ #category : #examples }
LeSnippetTableStylerExamples >> renderedSampleList [
	<gtExample>
	| scripter |
	scripter := BlScripter new element: self sampleList.
	scripter checkStep: [ :step |
		step label: 'Table rows and headers are rendered';
			satisfies: [ :list | list children notEmpty and: [ list items size = 5 ] ] ].
	^ scripter
]

{ #category : #examples }
LeSnippetTableStylerExamples >> sampleList [
	<gtExample>
	| table list |
	table := LeMarkdownTableExamples new sample.
	list := self styler tableElementFor: table.
	self assert: list class equals: BrColumnedList.
	self assert: list columns size equals: table header cells size.
	self assert: list items asArray equals: table rows asArray.
	list hExact: 760.
	^ list
]

{ #category : #examples }
LeSnippetTableStylerExamples >> showMarkup [
	<gtExample>
	| source text |
	source := '| a | b |', String lf, '| --- | --- |', String lf, '| c | d |'.
	text := source asRopedText.
	self styler showMarkup: true; style: text ast: (LeParser parse: source).
	text findAttributesSuchThat: [ :attribute | attribute isKindOf: BrTextAdornmentDynamicAttribute ] indicesDo: [ :start :end :attribute | self assert: false ].
	self assert: text asString equals: source.
	^ text
]

{ #category : #examples }
LeSnippetTableStylerExamples >> sourceRevealedOnCursorEnter [
	<gtExample>
	| text editor cursorAttribute previews |
	text := self styledTable.
	editor := BrEditor new text: text; yourself.
	text findAttributesSuchThat: [ :each | each isKindOf: BrTextCursorDynamicAttribute ] indicesDo: [ :start :end :each | cursorAttribute := each ].
	editor editor moveCursorTo: 0.
	cursorAttribute enterAction value: editor.
	self assert: (text hasAttributeSuchThat: [ :each | (each isKindOf: BrTextAdornmentDynamicAttribute) and: [ each shouldReplace ] ]) not.
	previews := OrderedCollection new.
	text findAttributesSuchThat: [ :each | (each isKindOf: BrTextAdornmentDynamicAttribute) and: [ each shouldAppend ] ] indicesDo: [ :start :end :each | previews add: each ].
	self assert: previews size equals: 1.
	cursorAttribute leaveAction value: editor.
	self assert: (text hasAttributeSuchThat: [ :each | (each isKindOf: BrTextAdornmentDynamicAttribute) and: [ each shouldReplace ] ]).
	self assert: text asString equals: LeMarkdownTableExamples new sample source.
	^ editor
]

{ #category : #examples }
LeSnippetTableStylerExamples >> styledTable [
	<gtExample>
	| table text replacements previews |
	table := LeMarkdownTableExamples new sample.
	text := table source asRopedText.
	self styler style: text ast: table topParent.
	replacements := OrderedCollection new.
	previews := OrderedCollection new.
	text findAttributesSuchThat: [ :attribute | (attribute isKindOf: BrTextAdornmentDynamicAttribute) and: [ attribute shouldReplace ] ] indicesDo: [ :start :end :attribute | replacements add: (start to: end) ].
	text findAttributesSuchThat: [ :attribute | (attribute isKindOf: BrTextAdornmentDynamicAttribute) and: [ attribute shouldAppend ] ] indicesDo: [ :start :end :attribute | previews add: (start to: end) ].
	self assert: replacements first first equals: table startPosition.
	self assert: replacements last last equals: table stopPosition.
	self assert: (replacements sum: #size) equals: table source size.
	self assert: previews asArray equals: { table stopPosition to: table stopPosition }.
	self assert: text asString equals: table source.
	^ text
]

{ #category : #accessing }
LeSnippetTableStylerExamples >> styler [
	^ LeSnippetStyler new snippetViewModel: LeTextSnippet new asSnippetViewModel; yourself
]

{ #category : #examples }
LeSnippetTableStylerExamples >> tableAfterBoldAndBlankLines [
	<gtExample>
	| source text root table previews |
	source := 'asdasd a **aa**', String lf, ' ', String lf, String lf,
		'| | Before | Now |', String lf,
		'|---|---|---|', String lf,
		'| classes | 31,477 | 31,477 |', String lf,
		'| traits | 807 | 807 |', String lf,
		'| total | 32,284 | 32,284 |', String lf,
		'| methods | 340,322 | **340,319** |', String lf,
		'| methodsIncludingTraitCopies | 436,835 | **436,832** | ', String lf.
	root := LeParser parse: source.
	table := root parts detect: [ :part | part isKindOf: LeTableNode ].
	self assert: table rows size equals: 5.
	text := source asRopedText.
	self styler privateStyle: text.
	previews := OrderedCollection new.
	text findAttributesSuchThat: [ :each | (each isKindOf: BrTextAdornmentDynamicAttribute) and: [ each shouldAppend ] ] indicesDo: [ :start :end :attribute | previews add: attribute ].
	self assert: previews size equals: 1.
	previews first stencil build.
	self assert: text asString equals: source.
	^ text
]

{ #category : #examples }
LeSnippetTableStylerExamples >> tables [
	<gtExample>
	"An editor containing two rendered tables and the surrounding prose.
	Move the cursor next to a table to reveal its editable Markdown source."
	| source text root tables previews editor |
	source := 'Before and now', String lf,
		LeMarkdownTableExamples new sample source, String lf, String lf,
		'Column justification', String lf,
		LeMarkdownTableExamples new columnJustification source, String lf, String lf,
		'Place the cursor next to a table to edit its Markdown.'.
	root := LeParser parse: source.
	tables := root parts select: [ :part | part isKindOf: LeTableNode ].
	self assert: tables size equals: 2.
	text := source asRopedText.
	self styler style: text ast: root.
	previews := OrderedCollection new.
	text findAttributesSuchThat: [ :each |
		(each isKindOf: BrTextAdornmentDynamicAttribute) and: [ each shouldAppend ] ]
		indicesDo: [ :start :end :attribute | previews add: attribute ].
	self assert: previews size equals: tables size.
	self assert: text asString equals: source.
	editor := BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude;
		text: text;
		size: 800 @ 600;
		yourself.
	^ editor
]
