Extension { #name : #LeMoveUpSnippetInAnotherParentCommandExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeMoveUpSnippetInAnotherParentCommandExamples >> createTargetPage [
	<gtExample>
	<return: #LePage>
	| page secondSnippet |
	page := super createTargetPage.

	page addSnippet: (LeTextSnippet string: 'A').

	secondSnippet := (LeTextSnippet string: 'B') uid: LeUID new.
	page addSnippet: secondSnippet.
	secondSnippet addSnippet: ((LeTextSnippet string: 'Target') uid: LeUID new).

	self assertEmptyPageHistoryForPage: page.

	^ page
]
