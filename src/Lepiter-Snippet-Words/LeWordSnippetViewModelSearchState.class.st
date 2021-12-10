"
I am an abstract class.
I identify a {{gtClass:LeWordSnippetViewModel}} state in which a word {{gtClass:LeWordExplanation|label=explanatation}} is searched on the internet.

"
Class {
	#name : #LeWordSnippetViewModelSearchState,
	#superclass : #LeWordSnippetViewModelState,
	#category : 'Lepiter-Snippet-Words-UI View Model'
}

{ #category : #visitor }
LeWordSnippetViewModelSearchState >> accept: aVisitor [
	^ aVisitor visitLeWordSnippetViewModelSearchState: self
]
