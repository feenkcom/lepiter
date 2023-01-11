"
{{gtClass:LeEditTextSnippetCommandInStandalonePageExamples}} has examples for editing a text snippet from a page that is not inside a database.
"
Class {
	#name : #LeEditEmptyTextSnippetCommandInStandalonePageExamples,
	#superclass : #LeEditTextSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeEditEmptyTextSnippetCommandInStandalonePageExamples >> initialTargetSnippet [
	^ self textSnippetWithString: ''
]

{ #category : #accessing }
LeEditEmptyTextSnippetCommandInStandalonePageExamples >> newStringValue [
	^ 'a'
]
