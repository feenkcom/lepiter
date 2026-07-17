Class {
	#name : #LeTextCoderSnippetViewModel,
	#superclass : #LePlainTextCoderSnippetViewModel,
	#instVars : [
		'snippetElementStencil'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #'filter view' }
LeTextCoderSnippetViewModel >> collapsedTextPromise [
	^ self coderViewModel coderModel ast
		then: [ :each | 
			| string text index |
			string := self snippetModel contentAsString asString.
			text := string asRopedText.
			self
				highlightText: text
				ast: each ast
				using: self leHighlighters.
			index := self indexOfHighlightIn: text.
			LeSnippetStyler new
				snippetViewModel: self;
				style: text ast: each ast.
			text clipForPreviewAround: index ]
]

{ #category : #initialization }
LeTextCoderSnippetViewModel >> initializeTextCoderViewModel [
	textCoder := GtTextCoder new.
	textCoder parser: LeParser.
	textCoderViewModel := textCoder asCoderViewModel.
	textCoderViewModel completionStrategy: LeCompletionStrategy new.
	textCoderViewModel
		addStyler: (LeTextCoderStyler new
				lepiterStyler: (LeSnippetStyler new snippetViewModel: self))
]

{ #category : #'api - snippet model' }
LeTextCoderSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	
	self coderViewModel completionStrategy  database: self snippetModel database.
]

{ #category : #accessing }
LeTextCoderSnippetViewModel >> snippetElementClass [
	^ LeTextCoderSnippetElement
]

{ #category : #accessing }
LeTextCoderSnippetViewModel >> snippetElementStencil [
	<return: #LePlainTextSnippetElementStencil or: nil>
	^ snippetElementStencil
		ifNil: [ self class defaultSnippetElementStencilClass
				ifNotNil: [ :aClass | aClass new snippetElementClass: self snippetElementClass ] ]
]

{ #category : #accessing }
LeTextCoderSnippetViewModel >> snippetElementStencil: aStencil [
	self
		assert: [ (aStencil isKindOf: LePlainTextSnippetElementStencil)
				or: [ aStencil inheritsFrom: LePlainTextSnippetElementStencil ] ].

	snippetElementStencil := aStencil asStencil.
	snippetElementStencil snippetElementClass: self snippetElementClass
]

{ #category : #'filter view' }
LeTextCoderSnippetViewModel >> updateHighlighter [
	(self findHighlighterFor: LeParser using: self leHighlighters)
		ifNotNil: [ :highlighter | 
			textCoderViewModel
				addStyler: highlighter;
				requestUpdateAddOns ]
]
