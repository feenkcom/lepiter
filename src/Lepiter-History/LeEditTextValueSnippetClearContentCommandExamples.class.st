Class {
	#name : #LeEditTextValueSnippetClearContentCommandExamples,
	#superclass : #LeEditTextValueSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
LeEditTextValueSnippetClearContentCommandExamples >> initialStringValue [
	^ 'a'
]

{ #category : #accessing }
LeEditTextValueSnippetClearContentCommandExamples >> instantiateBasicTextEditCommand [
	<gtExample>
	
	^ BrTextEditorHistoryDeletionCommand new 
		texts: { 'a' asRopedText };
		undoIndices: #(1);
		redoIndices: #(1)
]

{ #category : #accessing }
LeEditTextValueSnippetClearContentCommandExamples >> modifiedStringValue [
	^ ''
]
