Class {
	#name : #LeContentEmailFilter,
	#superclass : #LeFilter,
	#instVars : [
		'email'
	],
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #accessing }
LeContentEmailFilter class >> filterDescriptorFor: aLeDatabase do: aBlock [
	| addresses |
	addresses := GtPrefixTree new.
	aLeDatabase pages
		do: [ :each | 
			each editOrCreateEmail
				ifNotNil: [ :email | addresses add: email email ] ].
	aBlock
		value:
			(GtFilterDescriptor
				creator: [ :value | self new email: value ]
				named: 'Email'
				order: 11
				completion: (GtWeightedStringsCompletionStrategy new completions: addresses))
]

{ #category : #accessing }
LeContentEmailFilter >> email [
	^ email
]

{ #category : #accessing }
LeContentEmailFilter >> email: aString [
	email := aString
]

{ #category : #testing }
LeContentEmailFilter >> matches: aLeContent [
	^ aLeContent editOrCreateEmail notNil
		and: [ aLeContent editOrCreateEmail email = email ]
]

{ #category : #printing }
LeContentEmailFilter >> printOn: aStream [
	aStream
		nextPutAll: 'Edited by ';
		nextPutAll: self email
]
