Extension { #name : #LeInsertContentCommandExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeInsertContentCommandExamples >> createInsertEmptyChildSnippetInParentBetweenSnippetsCommand [
	<gtExample>
	<return: #LeContentInsertChildSnippetCommand>
	| command |
	self ensureTargetSnippetWithTwoChildSnippets.
	command := self targetSnippet commandBuilder insertChildSnippetCommand
			snippetTypeName: LeTextSnippet name;
			insertAfter: self targetSnippet children first.

	self assertInsertNewSnipperAfterChildUidCommandFor: command.

	^ command
]

{ #category : #'*Lepiter-Snippet-Text' }
LeInsertContentCommandExamples >> createInsertEmptyFirstChildSnippetInParentWithSnippetsCommand [
	<gtExample>
	<return: #LeContentInsertChildSnippetCommand>
	| command |
	self ensureTargetSnippetWithOneChild.
	command := self targetSnippet commandBuilder insertChildSnippetCommand
			snippetTypeName: LeTextSnippet name;
			insertFirst.

	self assertInsertNewSnipperAfterFirstCommandFor: command.

	^ command
]

{ #category : #'*Lepiter-Snippet-Text' }
LeInsertContentCommandExamples >> createInsertEmptyFirstChildSnippetInParentWithoutSnippetsCommand [
	<gtExample>
	<return: #LeContentInsertChildSnippetCommand>
	| command |
	self ensureTargetPageWithOneSnippet.
	command := self targetSnippet commandBuilder insertChildSnippetCommand
			snippetTypeName: LeTextSnippet name;
			insertFirst.

	self assertInsertNewSnipperAfterFirstCommandFor: command.

	^ command
]

{ #category : #'*Lepiter-Snippet-Text' }
LeInsertContentCommandExamples >> createInsertEmptyFirstSnippetInPageByTemplateCommand [
	<gtExample>
	<return: #LeContentInsertChildSnippetCommand>
	| command |
	command := self targetPage insertChildCommandFor: LeTextSnippet empty.

	self assertValidCommandFor: command.
	self assert: command initialSnippetState attributesCount equals: 3.
	self assert: (command initialSnippetState attributeNames includes: #uid).
	self assert: command insertPath isAtLastChildPosition.

	^ command
]

{ #category : #'*Lepiter-Snippet-Text' }
LeInsertContentCommandExamples >> createInsertEmptyFirstSnippetInPageCommand [
	<gtExample>
	<return: #LeContentInsertChildSnippetCommand>
	| command |
	command := self targetPage commandBuilder insertChildSnippetCommand
			snippetTypeName: LeTextSnippet name.

	self assertValidCommandFor: command.
	self assertInsertStateOnlyHasUidFor: command.
	self assert: command insertPath isAtLastChildPosition.

	^ command
]

{ #category : #'*Lepiter-Snippet-Text' }
LeInsertContentCommandExamples >> createInsertEmptySnippetBetweenSnippetsInPageCommand [
	<gtExample>
	<return: #LeContentInsertChildSnippetCommand>
	| command |
	self ensureTargetPageWithTwoBasicSnippetsAndFirstTarget.
	command := self targetPage commandBuilder insertChildSnippetCommand
			snippetTypeName: LeTextSnippet name;
			insertAfter: self targetSnippet.

	self assertInsertNewSnipperAfterChildUidCommandFor: command.

	^ command
]
