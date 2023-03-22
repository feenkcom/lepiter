Class {
	#name : #LeEditElementSnippetVisibilityChangedCommandExamples,
	#superclass : #LeEditElementSnippetCommandExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #accessing }
LeEditElementSnippetVisibilityChangedCommandExamples >> changedStateAttributes [
	^ #(codeVisible)
]

{ #category : #accessing }
LeEditElementSnippetVisibilityChangedCommandExamples >> initialModifiedSnippet [
	^ LeElementSnippet empty
		codeVisible: false
]

{ #category : #accessing }
LeEditElementSnippetVisibilityChangedCommandExamples >> initialTargetSnippet [
	^ LeElementSnippet empty
]

{ #category : #accessing }
LeEditElementSnippetVisibilityChangedCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet 
		createEditVisibilityCommandTo: false 
]
