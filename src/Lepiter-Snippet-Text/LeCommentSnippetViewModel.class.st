"
I am a view model for a {{gtClass:name=LeCommentSnippet}}.
I am like my parent, except that my element is a {{gtClass:name=LeCommentSnippetElement}}.

"
Class {
	#name : #LeCommentSnippetViewModel,
	#superclass : #LePlainTextCoderSnippetViewModel,
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #initialization }
LeCommentSnippetViewModel >> initializeTextCoderViewModel [
	textCoder := GtTextCoder new.
	textCoder parser: LeParser.
	textCoderViewModel := textCoder asCoderViewModel.
	textCoderViewModel completionStrategy: LeCompletionStrategy new.
	textCoderViewModel
		addStyler: (LeTextCoderStyler new
				lepiterStyler: (LeSnippetStyler new snippetViewModel: self))
]

{ #category : #testing }
LeCommentSnippetViewModel >> isHidden [
	^ self snippetModel isHidden
]

{ #category : #acccessing }
LeCommentSnippetViewModel >> snippetElementClass [
	^ LeCommentSnippetElement
]
