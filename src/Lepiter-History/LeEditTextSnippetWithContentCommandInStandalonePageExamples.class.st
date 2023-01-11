Class {
	#name : #LeEditTextSnippetWithContentCommandInStandalonePageExamples,
	#superclass : #LeEditTextSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeEditTextSnippetWithContentCommandInStandalonePageExamples >> initialTargetSnippet [
	^ self textSnippetWithString: 'a'
]

{ #category : #accessing }
LeEditTextSnippetWithContentCommandInStandalonePageExamples >> newStringValue [
	^ 'cd'
]
