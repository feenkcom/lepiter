Class {
	#name : #LeEditElementSnippetCodeHeightChangedCommandExamples,
	#superclass : #LeEditElementSnippetCommandExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #accessing }
LeEditElementSnippetCodeHeightChangedCommandExamples >> changedStateAttributes [
	^ #(elementHeight codeHeight)
]

{ #category : #accessing }
LeEditElementSnippetCodeHeightChangedCommandExamples >> initialModifiedSnippet [
	^ LeElementSnippet empty
		elementHeight: 110;
		codeHeight: 40
]

{ #category : #accessing }
LeEditElementSnippetCodeHeightChangedCommandExamples >> initialTargetSnippet [
	^ LeElementSnippet empty
]

{ #category : #accessing }
LeEditElementSnippetCodeHeightChangedCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet 
		createEditCommandForElementHeight: 110 codeHeight: 40
]
