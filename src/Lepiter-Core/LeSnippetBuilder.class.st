Class {
	#name : #LeSnippetBuilder,
	#superclass : #LeContentBuilder,
	#category : 'Lepiter-Core-Builders'
}

{ #category : #'private - asserting' }
LeSnippetBuilder >> assertSnippet: aSnippet [
	self
		assert: [ aSnippet isNotNil ] 
		description: [ 'Snippets must be non-nil' ].
	self 
		assert: [ self snippet == LeSnippet null ] 
		description: [ 'I can be used only once for only one snippet. There is already snippet of ',
			self snippet className, ' type, while intending to build a new one of ', aSnippet className, '.' ].
]

{ #category : #'private - accessing' }
LeSnippetBuilder >> block [
	self 
		deprecated: 'Use #snippet instead.' 
		transformWith: '`@receiver block' -> '`@receiver snippet'.
	^ self snippet
]

{ #category : #'private - accessing' }
LeSnippetBuilder >> block: aSnippet [
	self 
		deprecated: 'Use #snippet: instead.' 
		transformWith: '`@receiver block: `@arg' -> '`@receiver snippet: `@arg'.
	^ self snippet: aSnippet.
]

{ #category : #'api - building' }
LeSnippetBuilder >> build [
	<return: #LeSnippet>
	^ self snippet
]

{ #category : #defaults }
LeSnippetBuilder >> defaultContent [
	^ LeSnippet null
]

{ #category : #'api - configuration' }
LeSnippetBuilder >> empty [
	self text: '' asRopedText.
]

{ #category : #'private - building' }
LeSnippetBuilder >> ensureSnippetOfClass: aClass [
	<return: #LeSnippet>
	^ self ensureSnippetOfClass: aClass do: [ aClass new ]
]

{ #category : #'private - building' }
LeSnippetBuilder >> ensureSnippetOfClass: aClass do: aCreationBlock [
	<return: #LeSnippet>
	(self snippet isKindOf: aClass) ifTrue: [ ^ self snippet ].
	self snippet: aCreationBlock value.
	^ self snippet
]

{ #category : #'private - accessing' }
LeSnippetBuilder >> snippet [
	<return: #LeSnippet>
	^ content
]

{ #category : #'private - accessing' }
LeSnippetBuilder >> snippet: aSnippet [
	self assertSnippet: aSnippet.
	content := aSnippet
]

{ #category : #'api - configuration' }
LeSnippetBuilder >> string: aString [
	^ self text: aString asRopedText
]
