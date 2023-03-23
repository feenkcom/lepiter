Class {
	#name : #LeEditPharoSnippetCommandExamples,
	#superclass : #LeEditCodeSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditPharoSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditPharoSnippetCommandExamples
]

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> initialTargetSnippet [
	^ self pharoCodeSnippetWithString: self initialStringValue
]
