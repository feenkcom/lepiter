Class {
	#name : #LeMoveDownSnippetInSameParentCommandExamples,
	#superclass : #LeMoveDownSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
LeMoveDownSnippetInSameParentCommandExamples >> modifiedPageStructure [
	^ { 
		#snippetA -> 'B'.
		#snippetT -> 'Target'
	} 
]
