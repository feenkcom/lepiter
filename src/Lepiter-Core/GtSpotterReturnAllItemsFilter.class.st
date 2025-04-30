Class {
	#name : #GtSpotterReturnAllItemsFilter,
	#superclass : #GtSpotterSubstringFilter,
	#category : #'Lepiter-Core-Search'
}

{ #category : #evaluating }
GtSpotterReturnAllItemsFilter >> applyInScope: aStream context: aSpotterContext [
	"Returns true no matter what is in the search query."

	^ (GtSpotterSubstringFilterStream
		forStream: aStream
		search: aSpotterContext searchQuery)
		itemString: [ :_ | aSpotterContext searchQuery ]
]
