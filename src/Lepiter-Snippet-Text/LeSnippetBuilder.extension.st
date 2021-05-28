Extension { #name : #LeSnippetBuilder }

{ #category : #'*Lepiter-Snippet-Text' }
LeSnippetBuilder >> text [
	^ self ensureSnippetOfClass: LeTextSnippet
]

{ #category : #'*Lepiter-Snippet-Text' }
LeSnippetBuilder >> text: aText [
	^ self text text: aText 
]
