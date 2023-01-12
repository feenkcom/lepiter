Extension { #name : #LeSnippet }

{ #category : #'*Lepiter-History' }
LeSnippet >> extractSpecificState [
	^ LeSpecificSnippetStateExtractor fromSnippet: self
]

{ #category : #'*Lepiter-History' }
LeSnippet >> extractUpdatableState [
	^ LeUpdatableSnippetStateExtractor fromSnippet: self
]
