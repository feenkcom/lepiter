Class {
	#name : #LeMergeSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #'examples - commands' }
LeMergeSnippetCommandExamples >> createMergeSnippetWithNoChildrenWithSnippetWithChildrenCommand [
	<gtExample>
	| page firstSnippet secondSnippet command |
	
	page := self ensurePageWithTwoSnippetsWithSecondSnippetWithChildren.
	firstSnippet := page children first.
	secondSnippet := page children second.
	
	command := firstSnippet  mergeSnippetCommandWith: secondSnippet.
	
	self assert: command uid notNil.
	self assert: command subcommands size equals: 3.
	
	^ command
]

{ #category : #'examples - commands' }
LeMergeSnippetCommandExamples >> createMergeSnippetsWithNoChildrenCommand [
	<gtExample>
	| page firstSnippet secondSnippet command |
	
	page := self ensurePageWithTwoSnippetsWithNoChildren.
	firstSnippet := page children first.
	secondSnippet := page children second.
	
	command := firstSnippet  mergeSnippetCommandWith: secondSnippet.
	
	self assert: command uid notNil.
	self assert: command subcommands size equals: 2.
	
	^ command
]

{ #category : #'examples - setup  pages' }
LeMergeSnippetCommandExamples >> ensurePageWithTwoSnippetsWithNoChildren [
	<gtExample>
	| page |
	
	page := self targetPage.
	page addSnippet: (self textSnippetWithString: 'A'). 
	page addSnippet: (self textSnippetWithString: 'B'). 
	
	^ page
]

{ #category : #'examples - setup  pages' }
LeMergeSnippetCommandExamples >> ensurePageWithTwoSnippetsWithSecondSnippetWithChildren [
	<gtExample>
	| page |
	
	page := self targetPage.
	page addSnippet: (self textSnippetWithString: 'A'). 
	page addSnippet: (((self textSnippetWithString: 'B')
		addSnippet: (self textSnippetWithString: 'B1');
		addSnippet: (self textSnippetWithString: 'B2');
		yourself)). 
	
	^ page
]

{ #category : #'examples - execution' }
LeMergeSnippetCommandExamples >> executeMergeSnippetWithNoChildrenWithSnippetWithChildrenCommand [
	<gtExample>
	| command page firstSnippet result |
	
	command := self createMergeSnippetWithNoChildrenWithSnippetWithChildrenCommand.
	page := self targetPage.
	firstSnippet := page children first.
	
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetAB -> ('AB' -> 
				{
					#snippetB1 -> 'B1'.
					#snippetB2 -> 'B2'})} 
		forContent: self targetPage.
	
	self 
		assert: page children first identityHash 
		equals: firstSnippet identityHash.

	^ page
]

{ #category : #'examples - execution' }
LeMergeSnippetCommandExamples >> executeMergeSnippetsWithNoChildrenCommand [
	<gtExample>
	| command page firstSnippet result |
	
	command := self createMergeSnippetsWithNoChildrenCommand.
	page := self targetPage.
	firstSnippet := page children first.
	
	result := command execute.
	
	self assert: page children size equals: 1.
	self assert: page editHistory eventStore size equals: 1.
	self assert: page children first string equals: 'AB'.
	
	self 
		assert: page children first identityHash 
		equals: firstSnippet identityHash.

	^ page
]
