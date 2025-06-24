Class {
	#name : #LeEditTextValueSnippetClearContentCommandExamples,
	#superclass : #LeEditTextValueSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditTextValueSnippetClearContentCommandExamples class >> isAbstract [ 
	^ self name = #LeEditTextValueSnippetClearContentCommandExamples
]

{ #category : #accessing }
LeEditTextValueSnippetClearContentCommandExamples >> initialStringValue [
	^ 'a'
]

{ #category : #accessing }
LeEditTextValueSnippetClearContentCommandExamples >> instantiateBasicTextEditCommand [
	<gtExample>
	<return: #BrTextEditorHistoryDeletionCommand>
	^ BrTextEditorHistoryDeletionCommand new
		texts: {'a' asRopedText};
		undoIndices: #(1);
		redoIndices: #(1)
]

{ #category : #accessing }
LeEditTextValueSnippetClearContentCommandExamples >> modifiedStringValue [
	^ ''
]
