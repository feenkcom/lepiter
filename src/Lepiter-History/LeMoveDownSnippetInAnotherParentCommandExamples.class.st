Class {
	#name : #LeMoveDownSnippetInAnotherParentCommandExamples,
	#superclass : #LeMoveDownSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeMoveDownSnippetInAnotherParentCommandExamples >> createMoveDownSnippetCommand [
	<gtExample>
	| page targetSnippet command |
	
	page := self targetPage.
	targetSnippet := page children first children first.
	
	command := targetSnippet commandBuilder moveDownSnippetCommand.
	
	self assert: command uid notNil.
	self assert: command targetContent equals: targetSnippet.
	
	^ command
]

{ #category : #accessing }
LeMoveDownSnippetInAnotherParentCommandExamples >> createTargetPage [
	<gtExample>
	| page firstSnippet |
	
	page := super createTargetPage.
	
	firstSnippet := (LeTextSnippet string: 'A')
		uid: LeUID new.
	page addSnippet: firstSnippet. 
	firstSnippet addSnippet: ((LeTextSnippet string: 'A1')
		uid: LeUID new).
		
	page addSnippet: ((LeTextSnippet string: 'B')
		uid: LeUID new). 
		
	self assertEmptyPageHistoryForPage: page.
	
	^ page
]
