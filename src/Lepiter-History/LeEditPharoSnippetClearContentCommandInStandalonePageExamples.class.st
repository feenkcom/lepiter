Class {
	#name : #LeEditPharoSnippetClearContentCommandInStandalonePageExamples,
	#superclass : #LeEditPharoSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeEditPharoSnippetClearContentCommandInStandalonePageExamples >> initialTargetSnippet [
	^ self pharoCodeSnippetWithString: '1+1'
]

{ #category : #accessing }
LeEditPharoSnippetClearContentCommandInStandalonePageExamples >> newStringValue [
	^ ''
]
