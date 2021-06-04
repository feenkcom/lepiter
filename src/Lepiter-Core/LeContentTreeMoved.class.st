"
LeContentTreeMoved is used to announce that content has been moved within a page.

The destinationParent is the parent object of where the content has been moved to.  The destinationIndex is where the content was moved to.

 
1. # Internal Representation and Key Implementation Points.


1. ## Instance Variables

	destinationIndex:		<Integer>
	destinationParent:		<LeContent>


1. ## Implementation Points


"
Class {
	#name : #LeContentTreeMoved,
	#superclass : #LeContentTreeChanged,
	#instVars : [
		'destinationParent',
		'destinationIndex'
	],
	#category : #'Lepiter-Core-Announcements'
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
