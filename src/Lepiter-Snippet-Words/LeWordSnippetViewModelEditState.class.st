"
I am an abstract class.
I identify a ${class:LeWordSnippetViewModel}$ state in which a user input is requested.
"
Class {
	#name : #LeWordSnippetViewModelEditState,
	#superclass : #LeWordSnippetViewModelState,
	#category : #'Lepiter-Snippet-Words-UI View Model'
}

{ #category : #visitor }
LeWordSnippetViewModelEditState >> accept: aVisitor [
	^ aVisitor visitLeWordSnippetViewModelEditState: self
]
