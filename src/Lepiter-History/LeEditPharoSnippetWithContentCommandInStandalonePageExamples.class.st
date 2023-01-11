Class {
	#name : #LeEditPharoSnippetWithContentCommandInStandalonePageExamples,
	#superclass : #LeEditPharoSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeEditPharoSnippetWithContentCommandInStandalonePageExamples >> initialTargetSnippet [
	^ self pharoCodeSnippetWithString: '1+1'
]

{ #category : #accessing }
LeEditPharoSnippetWithContentCommandInStandalonePageExamples >> newStringValue [
	^ '40+2'
]
