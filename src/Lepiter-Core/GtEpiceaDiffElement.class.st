Class {
	#name : #GtEpiceaDiffElement,
	#superclass : #GtDiffElement,
	#category : #'Lepiter-Core-Epicea'
}

{ #category : #initialize }
GtEpiceaDiffElement >> initialize [
	super initialize.
	leftElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	leftElement
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 1).
	rightElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	rightElement
		border: (BlBorder paint: (Color gray alpha: 0.2) width: 1)
]
