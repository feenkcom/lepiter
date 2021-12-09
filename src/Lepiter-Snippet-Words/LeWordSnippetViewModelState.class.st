"
I am an abstract class.
I define a {{gtClass:LeWordSnippetViewModel}} state which is used by {{gtClass:LeWordSnippetElement}} to define what it should display, e.g., either user input field, a progress, or a word explanation.

"
Class {
	#name : #LeWordSnippetViewModelState,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Snippet-Words-UI View Model'
}

{ #category : #visitor }
LeWordSnippetViewModelState >> accept: aVisitor [
	^ self subclassResponsibility
]
