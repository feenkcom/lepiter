Class {
	#name : #GtExamplePreviewStencil,
	#superclass : #BrStencil,
	#traits : 'TLepiterConstants',
	#classTraits : 'TLepiterConstants classTrait',
	#instVars : [
		'example',
		'exampleWithResult',
		'codeExpanded',
		'noCode',
		'previewExpanded',
		'previewHeight',
		'previewShowSelector',
		'resultVariableName'
	],
	#category : #'Lepiter-UI-Core-Brick - Stencils'
}

{ #category : #accessing }
GtExamplePreviewStencil class >> constants [
	^ LepiterConstants
]

{ #category : #accessing }
GtExamplePreviewStencil >> codeExpanded [
	^ codeExpanded
]

{ #category : #accessing }
GtExamplePreviewStencil >> codeExpanded: anObject [
	codeExpanded := anObject
]

{ #category : #accessing }
GtExamplePreviewStencil >> constants [
	^ LepiterConstants
]

{ #category : #'api - instantiation' }
GtExamplePreviewStencil >> create [
	<return: #BlElement>

	| aContainer aPreviewContainerElement |
	aContainer := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ].
	aPreviewContainerElement := self newContainerWithHeight: self previewHeight.
	self noCode ifFalse: [ 
		| aCodeElement |
		aCodeElement := self newCodeElement.
		aCodeElement when: GtPhlowObjectToSpawn do: [ :anEvent | 
			anEvent consumed: true.
			self updatePreviewElement: aPreviewContainerElement in: aContainer with: anEvent object ].
		aContainer addChild: aCodeElement ].
	self isPreviewExpected ifTrue: [ 
		self updatePreviewElement: aPreviewContainerElement in: aContainer with: self result ].
	^ aContainer
]

{ #category : #accessing }
GtExamplePreviewStencil >> example [
	^ example
]

{ #category : #accessing }
GtExamplePreviewStencil >> example: aGtExample [
	example := aGtExample
]

{ #category : #accessing }
GtExamplePreviewStencil >> exampleWithResult [
	^ exampleWithResult ifNil: [ exampleWithResult := self example run ]
]

{ #category : #initialization }
GtExamplePreviewStencil >> initialize [
	super initialize.
	codeExpanded := true.
	noCode := false.
	previewExpanded := self constants defaultPreviewExpanded.
	previewHeight := self constants defaultPreviewHeight.
	previewShowSelector := self constants defaultShowSelector.
]

{ #category : #testing }
GtExamplePreviewStencil >> isPreviewExpected [
	^ self previewExpanded or: [ self noCode ]
]

{ #category : #'instance creation' }
GtExamplePreviewStencil >> newArrowElement [
	"Instantiate and return a new element playing a role of an arrow
	used to show / hide a preview"
	<return: #BlElement>

	^ BlElement new
		size: 24@16;
		geometry: (BlPolygon vertices: { 0@0 . 24@0 . 12@16 } );
		margin: (BlInsets top: 0 right: 0 bottom: 0 left: 0);
		background: Color veryVeryLightGray;
		constraintsDo: [ :c |
			"Let's put arrow in the middle of its cell"
			c linear horizontal alignCenter.
			c linear vertical alignCenter ].
]

{ #category : #'instance creation' }
GtExamplePreviewStencil >> newCodeElement [
	<return: #BlElement>
	^ ((GtPharoMethodCoder forExample: self example) withHeader) asCoderUIModel expanded: self codeExpanded; asElement
]

{ #category : #'instance creation' }
GtExamplePreviewStencil >> newContainerWithHeight: aHeightNumber [
	| aContainer |
	aContainer := BlElement new.
	^ aContainer
		layout: BlLinearLayout vertical;
		aptitude: GtPreviewAptitude;
		addChild: (BrResizer new
			target: aContainer;
			"addEventHandlerOn: BlDoubleClickEvent do: [ :anEvent |
				aResizableElement constraintsDo: [ :c | c vertical fitContent ] ]; "
			beBottom;
			aptitude: BrGlamorousResizerAptitude;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal weight: 0.5 ]);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: aHeightNumber ]
]

{ #category : #'instance creation' }
GtExamplePreviewStencil >> newPreviewElementFor: anObject [
	<return: #BlElement>
	| aView |
	aView := GtPhlowView empty on: anObject perform: self previewShowSelector asSymbol.
	^ aView asElementDo: [ :anElement | anElement ]
]

{ #category : #accessing }
GtExamplePreviewStencil >> noCode [
	^ noCode
]

{ #category : #accessing }
GtExamplePreviewStencil >> noCode: anObject [
	noCode := anObject
]

{ #category : #accessing }
GtExamplePreviewStencil >> previewExpanded [
	^ previewExpanded
]

{ #category : #accessing }
GtExamplePreviewStencil >> previewExpanded: anObject [
	previewExpanded := anObject
]

{ #category : #accessing }
GtExamplePreviewStencil >> previewHeight [
	^ previewHeight
]

{ #category : #accessing }
GtExamplePreviewStencil >> previewHeight: anObject [
	previewHeight := anObject
]

{ #category : #accessing }
GtExamplePreviewStencil >> previewShowSelector [
	^ previewShowSelector
]

{ #category : #accessing }
GtExamplePreviewStencil >> previewShowSelector: anObject [
	previewShowSelector := anObject
]

{ #category : #accessing }
GtExamplePreviewStencil >> result [
	^ self exampleWithResult returnValue
]

{ #category : #private }
GtExamplePreviewStencil >> updatePreviewElement: aPreviewContainerElement in: aWholeContainer with: anObject [
	| aNewPreview |
	aNewPreview := self newPreviewElementFor: anObject.
	aPreviewContainerElement removeChildNamed: #preview.
	aPreviewContainerElement addChild: aNewPreview at: 1 as: #preview.

	self noCode ifFalse: [ 
		aWholeContainer removeChildNamed: #arrow.
		aWholeContainer addChild: self newArrowElement at: 2 as: #arrow ].

	aPreviewContainerElement hasParent ifFalse: [ 
		aWholeContainer addChild: aPreviewContainerElement ].
	
]
