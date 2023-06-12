Class {
	#name : #LeMoveUpSnippetInAnotherParentCommandExamples,
	#superclass : #LeMoveUpSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
LeMoveUpSnippetInAnotherParentCommandExamples >> modifiedPageStructure [
	^ { 
		#snippetA -> ('A' -> 
			 {#snippetT -> 'Target'}).
		#snippetB -> 'B'}
]
