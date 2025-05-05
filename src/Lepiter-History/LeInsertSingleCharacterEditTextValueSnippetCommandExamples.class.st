Class {
	#name : #LeInsertSingleCharacterEditTextValueSnippetCommandExamples,
	#superclass : #LeEditTextValueSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeInsertSingleCharacterEditTextValueSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeInsertSingleCharacterEditTextValueSnippetCommandExamples
]

{ #category : #accessing }
LeInsertSingleCharacterEditTextValueSnippetCommandExamples >> initialStringValue [
	^ 'abc'
]

{ #category : #accessing }
LeInsertSingleCharacterEditTextValueSnippetCommandExamples >> instantiateBasicTextEditCommand [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	^ BrTextEditorHistoryInsertionCommand new
		strings: {'x'};
		undoIndices: #(1);
		redoIndices: #(1)
]

{ #category : #accessing }
LeInsertSingleCharacterEditTextValueSnippetCommandExamples >> modifiedStringValue [
	^ 'axbc'
]
