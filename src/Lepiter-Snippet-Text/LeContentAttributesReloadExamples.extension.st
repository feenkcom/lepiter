Extension { #name : #LeContentAttributesReloadExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeContentAttributesReloadExamples >> attributeReloadedForTextSnippet [
	<gtExample>
	| textSnippet attributesReloader |
	textSnippet := LeTextSnippet string: 'some text'.
	attributesReloader := LeContentAttributesReloader forContent: textSnippet.
	
	self assert: attributesReloader hasChanges not.
	
	^ attributesReloader
	
]
