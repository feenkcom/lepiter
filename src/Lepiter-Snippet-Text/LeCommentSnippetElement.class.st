"
I am a view for a {{gtClass:name=LeCommentSnippet}}.
I am like my parent, except that I am usually hidden, and when I am displayed, my background is yellow.
"
Class {
	#name : #LeCommentSnippetElement,
	#superclass : #LeTextCoderSnippetElement,
	#instVars : [
		'nullElement'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #initalization }
LeCommentSnippetElement >> initialize [
	super initialize.
	self initializeNullElement
]

{ #category : #initalization }
LeCommentSnippetElement >> initializeEditorElement [
	super initializeEditorElement.
	editorElement background: Color paleYellow
]

{ #category : #initalization }
LeCommentSnippetElement >> initializeNullElement [
	"An empty element to show instead of the editor when the snippet is hidden."
	nullElement := BlElement new.
]
