Extension { #name : #LeSnippetBuilder }

{ #category : #'*Lepiter-Pharo' }
LeSnippetBuilder >> blockQuote [
	^ self ensureSnippetOfClass: LeBlockQuoteSnippet
]

{ #category : #'*Lepiter-Pharo' }
LeSnippetBuilder >> blockQuote: aString [
	^ self blockQuote string: aString; yourself
]

{ #category : #'*Lepiter-Pharo' }
LeSnippetBuilder >> pharo [
	^ self ensureSnippetOfClass: LePharoSnippet
]

{ #category : #'*Lepiter-Pharo' }
LeSnippetBuilder >> pharo: aText [
	^ self pharo code: aText
]
