Class {
	#name : #GtResizablePreviewStencil,
	#superclass : #GtPreviewStencil,
	#category : #'Lepiter-UI-Core-Brick - Stencils'
}

{ #category : #'instance creation' }
GtResizablePreviewStencil >> newContainerFor: aWrappedElement [
	| aResult |
	aResult := aWrappedElement asVerticallyResizableDo: [ :anElement | 
		anElement 
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical exact: self height ]
		 ].
	aResult addAptitude: GtPreviewAptitude.
	^ aResult
]
