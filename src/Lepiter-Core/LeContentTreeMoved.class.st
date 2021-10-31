"
LeContentTreeMoved is used to announce that content has been moved within a page.

The destinationParent is the parent object of where the content has been moved to.  The destinationIndex is where the content was moved to.

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	destinationIndex:		<Integer>
	destinationParent:		<LeContent>


### Implementation Points

"
Class {
	#name : #LeContentTreeMoved,
	#superclass : #LeContentTreeChanged,
	#instVars : [
		'destinationParent',
		'destinationIndex'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeContentTreeMoved >> destinationIndex [
	^ destinationIndex
]

{ #category : #accessing }
LeContentTreeMoved >> destinationIndex: aNumber [
	self
		assert: [ aNumber > 0 ]
		description: [ 'Destination index must be positive' ].

	destinationIndex := aNumber
]

{ #category : #accessing }
LeContentTreeMoved >> destinationParent [
	^ destinationParent
]

{ #category : #accessing }
LeContentTreeMoved >> destinationParent: anObject [
	destinationParent := anObject
]
