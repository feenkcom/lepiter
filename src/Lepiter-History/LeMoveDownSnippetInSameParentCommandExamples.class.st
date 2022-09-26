Class {
	#name : #LeMoveDownSnippetInSameParentCommandExamples,
	#superclass : #LeMoveDownSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeMoveDownSnippetInSameParentCommandExamples >> createMoveDownSnippetCommand [
	<gtExample>
	| page firstSnippet command |
	
	page := self targetPage.
	firstSnippet := page children first.
	
	command := firstSnippet commandBuilder moveDownSnippetCommand.
	
	self assert: command uid notNil.
	self assert: command targetContent equals: firstSnippet.
	
	^ command
]

{ #category : #accessing }
LeMoveDownSnippetInSameParentCommandExamples >> createTargetPage [
	<gtExample>
	| page |
	
	page := super createTargetPage.
	page addSnippet: ((LeTextSnippet string: 'A')
		uid: LeUID new). 
	page addSnippet: ((LeTextSnippet string: 'B')
		uid: LeUID new). 
	
	^ page
]

{ #category : #accessing }
LeMoveDownSnippetInSameParentCommandExamples >> executeMoveDownSnippetCommand [
	<gtExample>
	| command page initialFirstSnippet initialSecondSnippet result |
	
	command := self createMoveDownSnippetCommand.
	page := self targetPage.
	initialFirstSnippet := page children first.
	initialSecondSnippet := page children second.
	
	result := command execute.
	
	self assert: page children size equals: 2.
	self assert: page editHistory eventStore size equals: 1.
	
	self assert: page children first string equals: 'B'.
	self assert: page children second string equals: 'A'.
	self assert: page children first equals: initialSecondSnippet.
	self assert: page children second equals: initialFirstSnippet.

	^ page
]
