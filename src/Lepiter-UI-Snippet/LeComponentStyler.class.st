Class {
	#name : #LeComponentStyler,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor',
	#classTraits : 'TSmaCCComponentVisitor classTrait',
	#category : #'Lepiter-UI-Snippet-Text styler'
}

{ #category : #styling }
LeComponentStyler >> beginStyling [
]

{ #category : #styling }
LeComponentStyler >> finishStyling [
]

{ #category : #private }
LeComponentStyler >> styleAutoHidingAnnotation: anAnnotation [
	| first last range |
	first := anAnnotation parent startPosition max: 1.
	last := anAnnotation parent stopPosition min: self text size.
	range := first to: last.
	composite
		styleAutoHiding: range
		and: range
		whenOutside: anAnnotation parent sourceInterval
]
