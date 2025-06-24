Extension { #name : #LeContentCommandExamples }

{ #category : #'*Lepiter-Core-Examples' }
LeContentCommandExamples >> createTargetDatabase [
	^ LeDatabase null
]

{ #category : #'*Lepiter-Core-Examples' }
LeContentCommandExamples >> createTargetPage [
	<gtExample>
	<return: #LePage>
	| newPage |
	newPage := LePage named: 'TestPage'.

	self assertEmptyPageHistoryForPage: newPage.

	^ newPage
]
