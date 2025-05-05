Extension { #name : #LeIndentSnippetCommandExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeIndentSnippetCommandExamples >> createTargetPage [
	<gtExample>
	<return: #LePage>
	| page |
	page := super createTargetPage.

	page addSnippet: ((LeTextSnippet string: 'A') uid: LeUID new).

	page addSnippet: ((LeTextSnippet string: 'Target') uid: LeUID new).

	self assertEmptyPageHistoryForPage: page.

	^ page
]
