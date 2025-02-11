Class {
	#name : #LeTextCoderSnippetViewModel,
	#superclass : #LePlainTextCoderSnippetViewModel,
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

{ #category : #'filter view' }
LeTextCoderSnippetViewModel >> updateHighlighter [
	(self findHighlighterFor: LeParser using: self leHighlighters)
		ifNotNil: [ :highlighter | 
			textCoderViewModel
				addStyler: highlighter;
				requestUpdateAddOns ]
]
