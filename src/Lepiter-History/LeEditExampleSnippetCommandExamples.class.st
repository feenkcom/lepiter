Class {
	#name : #LeEditExampleSnippetCommandExamples,
	#superclass : #LeEditSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #testing }
LeEditExampleSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditExampleSnippetCommandExamples
]

{ #category : #accessing }
LeEditExampleSnippetCommandExamples >> initialModifiedSnippet [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditExampleSnippetCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet commandBuilder  
		updateSnippetStateCommandBasedOn:  self initialModifiedSnippet.
]
