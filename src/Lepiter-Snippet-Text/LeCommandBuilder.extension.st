Extension { #name : #LeCommandBuilder }

{ #category : #'*Lepiter-Snippet-Text' }
LeCommandBuilder >> insertChildTextSnippetCommand [
	^ self insertChildSnippetOfTypeCommandForType: LeTextSnippet
]
