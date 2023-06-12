Class {
	#name : #LeMoveDownSnippetInAnotherParentCommandExamples,
	#superclass : #LeMoveDownSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
LeMoveDownSnippetInAnotherParentCommandExamples >> modifiedPageStructure [
	^ { 
		#snippetA -> 'A'.
		#snippetB -> ('B' -> 
			 {#snippetT -> 'Target'})}
]
