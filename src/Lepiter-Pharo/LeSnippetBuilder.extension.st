Extension { #name : 'LeSnippetBuilder' }

{ #category : '*Lepiter-Pharo' }
LeSnippetBuilder >> pharo [
	^ self ensureSnippetOfClass: LePharoSnippet
]

{ #category : '*Lepiter-Pharo' }
LeSnippetBuilder >> pharo: aText [
	^ self pharo code: aText
]
