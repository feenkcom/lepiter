Class {
	#name : #LeEditElementSnippetElementHeightChangedCommandExamples,
	#superclass : #LeEditElementSnippetCommandExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #accessing }
LeEditElementSnippetElementHeightChangedCommandExamples >> changedStateAttributes [
	^ #(elementHeight)
]

{ #category : #accessing }
LeEditElementSnippetElementHeightChangedCommandExamples >> initialModifiedSnippet [
	^ LeElementSnippet empty
		elementHeight: 310
]

{ #category : #accessing }
LeEditElementSnippetElementHeightChangedCommandExamples >> initialTargetSnippet [
	^ LeElementSnippet empty
]

{ #category : #accessing }
LeEditElementSnippetElementHeightChangedCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet 
		createEditCommandForElementHeight: 310
]
