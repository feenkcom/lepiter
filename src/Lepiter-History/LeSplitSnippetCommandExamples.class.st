Class {
	#name : #LeSplitSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #'examples - commands' }
LeSplitSnippetCommandExamples >> createSplitChildTextSnippetCommand [
	<gtExample>
	| targetSnippet command |
	
	self ensureChildTextSnippetForSplittingWithNoChildren.
	targetSnippet := self targetPage children first children first.
	
	command := targetSnippet splitSnippetCommandAtPosition: 1.
	
	self assertCommand: command forSnippet: targetSnippet.
	
	^ command
]

{ #category : #'examples - commands' }
LeSplitSnippetCommandExamples >> createSplitSinglePharoSnippetInPageCommand [
	<gtExample>
	| targetSnippet command |
	
	self ensureTargetPageOneCodeSnippet.
	targetSnippet := self targetPage children first.
	
	command := targetSnippet splitSnippetCommandAtPosition: 1.
	
	self assertCommand: command forSnippet: targetSnippet.
	
	^ command
]

{ #category : #'examples - commands' }
LeSplitSnippetCommandExamples >> createSplitSingleTextSnippetInPageCommand [
	<gtExample>
	| targetSnippet command |
	
	self ensureTargetPageOneTextSnippet.
	targetSnippet := self targetPage children first.
	
	command := targetSnippet splitSnippetCommandAtPosition: 1.
	
	self assertCommand: command forSnippet: targetSnippet.
	
	^ command
]

{ #category : #'examples - commands' }
LeSplitSnippetCommandExamples >> createSplitTextSnippetWithChildrenInPageCommand [
	<gtExample>
	| targetSnippet command |
	
	self ensureTargetPageOneTextSnippetWithChildren.
	targetSnippet := self targetPage children first.
	
	command := targetSnippet splitSnippetCommandAtPosition: 1.
	
	self assertCommand: command forSnippet: targetSnippet.
	
	^ command
]

{ #category : #'examples - setup  pages' }
LeSplitSnippetCommandExamples >> ensureChildTextSnippetForSplittingWithNoChildren [
	<gtExample>
	
	^ self targetPage
	 	addSnippet: ((self textSnippetWithString: 'A')
	 		addSnippet: (self textSnippetWithString: 'bc');
	 		yourself);
	 	yourself
]

{ #category : #'examples - setup  pages' }
LeSplitSnippetCommandExamples >> ensureTargetPageOneCodeSnippet [
	<gtExample>
	
	^ self targetPage
	 	addSnippet: (self pharoCodeSnippetWithString: '12');
	 	yourself
]

{ #category : #'examples - setup  pages' }
LeSplitSnippetCommandExamples >> ensureTargetPageOneTextSnippet [
	<gtExample>
	
	^ self targetPage
	 	addSnippet: (self textSnippetWithString: 'ab');
	 	yourself
]

{ #category : #'examples - setup  pages' }
LeSplitSnippetCommandExamples >> ensureTargetPageOneTextSnippetWithChildren [
	<gtExample>
	
	^ self targetPage
	 	addSnippet: ((self textSnippetWithString: 'ab')
	 		addSnippet: (self textSnippetWithString: 'C');
	 		addSnippet: (self textSnippetWithString: 'D');
	 		yourself);
	 	yourself
]

{ #category : #accessing }
LeSplitSnippetCommandExamples >> executeSplitChildTextSnippetCommand [
	<gtExample>
	| command result initialSnippet |
	
	command := self createSplitChildTextSnippetCommand.
	initialSnippet := self targetPage children first children first.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetA -> ('A' -> {
				#snippetB -> 'b'.
				#snippetC -> 'c' })} 
		forContent: self targetPage.
	self assertTargePageIsSerialisable.
	self assertOnlyTimeMetadataSetForSnippet:  result insertedSnippet.
	self assert:  command targetSnippet editTime notNil.
	
	self 
		assert: self targetPage children first children second == initialSnippet.
	
	^ self targetPage
]

{ #category : #accessing }
LeSplitSnippetCommandExamples >> executeSplitSinglePharoSnippetInPageCommand [
	<gtExample>
	| command result |
	
	command := self createSplitSinglePharoSnippetInPageCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetA -> '1'.
			#snippetB -> '2'} 
		forContent: self targetPage.
	self assertOnlyTimeMetadataSetForSnippet:  result insertedSnippet.
	self assert:  command targetSnippet editTime notNil.

	^ self targetPage
]

{ #category : #accessing }
LeSplitSnippetCommandExamples >> executeSplitSingleTextSnippetInPageCommand [
	<gtExample>
	| command result |
	
	command := self createSplitSingleTextSnippetInPageCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetA -> 'a'.
			#snippetB -> 'b'} 
		forContent: self targetPage.
	self assertOnlyTimeMetadataSetForSnippet:  result insertedSnippet.
	self assert:  command targetSnippet editTime notNil.

	^ self targetPage
]

{ #category : #accessing }
LeSplitSnippetCommandExamples >> executeSplitSingleTextSnippetInPageCommand_identityPreserved [
	<gtExample>
	| initialSnippet command result |
	
	command := self createSplitSingleTextSnippetInPageCommand.
	
	initialSnippet := self targetPage children first.
	result := command execute.
	
	self assert: self targetPage children second == initialSnippet.
	self assert: result insertedSnippet == self targetPage children first.

	^ self targetPage
]

{ #category : #accessing }
LeSplitSnippetCommandExamples >> executeSplitTextSnippetWithChildrenInPageCommand [
	<gtExample>
	| command result |
	
	command := self createSplitTextSnippetWithChildrenInPageCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetAa -> 'a'.
			#snippetAb -> ('b' -> {
				#snippetC -> 'C'.
				#snippetD -> 'D' })} 
		forContent: self targetPage.
	self assertOnlyTimeMetadataSetForSnippet:  result insertedSnippet.
	self assert:  command targetSnippet editTime notNil.

	^ self targetPage
]
