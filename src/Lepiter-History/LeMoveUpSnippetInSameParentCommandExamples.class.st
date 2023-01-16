Class {
	#name : #LeMoveUpSnippetInSameParentCommandExamples,
	#superclass : #LeMoveUpSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #'examples - setup  pages' }
LeMoveUpSnippetInSameParentCommandExamples >> createTargetPage [
	<gtExample>
	| page |
	
	page := super createTargetPage.
	page addSnippet: ((LeTextSnippet string: 'A')
		uid: LeUID new). 
	page addSnippet: ((LeTextSnippet string: 'Target')
		uid: LeUID new). 
	
	^ page
]

{ #category : #accessing }
LeMoveUpSnippetInSameParentCommandExamples >> modifiedPageStructure [
	^  { 
		#snippetT -> 'Target'.
		#snippetA -> 'A'} 
]
