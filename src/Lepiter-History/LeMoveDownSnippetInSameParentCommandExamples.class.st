Class {
	#name : #LeMoveDownSnippetInSameParentCommandExamples,
	#superclass : #LeMoveDownSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeMoveDownSnippetInSameParentCommandExamples >> createTargetPage [
	<gtExample>
	| page |
	
	page := super createTargetPage.
	page addSnippet: ((LeTextSnippet string: 'Target')
		uid: LeUID new). 
	page addSnippet: ((LeTextSnippet string: 'B')
		uid: LeUID new). 
	
	^ page
]

{ #category : #accessing }
LeMoveDownSnippetInSameParentCommandExamples >> modifiedPageStructure [
	^ { 
		#snippetA -> 'B'.
		#snippetT -> 'Target'
	} 
]
