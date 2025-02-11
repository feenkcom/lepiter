"
I am a view for a {{gtClass:name=LeCommentSnippet}}.
I am like my parent, except that I am usually hidden, and when I am displayed, my background is yellow.
"
Class {
	#name : #LeCommentSnippetElement,
	#superclass : #LePlainTextCoderSnippetElement,
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #'api - snippet view model' }
LeCommentSnippetElement >> alignContentLeftBy: aNumber [
	"All snippets should be nicely aligned to the left. However, only snippets themselves know their content and layout structure.
	Override me to align the content by aNumber of points to the left. Usually it should just involve setting a corresponding padding or margin"
]

{ #category : #initalization }
LeCommentSnippetElement >> initializeEditorElement [
	super initializeEditorElement.
	editorElement background: Color paleYellow
]
