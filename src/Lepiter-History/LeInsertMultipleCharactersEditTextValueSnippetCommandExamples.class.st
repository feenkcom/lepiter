Class {
	#name : #LeInsertMultipleCharactersEditTextValueSnippetCommandExamples,
	#superclass : #LeEditTextValueSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeInsertMultipleCharactersEditTextValueSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeInsertMultipleCharactersEditTextValueSnippetCommandExamples
]

{ #category : #accessing }
LeInsertMultipleCharactersEditTextValueSnippetCommandExamples >> initialStringValue [
	^ 'abcde'
]

{ #category : #accessing }
LeInsertMultipleCharactersEditTextValueSnippetCommandExamples >> instantiateBasicTextEditCommand [
	<gtExample>
	<return: #BrTextEditorHistoryInsertionCommand>
	^ BrTextEditorHistoryInsertionCommand new
		strings: {'1'.
				'1'};
		undoIndices: #(1 4);
		redoIndices: #(1 3)
]

{ #category : #accessing }
LeInsertMultipleCharactersEditTextValueSnippetCommandExamples >> modifiedStringValue [
	^ 'a1bc1de'
]
