Class {
	#name : #GtExamplePreviewStencil,
	#superclass : #BrStencil,
	#traits : 'TLepiterConstants',
	#classTraits : 'TLepiterConstants classTrait',
	#instVars : [
		'example',
		'codeExpanded',
		'noCode',
		'previewExpanded',
		'previewHeight',
		'previewShowSelector',
		'resultVariableName',
		'elementId',
		'previewSelectSelector'
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
	
	self elementId ifNotNil: [ :anId | 
		aContainer id: anId ].
			
	aPreviewContainerElement := self newContainerWithHeight: self previewHeight.
	
	self noCode ifFalse: [ 
		| aCodeElement |
		aCodeElement := self newCodeElement.
		aCodeElement when: GtPhlowObjectToSpawn do: [ :anEvent | 
			anEvent consumed: true.
			self 
				updatePreviewElement: aPreviewContainerElement 
				in: aContainer 
				with: anEvent object ].
		aContainer addChild: aCodeElement ].
	
	self isPreviewExpected ifTrue: [ 
		self 
			updatePreviewElement: aPreviewContainerElement 
			in: aContainer 
			with: (MessageSend 
				receiver: self example 
				selector: #returnValue)  ].
	^ aContainer
]

{ #category : #accessing }
GtExamplePreviewStencil >> elementId [
	^ elementId
]

{ #category : #accessing }
GtExamplePreviewStencil >> elementId: anObject [
	elementId := anObject
]

{ #category : #accessing }
GtExamplePreviewStencil >> example [
	<return: #GtExampleWithResult>
	^ example
]

{ #category : #accessing }
GtExamplePreviewStencil >> example: aGtExample [
	"It is recommended to provide a cached example with result
	using #asCachedExampleWithResult"

	example := aGtExample asExampleWithResult
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
		geometry: (BlPolygonGeometry vertices: { 0@0 . 24@0 . 12@16 } );
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
	
	^ (GtPharoMethodCoder forExample: self example) asCoderViewModel
		withHeader;
		expanded: self codeExpanded;
		asElement
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
	| view viewElement |
	view := GtPhlowView empty
			on: anObject
			perform: self previewShowSelector asSymbol.
	viewElement := view asElementDo: [ :anElement | anElement ].

	self previewShowSelector = LeExampleSnippet defaultPreviewShowSelector
		ifTrue: [ self selectViewInPreviewElement: viewElement onObject: anObject ].

	^ viewElement
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
GtExamplePreviewStencil >> previewSelectSelector [
	^ previewSelectSelector
]

{ #category : #accessing }
GtExamplePreviewStencil >> previewSelectSelector: aSelector [
	previewSelectSelector := aSelector
]

{ #category : #accessing }
GtExamplePreviewStencil >> previewShowSelector [
	^ previewShowSelector
]

{ #category : #accessing }
GtExamplePreviewStencil >> previewShowSelector: aSelector [
	previewShowSelector := aSelector
]

{ #category : #'instance creation' }
GtExamplePreviewStencil >> selectViewInPreviewElement: aViewElement onObject: anObject [ 
	| inspectorTabGroup |
	self previewSelectSelector ifNil: [ ^ self ].
	
	inspectorTabGroup := aViewElement phlow firstChildWithViewContent.
	(GtInspectorTabSelector byViewMethod
		methodSelector: self previewSelectSelector)
			selectTabInGroup:  inspectorTabGroup on: anObject
]

{ #category : #private }
GtExamplePreviewStencil >> updatePreviewElement: aPreviewContainerElement in: aWholeContainer with: aValuable [
	aPreviewContainerElement withAsyncFutureDo: [ :anAsyncElementFuture |
		anAsyncElementFuture
			whenPending: [ :theContainer | 
				theContainer 
					removeChildNamed: #preview ];
			whenError: [ :theContainer :anError | 
				theContainer 
					removeChildNamed: #preview;
					addChild: anError asDebuggableElement at: 1 as: #preview
			];
			whenSuccess: [ :theContainer :aNewPreview |
				theContainer 
					removeChildNamed: #preview;
					addChild: aNewPreview at: 1 as: #preview
			].
			
		anAsyncElementFuture future: (aValuable asAsyncFuture
			map: (MessageSend 
				receiver: self
				selector: #newPreviewElementFor:)).
	].
	
	self noCode ifFalse: [ 
		aWholeContainer removeChildNamed: #arrow.
		aWholeContainer addChild: self newArrowElement at: 2 as: #arrow ].

	aPreviewContainerElement hasParent ifFalse: [ 
		aWholeContainer addChild: aPreviewContainerElement ].
	
]
