"
I am a view model for a {{gtClass:name=LeCommentSnippet}}.
I am like my parent, except that my element is a {{gtClass:name=LeCommentSnippetElement}}.

"
Class {
	#name : #LeCommentSnippetViewModel,
	#superclass : #LeTextCoderSnippetViewModel,
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #acccessing }
LeCommentSnippetViewModel >> snippetElementClass [
	^ LeCommentSnippetElement
]
