"
I am an abstract class.
I identify a {{gtClass:LeWordSnippetViewModel}} state in which a word {{gtClass:LeWordExplanation|label=explanatation}} is displayed.

"
Class {
	#name : #LeWordSnippetViewModelViewState,
	#superclass : #LeWordSnippetViewModelState,
	#category : 'Lepiter-Snippet-Words-UI View Model'
}

{ #category : #visitor }
LeWordSnippetViewModelViewState >> accept: aVisitor [
	^ aVisitor visitLeWordSnippetViewModelViewState: self
]
