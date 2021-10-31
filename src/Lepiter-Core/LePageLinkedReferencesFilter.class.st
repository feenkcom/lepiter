Class {
	#name : #LePageLinkedReferencesFilter,
	#superclass : #LeFilter,
	#instVars : [
		'title'
	],
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #accessing }
LePageLinkedReferencesFilter class >> filterDescriptorFor: aLeDatabase do: aBlock [
	| titles |
	titles := GtPrefixTree new.
	aLeDatabase pages do: [ :each | titles add: each title ].
	aBlock
		value:
			(GtFilterDescriptor
				creator: [ :value | self new title: value ]
				named: 'References'
				order: 15
				completion: (GtStringsCompletionStrategy new completions: titles))
]

{ #category : #testing }
LePageLinkedReferencesFilter >> matches: aLeContent [
	"Answer a boolean indicating whether the supplied content (page or snippet) explicitly references the page with the receiver's title."
 	
	^ aLeContent allChildOutgoingTextualLinks
		anySatisfy: [ :each | 
			each target
				ifNotNil: [ :target | target title = self title ]
				ifNil: [ false ] ]
]

{ #category : #printing }
LePageLinkedReferencesFilter >> printOn: aStream [
	aStream
		nextPutAll: self title;
		nextPutAll: ' Linked References'
]

{ #category : #accessing }
LePageLinkedReferencesFilter >> title [
	^ title
]

{ #category : #accessing }
LePageLinkedReferencesFilter >> title: aString [
	title := aString
]
