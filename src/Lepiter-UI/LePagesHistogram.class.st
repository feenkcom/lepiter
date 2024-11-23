"
Example:

LePagesHistogram new pages: self pages duringLast: 10 days

"
Class {
	#name : #LePagesHistogram,
	#superclass : #BlElement,
	#category : #'Lepiter-UI-Histogram'
}

{ #category : #initialization }
LePagesHistogram >> initialize [
	super initialize.
	
	self background: (Color gray alpha: 0.2).
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #accessing }
LePagesHistogram >> pages: aCollectionOfPages between: aStartDate and: anEndDate [
	| pagesByDate maxPagesPerDay theNormalizedValues |
	pagesByDate := (aCollectionOfPages
		select:
			[ :eachPage | eachPage latestEditTime asDate between: aStartDate and: anEndDate ])
		groupedBy: [ :each | each latestEditTime asDate ].
	pagesByDate ifEmpty: [ ^ self geometry: BlEmptyGeometry new ].
	maxPagesPerDay := 0.0.
	pagesByDate
		valuesDo:
			[ :eachCollectionOfDates | maxPagesPerDay := maxPagesPerDay max: eachCollectionOfDates size ].
	theNormalizedValues := Array
		streamContents: [ :aStream | 
			(aStartDate to: anEndDate)
				datesDo: [ :eachDate | 
					aStream
						nextPut: (pagesByDate at: eachDate ifAbsent: [ #() ]) size / maxPagesPerDay ] ].
	self geometry: (BlHistogramGeometry new values: theNormalizedValues)
]

{ #category : #accessing }
LePagesHistogram >> pages: aCollectionOfPages duringLast: aDuration [
	| aTodayDate |
	
	aTodayDate := Date today.
	
	self pages: aCollectionOfPages between: aTodayDate - aDuration and: aTodayDate
]
