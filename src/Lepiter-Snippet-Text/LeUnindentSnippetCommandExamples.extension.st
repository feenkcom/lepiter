Extension { #name : #LeUnindentSnippetCommandExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeUnindentSnippetCommandExamples >> createTargetPage [
	<gtExample>
	<return: #LePage>
	| page |
	page := super createTargetPage.

	page addSnippet: ((LeTextSnippet string: 'A') uid: LeUID new).

	page children first
		addSnippet: ((LeTextSnippet string: 'Target') uid: LeUID new).

	self assertEmptyPageHistoryForPage: page.

	^ page
]
