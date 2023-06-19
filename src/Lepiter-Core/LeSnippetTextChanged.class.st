"
{{gtClass:LeSnippetTextChanged}} is announced whenever the text of a {{gtClass:LeSnippet}} is modified.

"
Class {
	#name : #LeSnippetTextChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'textEditCommand'
	],
	#category : #'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeSnippetTextChanged >> textEditCommand [
	^ textEditCommand
]

{ #category : #accessing }
LeSnippetTextChanged >> textEditCommand: aTextEditCommand [
	textEditCommand := aTextEditCommand
]
