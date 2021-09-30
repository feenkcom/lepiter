Class {
	#name : #LePageTitleFilter,
	#superclass : #LeFilter,
	#instVars : [
		'title'
	],
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #accessing }
LePageTitleFilter class >> filterDescriptorFor: aLeDatabase do: aBlock [
	| titles |
	titles := GtPrefixTree new.
	aLeDatabase pages do: [ :each | titles add: each title ].
	aBlock
		value:
			(GtFilterDescriptor
				creator: [ :value | self new title: value ]
				named: 'Title'
				order: 10
				completion: (GtStringsCompletionStrategy new completions: titles)
				emptyDefaultValue: 'All')
]

{ #category : #testing }
LePageTitleFilter >> matches: aLePage [
	^ (aLePage title asLowercase
		indexOfSubCollection: title asLowercase) > 0
]

{ #category : #printing }
LePageTitleFilter >> printOn: aStream [
	aStream
		nextPutAll: 'Pages Matching ';
		nextPutAll: self title
]

{ #category : #accessing }
LePageTitleFilter >> title [
	^ title
]

{ #category : #accessing }
LePageTitleFilter >> title: aString [
	title := aString
]
