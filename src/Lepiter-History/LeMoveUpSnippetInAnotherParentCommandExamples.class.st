Class {
	#name : #LeMoveUpSnippetInAnotherParentCommandExamples,
	#superclass : #LeMoveUpSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #'examples - setup' }
LeMoveUpSnippetInAnotherParentCommandExamples >> createTargetPage [
	<gtExample>
	| page secondSnippet |
	
	page := super createTargetPage.
	
	page addSnippet: (LeTextSnippet string: 'A'). 
		
	secondSnippet := (LeTextSnippet string: 'B')
		uid: LeUID new.
	page addSnippet: secondSnippet. 
	secondSnippet addSnippet: ((LeTextSnippet string: 'Target')
		uid: LeUID new).
		
	self assertEmptyPageHistoryForPage: page.
	
	^ page
]

{ #category : #accessing }
LeMoveUpSnippetInAnotherParentCommandExamples >> modifiedPageStructure [
	^ { 
		#snippetA -> ('A' -> 
			 {#snippetT -> 'Target'}).
		#snippetB -> 'B'}
]
