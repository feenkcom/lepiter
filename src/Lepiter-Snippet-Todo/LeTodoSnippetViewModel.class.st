"
I provide the view model for a {{gtClass:name=LeTodoSnippet}}.
"
Class {
	#name : #LeTodoSnippetViewModel,
	#superclass : #LeTextCoderSnippetViewModel,
	#category : #'Lepiter-Snippet-Todo'
}

{ #category : #accessing }
LeTodoSnippetViewModel >> snippetElementClass [
	^ LeTodoSnippetElement
]

{ #category : #accessing }
LeTodoSnippetViewModel >> state [
	^ self snippetModel state
]

{ #category : #accessing }
LeTodoSnippetViewModel >> stateLabel [
	^ self snippetModel stateLabel
]

{ #category : #accessing }
LeTodoSnippetViewModel >> stateLabelFor: aSymbol [
	^ self snippetModel class labelForState: aSymbol
]

{ #category : #accessing }
LeTodoSnippetViewModel >> states [
	^ self snippetModel class states
]
