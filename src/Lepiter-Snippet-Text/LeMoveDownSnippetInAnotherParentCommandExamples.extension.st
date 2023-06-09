Extension { #name : #LeMoveDownSnippetInAnotherParentCommandExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeMoveDownSnippetInAnotherParentCommandExamples >> createTargetPage [
	<gtExample>
	| page firstSnippet |
	
	page := super createTargetPage.
	
	firstSnippet := (LeTextSnippet string: 'A')
		uid: LeUID new.
	page addSnippet: firstSnippet. 
	firstSnippet addSnippet: ((LeTextSnippet string: 'Target')
		uid: LeUID new).
		
	page addSnippet: ((LeTextSnippet string: 'B')
		uid: LeUID new). 
		
	self assertEmptyPageHistoryForPage: page.
	
	^ page
]
