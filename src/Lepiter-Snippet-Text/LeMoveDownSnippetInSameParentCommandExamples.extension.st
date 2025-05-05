Extension { #name : #LeMoveDownSnippetInSameParentCommandExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeMoveDownSnippetInSameParentCommandExamples >> createTargetPage [
	<gtExample>
	<return: #LePage>
	| page |
	page := super createTargetPage.
	page addSnippet: ((LeTextSnippet string: 'Target') uid: LeUID new).
	page addSnippet: ((LeTextSnippet string: 'B') uid: LeUID new).

	^ page
]
