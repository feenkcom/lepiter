Class {
	#name : #LeEditEmptyTextValueSnippetCommandExamples,
	#superclass : #LeEditTextValueSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditEmptyTextValueSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditEmptyTextValueSnippetCommandExamples
]

{ #category : #accessing }
LeEditEmptyTextValueSnippetCommandExamples >> initialStringValue [
	^ ''
]

{ #category : #accessing }
LeEditEmptyTextValueSnippetCommandExamples >> instantiateBasicTextEditCommand [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	^ BrTextEditorHistoryInsertionCommand new
		strings: {'a'};
		undoIndices: #(0);
		redoIndices: #(0)
]

{ #category : #accessing }
LeEditEmptyTextValueSnippetCommandExamples >> modifiedStringValue [
	^ 'a'
]
