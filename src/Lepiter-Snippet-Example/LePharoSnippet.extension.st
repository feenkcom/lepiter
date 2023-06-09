Extension { #name : #LePharoSnippet }

{ #category : #'*Lepiter-Snippet-Example' }
LePharoSnippet >> convertToExample: aSelector in: aClass classified: aSymbol [
	self
		compileExampleMethod: aSelector
		in: aClass
		classified: aSymbol.
	self
		addSnippetAfterSelf:
			((LeExampleSnippet new)
				exampleBehaviorName: aClass name;
				exampleSelector: aSelector).
	self removeSelf
]
