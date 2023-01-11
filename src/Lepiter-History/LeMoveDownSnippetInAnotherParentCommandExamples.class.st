Class {
	#name : #LeMoveDownSnippetInAnotherParentCommandExamples,
	#superclass : #LeMoveDownSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #'examples - setup  pages' }
LeMoveDownSnippetInAnotherParentCommandExamples >> createTargetPage [
	<gtExample>
	| page firstSnippet |
	
	page := super createTargetPage.
	
	firstSnippet := (LeTextSnippet string: 'A')
		uid: LeUID new.
	page addSnippet: firstSnippet. 
	firstSnippet addSnippet: ((LeTextSnippet string: 'Target')
		uid: LeUID new).
		
	page addSnippet: ((LeTextSnippet string: 'B')
		uid: LeUID new). 
		
	self assertEmptyPageHistoryForPage: page.
	
	^ page
]

{ #category : #accessing }
LeMoveDownSnippetInAnotherParentCommandExamples >> modifiedPageStructure [
	^ { 
		#snippetA -> 'A'.
		#snippetB -> ('B' -> 
			 {#snippetT -> 'Target'})}
]
