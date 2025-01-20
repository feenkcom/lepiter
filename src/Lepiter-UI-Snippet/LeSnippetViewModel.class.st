"
# Explicit snippet view model

"
Class {
	#name : #LeSnippetViewModel,
	#superclass : #LeAbstractSnippetViewModel,
	#category : #'Lepiter-UI-Snippet-! View Models'
}

{ #category : #'actions - utils' }
LeSnippetViewModel >> addChildOrSiblingSnippet: aNewSnippet [
	| insertCommand |
	
	insertCommand := self snippetModel 
		insertChildOrSiblingSnippetCommandFor: aNewSnippet.
		
	^ insertCommand execute insertedSnippet.
]

{ #category : #'actions - utils' }
LeSnippetViewModel >> addChildOrSiblingSnippetBasedOn: aSnippet [
	| insertCommand |
	
	insertCommand := self snippetModel 
		insertChildOrSiblingSnippetCommandOfType: aSnippet class.
	insertCommand appendSnippetState: aSnippet additionalStateForCopying.
		
	^ insertCommand execute insertedSnippet.
]

{ #category : #'actions - utils' }
LeSnippetViewModel >> addSnippetBeforeSelfBasedOn: aSnippet [
	| insertCommand |
	
	insertCommand := self snippetModel 
		insertSnippetBeforeSelfCommandOfType: aSnippet class.
	insertCommand appendSnippetState: aSnippet additionalStateForCopying.

	^ insertCommand execute insertedSnippet.
]

{ #category : #'filter view' }
LeSnippetViewModel >> collapsedElement [
	^ self collapsedElementClass new
]

{ #category : #'filter view' }
LeSnippetViewModel >> collapsedElementClass [
	^ LeCollapsedSummarySnippetElement
]

{ #category : #'filter view' }
LeSnippetViewModel >> collapsedTextPromise [
	^ [ | string text index |
	string := self snippetModel contentAsString asString.
	text := string asRopedText.
	self
		highlightText: text
		ast: (FileNode new
				lines: {SmaCCToken
							value: string
							start: 1
							ids: #()})
		using: self leHighlighters.
	index := self indexOfHighlightIn: text.
	text glamorousRegularFontAndSize.
	text clipForPreviewAround: index ] asAsyncPromise
]

{ #category : #'filter view' }
LeSnippetViewModel >> expandedElement [
	^ self expandedElementClass new padding: BlInsets empty
]

{ #category : #'filter view' }
LeSnippetViewModel >> expandedElementClass [
	^ self snippetElementClass
]

{ #category : #'filter view' }
LeSnippetViewModel >> findHighlighterFor: aParserClass using: highlightersDictionary [
	| parserClass |
	parserClass := aParserClass.
	[ highlightersDictionary at: parserClass ifPresent: [ :styler | ^ styler ].
	parserClass notNil ] whileTrue: [ parserClass := parserClass superclass ].
	^ nil
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionIndentFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Indent snippet';
		icon: BrGlamorousVectorIcons right;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 4;
		action: [ :aButton :aSnippetElement | self requestIndent ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionInspectSnippetFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Inspect Snippet Element';
		icon: BrGlamorousVectorIcons inspect;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 5;
		action: [ :aButton :aSnippetElement | aSnippetElement phlow spawnObject: aSnippetElement ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionInspectViewModelFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Inspect Snippet View Model';
		icon: BrGlamorousVectorIcons debug;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 6;
		action: [ :aButton :aSnippetElement | aSnippetElement phlow spawnObject: aSnippetElement snippetViewModel ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionMoveDownFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Move snippet down';
		icon: BrGlamorousVectorIcons down;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 2;
		action: [ :aButton :aSnippetElement | self requestMoveDown ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionMoveUpFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Move snippet up';
		icon: BrGlamorousVectorIcons up;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 1;
		action: [ :aButton :aSnippetElement | self requestMoveUp ]
]

{ #category : #'gt - extensions' }
LeSnippetViewModel >> gtActionUnindentFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Unindent snippet';
		icon: BrGlamorousVectorIcons left;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 3;
		action: [ :aButton :aSnippetElement | self requestUnindent ]
]

{ #category : #'filter view' }
LeSnippetViewModel >> highlightText: text ast: aSmaCCParseNode using: highlightersDictionary [
	(self
		findHighlighterFor: aSmaCCParseNode parserClass
		using: highlightersDictionary)
		ifNotNil: [ :styler | styler style: text ast: aSmaCCParseNode ]
]

{ #category : #'filter view' }
LeSnippetViewModel >> indexOfHighlightIn: aText [
	^ (1 to: aText size)
		detect: [ :i | (aText attributesAt: i) notEmpty ]
		ifNone: [ 1 ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> insertNewSnippet: aLeSnippet [
	"Add a new snippet that is either:
	- a sibling of the receiver if there are no children.
	- the first child of the receiver.
	Give focus to the newly created snippet"

	self snippetsCollectionDo: [ :aSnippetsCollection | 
		| newSnippet newSnippetUIModel |
	
		newSnippet := self addChildOrSiblingSnippet: aLeSnippet.
		
		newSnippetUIModel := aSnippetsCollection
			findOrCreateSnippetViewModel: newSnippet.
		newSnippetUIModel focusAfterCreation.
		aSnippetsCollection scrollToViewModel: newSnippetUIModel ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> insertNewSnippetOfType: aLeSnippetClass [
	"Add a new snippet that is either:
	- a sibling of the receiver if there are no children.
	- the first child of the receiver.
	Give focus to the newly created snippet"
	
	self snippetsCollectionDo: [ :aSnippetsCollection |
		| newSnippet newSnippetUIModel |
		
		newSnippet := self snippetModel 
			addChildOrSiblingSnippetOfClass: aLeSnippetClass.
		
		newSnippetUIModel := aSnippetsCollection 
			findOrCreateSnippetViewModel: newSnippet.
		newSnippetUIModel focusAfterCreation.
		aSnippetsCollection scrollToViewModel: newSnippetUIModel ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> removeSelf [
	| nextFocusedSnippet |
	
	nextFocusedSnippet := nil.
	self snippetsCollectionDo: [ :aSnippetsCollection |
		nextFocusedSnippet := self snippetModel locateNextFocusedSnippetAfterRemove ].
			
	self snippetModel removeSelfThroughCommand.
	
	nextFocusedSnippet ifNil: [ ^ self].
	self snippetsCollectionDo: [ :aSnippetsCollection | 
		(aSnippetsCollection findSnippetViewModel: nextFocusedSnippet) focused: true ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> requestIndent [
	"Indent the receiver in the receiver's page, 
	i.e. make it a child of the previous snippet.
	If this is the first snippet at the current level, 
	do not execute any command."

	self snippetModel canBeIndented ifTrue: [
		self snippetModel indentThroughCommand ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> requestMoveDown [
	"Move snippet down swapping it with a next sibling if it exists.
	Do not execute any command if not possible"

	self snippetModel canBeMovedDown ifTrue: [
		self snippetModel moveDownThroughCommand ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> requestMoveUp [
	"Move the snippet up swapping it with a previous sibling if possible.
	Do not execute any command if not possible."

	self snippetModel canBeMovedUp ifTrue: [
		self snippetModel moveUpThroughCommand ]
]

{ #category : #'api - actions' }
LeSnippetViewModel >> requestUnindent [
	"Unindent the receiver in the receiver's page, 
	i.e. make it follow its parent snippet.
	If this is a first level snippet, 
	do not execute any command."

	self snippetModel canBeUnindented ifTrue: [
		self snippetModel unindentThroughCommand ]
]

{ #category : #accessing }
LeSnippetViewModel >> uid [
	"Each snippet view model displayed in the snippets element should have a uid.
	By default we take the uid of the content, however, custom snippet view models are free to override it"
	<return: #LeUID>

	^ self snippetModel uid
]
