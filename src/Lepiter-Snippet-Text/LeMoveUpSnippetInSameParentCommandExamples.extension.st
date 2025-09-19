Extension { #name : #LeMoveUpSnippetInSameParentCommandExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeMoveUpSnippetInSameParentCommandExamples >> createTargetPage [
	<gtExample>
	<return: #LePage>
	| page |
	page := super createTargetPage.
	page addSnippet: ((LeTextSnippet string: 'A') uid: LeUID new).
	page addSnippet: ((LeTextSnippet string: 'Target') uid: LeUID new).

	^ page
]
