Class {
	#name : #LeMergeSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #'examples - commands' }
LeMergeSnippetCommandExamples >> createMergeFirstChildWithChildrenInParentSnippetCommand [
	<gtExample>
	<return: #LeMergeSnippetCommand>
	| page firstSnippet secondSnippet command |
	page := self ensurePageWithTwoSnippetsWithFirstSnippetWithNestedStructure.
	firstSnippet := page children first.
	secondSnippet := firstSnippet children first.

	command := firstSnippet mergeSnippetCommandWith: secondSnippet.

	self assert: command uid notNil.
	self assert: command subcommands size equals: 3.

	^ command
]

{ #category : #'examples - commands' }
LeMergeSnippetCommandExamples >> createMergeFirstChildWithChildrenInParentSnippetWithChildrenCommand [
	<gtExample>
	<return: #LeMergeSnippetCommand>
	| page firstSnippet secondSnippet command |
	page := self ensurePageWithTwoSnippetsWithFirstSnippetWithNestedStructure.
	firstSnippet := page children first.
	secondSnippet := firstSnippet children first.

	command := firstSnippet mergeSnippetCommandWith: secondSnippet.

	self assert: command uid notNil.
	self assert: command subcommands size equals: 3.

	^ command
]

{ #category : #'examples - commands' }
LeMergeSnippetCommandExamples >> createMergeFirstChildWithoutChildrenInParentSnippetCommand [
	<gtExample>
	<return: #LeMergeSnippetCommand>
	| page firstSnippet secondSnippet command |
	page := self ensurePageWithTwoSnippetsWithFirstSnippetWithChildren.
	firstSnippet := page children first.
	secondSnippet := firstSnippet children first.

	command := firstSnippet mergeSnippetCommandWith: secondSnippet.

	self assert: command uid notNil.
	self assert: command subcommands size equals: 2.

	^ command
]

{ #category : #'examples - commands' }
LeMergeSnippetCommandExamples >> createMergeSnippetWithChildrenInPreviousNestedChildrenCommand [
	<gtExample>
	<return: #LeMergeSnippetCommand>
	| page firstSnippet secondSnippet command |
	page := self ensurePageWithTwoSnippetshChildren.
	firstSnippet := page children first children last.
	secondSnippet := page children second.

	command := firstSnippet mergeSnippetCommandWith: secondSnippet.

	self assert: command uid notNil.
	self assert: command subcommands size equals: 3.

	^ command
]

{ #category : #'examples - commands' }
LeMergeSnippetCommandExamples >> createMergeSnippetWithChildrenInPreviousSnipperWithNoChildrenCommand [
	<gtExample>
	<return: #LeMergeSnippetCommand>
	| page firstSnippet secondSnippet command |
	page := self ensurePageWithTwoSnippetsWithSecondSnippetWithChildren.
	firstSnippet := page children first.
	secondSnippet := page children second.

	command := firstSnippet mergeSnippetCommandWith: secondSnippet.

	self assert: command uid notNil.
	self assert: command subcommands size equals: 3.

	^ command
]

{ #category : #'examples - commands' }
LeMergeSnippetCommandExamples >> createMergeSnippetWithoutChildrenInPreviousNestedChildrenCommand [
	<gtExample>
	<return: #LeMergeSnippetCommand>
	| page firstSnippet secondSnippet command |
	page := self ensurePageWithTwoSnippetsWithFirstSnippetWithChildren.
	firstSnippet := page children first children last.
	secondSnippet := page children second.

	command := firstSnippet mergeSnippetCommandWith: secondSnippet.

	self assert: command uid notNil.
	self assert: command subcommands size equals: 2.

	^ command
]

{ #category : #'examples - commands' }
LeMergeSnippetCommandExamples >> createMergeSnippetsWithNoChildrenCommand [
	<gtExample>
	<return: #LeMergeSnippetCommand>
	| page firstSnippet secondSnippet command |
	page := self ensurePageWithTwoSnippetsWithNoChildren.
	firstSnippet := page children first.
	secondSnippet := page children second.

	command := firstSnippet mergeSnippetCommandWith: secondSnippet.

	self assert: command uid notNil.
	self assert: command subcommands size equals: 2.

	^ command
]

{ #category : #'examples - setup  pages' }
LeMergeSnippetCommandExamples >> ensurePageWithTwoSnippetsWithFirstSnippetWithChildren [
	<gtExample>
	<return: #LePage>
	| page |
	page := self targetPage.

	page
		addSnippet: ((self textSnippetWithString: 'A')
				addSnippet: (self textSnippetWithString: 'A1');
				addSnippet: (self textSnippetWithString: 'A2');
				yourself).
	page addSnippet: (self textSnippetWithString: 'B').

	^ page
]

{ #category : #'examples - setup  pages' }
LeMergeSnippetCommandExamples >> ensurePageWithTwoSnippetsWithFirstSnippetWithNestedStructure [
	<gtExample>
	<return: #LePage>
	| page |
	page := self targetPage.

	page
		addSnippet: ((self textSnippetWithString: 'A')
				addSnippet: ((self textSnippetWithString: 'A1')
						addSnippet: (self textSnippetWithString: 'A11');
						addSnippet: (self textSnippetWithString: 'A12');
						yourself);
				addSnippet: (self textSnippetWithString: 'A2');
				yourself).
	page addSnippet: (self textSnippetWithString: 'B').

	^ page
]

{ #category : #'examples - setup  pages' }
LeMergeSnippetCommandExamples >> ensurePageWithTwoSnippetsWithNoChildren [
	<gtExample>
	<return: #LePage>
	| page |
	page := self targetPage.
	page addSnippet: (self textSnippetWithString: 'A').
	page addSnippet: (self textSnippetWithString: 'B').

	^ page
]

{ #category : #'examples - setup  pages' }
LeMergeSnippetCommandExamples >> ensurePageWithTwoSnippetsWithSecondSnippetWithChildren [
	<gtExample>
	<return: #LePage>
	| page |
	page := self targetPage.
	page addSnippet: (self textSnippetWithString: 'A').
	page
		addSnippet: ((self textSnippetWithString: 'B')
				addSnippet: (self textSnippetWithString: 'B1');
				addSnippet: (self textSnippetWithString: 'B2');
				yourself).

	^ page
]

{ #category : #'examples - setup  pages' }
LeMergeSnippetCommandExamples >> ensurePageWithTwoSnippetshChildren [
	<gtExample>
	<return: #LePage>
	| page |
	page := self targetPage.

	page
		addSnippet: ((self textSnippetWithString: 'A')
				addSnippet: (self textSnippetWithString: 'A1');
				addSnippet: (self textSnippetWithString: 'A2');
				yourself).
	page
		addSnippet: ((self textSnippetWithString: 'B')
				addSnippet: (self textSnippetWithString: 'B1');
				addSnippet: (self textSnippetWithString: 'B2');
				yourself).

	^ page
]

{ #category : #'examples - execution' }
LeMergeSnippetCommandExamples >> executeMergeFirstChildWithChildrenInParentSnippetWithChildrenCommand [
	<gtExample>
	<return: #LePage>
	| command page firstSnippet result |
	command := self createMergeFirstChildWithChildrenInParentSnippetCommand.
	page := self targetPage.
	firstSnippet := page children first.

	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetA
					-> ('AA1'
							-> {#snippetA2 -> 'A2'.
									#snippetA11 -> 'A11'.
									#snippetA12 -> 'A12'}).
				#snippetB -> 'B'}
		forContent: self targetPage.

	self assert: page children first identityHash equals: firstSnippet identityHash.

	^ page
]

{ #category : #'examples - execution' }
LeMergeSnippetCommandExamples >> executeMergeFirstChildWithoutChildrenInParentSnippetCommand [
	<gtExample>
	<return: #LePage>
	| command page firstSnippet result |
	command := self createMergeFirstChildWithoutChildrenInParentSnippetCommand.
	page := self targetPage.
	firstSnippet := page children first.

	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetA -> ('AA1' -> {#snippetA2 -> 'A2'}).
				#snippetB -> 'B'}
		forContent: self targetPage.

	self assert: page children first identityHash equals: firstSnippet identityHash.

	^ page
]

{ #category : #'examples - execution' }
LeMergeSnippetCommandExamples >> executeMergeSnippetWithChildrenInPreviousNestedChildrenCommand [
	<gtExample>
	<return: #LePage>
	| command page targetSnippet result |
	command := self createMergeSnippetWithChildrenInPreviousNestedChildrenCommand.
	page := self targetPage.
	targetSnippet := page children first children first.

	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetA
					-> ('A'
							-> {#snippetA1 -> 'A1'.
									#snippetA2
										-> ('A2B'
												-> {#snippetB1 -> 'B1'.
														#snippetB2 -> 'B2'})})}
		forContent: self targetPage.

	self
		assert: page children first children first identityHash
		equals: targetSnippet identityHash.

	^ page
]

{ #category : #'examples - execution' }
LeMergeSnippetCommandExamples >> executeMergeSnippetWithChildrenInPreviousSnipperWithNoChildrenCommand [
	<gtExample>
	<return: #LePage>
	| command page targetSnippet result |
	command := self
			createMergeSnippetWithChildrenInPreviousSnipperWithNoChildrenCommand.
	page := self targetPage.
	targetSnippet := page children first.

	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetAB
					-> ('AB'
							-> {#snippetB1 -> 'B1'.
									#snippetB2 -> 'B2'})}
		forContent: self targetPage.

	self
		assert: page children first identityHash
		equals: targetSnippet identityHash.

	^ page
]

{ #category : #'examples - execution' }
LeMergeSnippetCommandExamples >> executeMergeSnippetWithoutChildrenInPreviousNestedChildrenCommand [
	<gtExample>
	<return: #LePage>
	| command page targetSnippet result |
	command := self
			createMergeSnippetWithoutChildrenInPreviousNestedChildrenCommand.
	page := self targetPage.
	targetSnippet := page children first children second.

	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetA
					-> ('A'
							-> {#snippetA1 -> 'A1'.
									#snippetA2 -> 'A2B'})}
		forContent: self targetPage.

	self
		assert: page children first children second identityHash
		equals: targetSnippet identityHash.

	^ page
]

{ #category : #'examples - execution' }
LeMergeSnippetCommandExamples >> executeMergeSnippetsWithNoChildrenCommand [
	<gtExample>
	<return: #LePage>
	| command page targetSnippet result |
	command := self createMergeSnippetsWithNoChildrenCommand.
	page := self targetPage.
	targetSnippet := page children first.

	result := command execute.

	self assert: page children size equals: 1.
	self assert: page editHistory eventStore size equals: 1.
	self assert: page children first string equals: 'AB'.

	self
		assert: page children first identityHash
		equals: targetSnippet identityHash.

	^ page
]
