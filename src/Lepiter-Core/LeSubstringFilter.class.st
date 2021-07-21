Class {
	#name : 'LeSubstringFilter',
	#superclass : 'GtUnorderedFilter',
	#category : 'Lepiter-Core-Utility'
}

{ #category : 'private' }
LeSubstringFilter >> ifMatchedString: aString do: aBlock [
	| anIndex |
	anIndex := aString
		findString: self query
		startingAt: 1
		caseSensitive: self caseSensitive.
	anIndex isZero ifTrue: [ ^ self ].
	aBlock cull: anIndex cull: aString
]

{ #category : 'private' }
LeSubstringFilter >> isMatchedItem: aPage [
	self ifMatchedString: aPage contentAsString do: [ ^ true ].
	aPage
		allChildrenBreadthFirstDo: [ :eachChild | 
			self 
				ifMatchedString: eachChild contentAsString 
				do: [ ^ true ] ].
	^ false
]
