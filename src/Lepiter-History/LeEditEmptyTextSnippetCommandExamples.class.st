"
{{gtClass:LeEditTextSnippetCommandExamples}}  has examples for editing a text snippet from a page that is contained within a database.
"
Class {
	#name : #LeEditEmptyTextSnippetCommandExamples,
	#superclass : #LeEditTextSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
LeEditEmptyTextSnippetCommandExamples >> initialStringValue [
	^ ''
]

{ #category : #accessing }
LeEditEmptyTextSnippetCommandExamples >> modifiedStringValue [
	^ 'a'
]
