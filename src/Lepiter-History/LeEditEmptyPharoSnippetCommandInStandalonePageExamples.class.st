Class {
	#name : #LeEditEmptyPharoSnippetCommandInStandalonePageExamples,
	#superclass : #LeEditPharoSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeEditEmptyPharoSnippetCommandInStandalonePageExamples >> initialTargetSnippet [
	^ self pharoCodeSnippetWithString: ''
]

{ #category : #accessing }
LeEditEmptyPharoSnippetCommandInStandalonePageExamples >> newStringValue [
	^ '1+1'
]
