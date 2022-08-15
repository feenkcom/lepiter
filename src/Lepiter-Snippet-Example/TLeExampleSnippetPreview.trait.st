Trait {
	#name : #TLeExampleSnippetPreview,
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #testing }
TLeExampleSnippetPreview >> hasElement [
	"Return true if it holds and (any) element."

	^ self explicitRequirement
]

{ #category : #testing }
TLeExampleSnippetPreview >> hasExample [
	"Return true if it holds an example object."

	^ self explicitRequirement
]

{ #category : #testing }
TLeExampleSnippetPreview >> hasExamplePreview [
	"Return true if if holds and example preview element (and not another element)."

	^ self explicitRequirement
]
