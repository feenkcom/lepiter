Class {
	#name : #LeSplitSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #'examples - commands' }
LeSplitSnippetCommandExamples >> createSplitChildTextSnippetCommand [
	<gtExample>
	<return: #LeSplitSnippetCommand>
	| targetSnippet command |
	self ensureChildTextSnippetForSplittingWithNoChildren.
	targetSnippet := self targetPage children first children first.

	command := targetSnippet splitSnippetCommandAtPosition: 1.

	self assertCommand: command forSnippet: targetSnippet.
	self assert: command cursorPosition equals: 1.

	^ command
]

{ #category : #'examples - commands' }
LeSplitSnippetCommandExamples >> createSplitSinglePharoSnippetInPageCommand [
	<gtExample>
	<return: #LeSplitSnippetCommand>
	| targetSnippet command |
	self ensureTargetPageOneCodeSnippet.
	targetSnippet := self targetPage children first.

	command := targetSnippet splitSnippetCommandAtPosition: 1.

	self assertCommand: command forSnippet: targetSnippet.
	self assert: command cursorPosition equals: 1.

	^ command
]

{ #category : #'examples - commands' }
LeSplitSnippetCommandExamples >> createSplitSingleTextSnippetInPageCommand [
	<gtExample>
	<return: #LeSplitSnippetCommand>
	| targetSnippet command |
	self ensureTargetPageOneTextSnippet.
	targetSnippet := self targetPage children first.

	command := targetSnippet splitSnippetCommandAtPosition: 1.

	self assertCommand: command forSnippet: targetSnippet.
	self assert: command cursorPosition equals: 1.

	^ command
]

{ #category : #'examples - commands' }
LeSplitSnippetCommandExamples >> createSplitTextSnippetWithChildrenInPageCommand [
	<gtExample>
	<return: #LeSplitSnippetCommand>
	| targetSnippet command |
	self ensureTargetPageOneTextSnippetWithChildren.
	targetSnippet := self targetPage children first.

	command := targetSnippet splitSnippetCommandAtPosition: 1.

	self assertCommand: command forSnippet: targetSnippet.
	self assert: command cursorPosition equals: 1.

	^ command
]

{ #category : #'examples - setup  pages' }
LeSplitSnippetCommandExamples >> ensureChildTextSnippetForSplittingWithNoChildren [
	<gtExample>
	<return: #LePage>
	^ self targetPage
		addSnippet: ((self textSnippetWithString: 'A')
				addSnippet: (self textSnippetWithString: 'bc');
				yourself);
		yourself
]

{ #category : #'examples - setup  pages' }
LeSplitSnippetCommandExamples >> ensureTargetPageOneCodeSnippet [
	<gtExample>
	<return: #LePage>
	^ self targetPage
		addSnippet: (self pharoCodeSnippetWithString: '12');
		yourself
]

{ #category : #'examples - setup  pages' }
LeSplitSnippetCommandExamples >> ensureTargetPageOneTextSnippet [
	<gtExample>
	<return: #LePage>
	^ self targetPage
		addSnippet: (self textSnippetWithString: 'ab');
		yourself
]

{ #category : #'examples - setup  pages' }
LeSplitSnippetCommandExamples >> ensureTargetPageOneTextSnippetWithChildren [
	<gtExample>
	<return: #LePage>
	^ self targetPage
		addSnippet: ((self textSnippetWithString: 'ab')
				addSnippet: (self textSnippetWithString: 'C');
				addSnippet: (self textSnippetWithString: 'D');
				yourself);
		yourself
]

{ #category : #'examples - execution' }
LeSplitSnippetCommandExamples >> executeSplitChildTextSnippetCommand [
	<gtExample>
	<return: #LePage>
	| command result initialSnippet |
	command := self createSplitChildTextSnippetCommand.
	initialSnippet := self targetPage children first children first.
	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetA
					-> ('A'
							-> {#snippetB -> 'b'.
									#snippetC -> 'c'})}
		forContent: self targetPage.
	self assertTargePageIsSerialisable.
	self assertOnlyTimeMetadataSetForSnippet: result insertedSnippet.
	self assert: command targetSnippet editTime notNil.

	self assert: self targetPage children first children second == initialSnippet.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeSplitSnippetCommandExamples >> executeSplitSinglePharoSnippetInPageCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self createSplitSinglePharoSnippetInPageCommand.
	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetA -> '1'.
				#snippetB -> '2'}
		forContent: self targetPage.
	self assertOnlyTimeMetadataSetForSnippet: result insertedSnippet.
	self assert: command targetContent createTime isNil.
	self assert: command targetContent editTime isNil.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeSplitSnippetCommandExamples >> executeSplitSinglePharoSnippetInPageCommand_undoCommand [
	<gtExample>
	<return: #LePage>
	| result |
	self executeSplitSinglePharoSnippetInPageCommand.

	result := self targetPage editHistory undoCurrent.

	self assertPageHistoryCountsAfterUndo.
	self assertStructure: {#snippetA -> '12'} forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeSplitSnippetCommandExamples >> executeSplitSinglePharoSnippetInPageCommand_undoCommand_redoCommand [
	<gtExample>
	<return: #LePage>
	| result |
	self executeSplitSinglePharoSnippetInPageCommand_undoCommand.

	result := self targetPage editHistory redoCurrent.

	self assertPageHistoryCountsAfterRedo.
	self
		assertStructure: {#snippetA -> '1'.
				#snippetB -> '2'}
		forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeSplitSnippetCommandExamples >> executeSplitSingleTextSnippetInPageCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self createSplitSingleTextSnippetInPageCommand.
	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetA -> 'a'.
				#snippetB -> 'b'}
		forContent: self targetPage.
	self assertOnlyTimeMetadataSetForSnippet: result insertedSnippet.
	self assert: command targetSnippet editTime notNil.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeSplitSnippetCommandExamples >> executeSplitSingleTextSnippetInPageCommand_identityPreserved [
	<gtExample>
	<return: #LePage>
	| initialSnippet command result |
	command := self createSplitSingleTextSnippetInPageCommand.

	initialSnippet := self targetPage children first.
	result := command execute.

	self assert: self targetPage children second == initialSnippet.
	self assert: result insertedSnippet == self targetPage children first.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeSplitSnippetCommandExamples >> executeSplitTextSnippetWithChildrenInPageCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self createSplitTextSnippetWithChildrenInPageCommand.
	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetAa -> 'a'.
				#snippetAb
					-> ('b'
							-> {#snippetC -> 'C'.
									#snippetD -> 'D'})}
		forContent: self targetPage.
	self assertOnlyTimeMetadataSetForSnippet: result insertedSnippet.
	self assert: command targetSnippet editTime notNil.

	^ self targetPage
]
