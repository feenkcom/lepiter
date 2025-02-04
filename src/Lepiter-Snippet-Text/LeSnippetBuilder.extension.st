Extension { #name : #LeSnippetBuilder }

{ #category : #'*Lepiter-Snippet-Text' }
LeSnippetBuilder >> comment [
	^ self ensureSnippetOfClass: LeCommentSnippet
]

{ #category : #'*Lepiter-Snippet-Text' }
LeSnippetBuilder >> comment: aText [
	^ self comment text: aText 
]

{ #category : #'*Lepiter-Snippet-Text' }
LeSnippetBuilder >> emptyComment [
	self comment: '' asRopedText.
]

{ #category : #'*Lepiter-Snippet-Text' }
LeSnippetBuilder >> text [
	^ self ensureSnippetOfClass: LeTextSnippet
]

{ #category : #'*Lepiter-Snippet-Text' }
LeSnippetBuilder >> text: aText [
	^ self text text: aText 
]
