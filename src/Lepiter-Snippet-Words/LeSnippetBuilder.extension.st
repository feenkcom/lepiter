Extension { #name : #LeSnippetBuilder }

{ #category : #'*Lepiter-Snippet-Words' }
LeSnippetBuilder >> word [
	^ self ensureSnippetOfClass: LeWordSnippet
]

{ #category : #'*Lepiter-Snippet-Words' }
LeSnippetBuilder >> word: aString [
	^ self word word: aString
]
