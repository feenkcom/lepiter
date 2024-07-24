Class {
	#name : #LeSnippetPrefixTree,
	#superclass : #GtPrefixTree,
	#instVars : [
		'snippets'
	],
	#category : #'Lepiter-Core-Index'
}

{ #category : #accessing }
LeSnippetPrefixTree >> addSnippet: aSnippet [
	snippets
		ifNil: [ snippets := aSnippet ]
		ifNotNil: [ snippets == aSnippet ifTrue: [ ^ self ].
			snippets class == Set
				ifFalse: [ snippets := snippets isArray
							ifTrue: [ snippets := snippets asSet ]
							ifFalse: [ Set with: snippets ] ].
			(snippets includes: aSnippet) ifFalse: [ snippets add: aSnippet ] ]
]

{ #category : #private }
LeSnippetPrefixTree >> compressData [
	super compressData.
	snippets isCollection ifTrue: [ snippets := snippets asArray ]
]

{ #category : #accessing }
LeSnippetPrefixTree >> gtLocalSizeInMemory [
	^ super gtLocalSizeInMemory
		+ ((snippets isArray or: [ snippets class == Set ])
				ifTrue: [ snippets gtSpecificSizeInMemory ]
				ifFalse: [ 0 ])
]

{ #category : #accessing }
LeSnippetPrefixTree >> moveDataTo: newChild [
	super moveDataTo: newChild.
	newChild snippets: snippets.
	snippets := nil
]

{ #category : #accessing }
LeSnippetPrefixTree >> pages [
	^ self snippetsCollection collectAsSet: #page
]

{ #category : #accessing }
LeSnippetPrefixTree >> removeSnippet: aSnippet [
	snippets ifNil: [ ^ self ].
	snippets == aSnippet ifTrue: [ ^ snippets := nil ].
	snippets class == Set
		ifFalse: [ snippets isArray ifFalse: [ ^ self ].
			snippets := snippets asSet ].
	snippets remove: aSnippet ifAbsent: [  ]
]

{ #category : #accessing }
LeSnippetPrefixTree >> snippets [
	^ snippets
]

{ #category : #accessing }
LeSnippetPrefixTree >> snippets: anObject [
	^ snippets := anObject
]

{ #category : #accessing }
LeSnippetPrefixTree >> snippetsCollection [
	^ snippets
		ifNil: [ #() ]
		ifNotNil: [ snippets isCollection ifTrue: [ snippets ] ifFalse: [ {snippets} ] ]
]
