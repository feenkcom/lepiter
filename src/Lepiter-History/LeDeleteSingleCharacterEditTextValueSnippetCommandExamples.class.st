Class {
	#name : #LeDeleteSingleCharacterEditTextValueSnippetCommandExamples,
	#superclass : #LeEditTextValueSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeDeleteSingleCharacterEditTextValueSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeDeleteSingleCharacterEditTextValueSnippetCommandExamples
]

{ #category : #accessing }
LeDeleteSingleCharacterEditTextValueSnippetCommandExamples >> initialStringValue [
	^ 'abc'
]

{ #category : #accessing }
LeDeleteSingleCharacterEditTextValueSnippetCommandExamples >> instantiateBasicTextEditCommand [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	^ BrTextEditorHistoryDeletionCommand new
		texts: {'b' asRopedText};
		undoIndices: #(2);
		redoIndices: #(2)
]

{ #category : #accessing }
LeDeleteSingleCharacterEditTextValueSnippetCommandExamples >> modifiedStringValue [
	^ 'ac'
]
