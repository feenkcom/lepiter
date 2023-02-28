Class {
	#name : #LeEditEmptyTextValueSnippetCommandExamples,
	#superclass : #LeEditTextValueSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
LeEditEmptyTextValueSnippetCommandExamples >> initialStringValue [
	^ ''
]

{ #category : #accessing }
LeEditEmptyTextValueSnippetCommandExamples >> instantiateBasicTextEditCommand [
	<gtExample>
	
	^ BrTextEditorHistoryInsertionCommand new 
		strings: { 'a' };
		undoIndices: #(0);
		redoIndices: #(0)
]

{ #category : #accessing }
LeEditEmptyTextValueSnippetCommandExamples >> modifiedStringValue [
	^ 'a'
]
