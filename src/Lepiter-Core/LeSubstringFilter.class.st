Class {
	#name : #LeSubstringFilter,
	#superclass : #Object,
	#instVars : [
		'query',
		'caseSensitive'
	],
	#category : #'Lepiter-Core-Utility'
}

{ #category : #accessing }
LeSubstringFilter >> caseSensitive [

	^ caseSensitive
]

{ #category : #accessing }
LeSubstringFilter >> caseSensitive: anObject [

	caseSensitive := anObject
]

{ #category : #private }
LeSubstringFilter >> ifMatchedString: aString do: aBlock [
	| anIndex |
	anIndex := aString
		findString: self query
		startingAt: 1
		caseSensitive: self caseSensitive.
	anIndex isZero ifTrue: [ ^ self ].
	aBlock cull: anIndex cull: aString
]

{ #category : #private }
LeSubstringFilter >> isMatchedItem: aPage [
	self ifMatchedString: aPage contentAsString do: [ ^ true ].
	aPage
		allChildrenBreadthFirstDo: [ :eachChild | 
			self 
				ifMatchedString: eachChild contentAsString 
				do: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
LeSubstringFilter >> query [

	^ query
]

{ #category : #accessing }
LeSubstringFilter >> query: anObject [

	query := anObject
]
