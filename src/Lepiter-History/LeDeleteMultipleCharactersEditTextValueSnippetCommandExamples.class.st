Class {
	#name : #LeDeleteMultipleCharactersEditTextValueSnippetCommandExamples,
	#superclass : #LeEditTextValueSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeDeleteMultipleCharactersEditTextValueSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeDeleteMultipleCharactersEditTextValueSnippetCommandExamples
]

{ #category : #accessing }
LeDeleteMultipleCharactersEditTextValueSnippetCommandExamples >> initialStringValue [
	^ 'a1bc1de'
]

{ #category : #accessing }
LeDeleteMultipleCharactersEditTextValueSnippetCommandExamples >> instantiateBasicTextEditCommand [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	^ BrTextEditorHistoryDeletionCommand new
		texts: {'1' asRopedText.
				'1' asRopedText};
		undoIndices: #(2 5);
		redoIndices: #(2 4)
]

{ #category : #accessing }
LeDeleteMultipleCharactersEditTextValueSnippetCommandExamples >> modifiedStringValue [
	^ 'abcde'
]
