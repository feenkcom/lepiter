Class {
	#name : #LeMergeSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeMergeSnippetCommandExamples >> createMergeSnippetsWithNoChildrenCommand [
	<gtExample>
	| page firstSnippet secondSnippet command |
	
	page := self pageWithTwoSnippets.
	firstSnippet := page children first.
	secondSnippet := page children second.
	
	command := firstSnippet commandBuilder 
		mergeSnippetCommandWith: secondSnippet.
	
	self assert: command uid notNil.
	self assert: command subcommands size equals: 2.
	
	^ command
]

{ #category : #accessing }
LeMergeSnippetCommandExamples >> pageWithTwoSnippets [
	<gtExample>
	| page |
	
	page := self targetPage.
	page addSnippet: ((LeTextSnippet string: 'A')
		uid: LeUID new). 
	page addSnippet: ((LeTextSnippet string: 'B')
		uid: LeUID new). 
	
	^ page
]
