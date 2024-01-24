Class {
	#name : #GtExamplePreviewAttribute,
	#superclass : #BrTextAdornmentAttribute,
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
		'document',
		'elementId',
		'previewSelectSelector'
	],
	#category : #'Lepiter-UI-Core-Text - Attributes'
}

{ #category : #accessing }
GtExamplePreviewAttribute class >> constants [
	^ LepiterConstants
]

{ #category : #accessing }
GtExamplePreviewAttribute >> codeExpanded [
	^ codeExpanded
]

{ #category : #accessing }
GtExamplePreviewAttribute >> codeExpanded: anObject [
	codeExpanded := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> constants [
	^ LepiterConstants
]

{ #category : #accessing }
GtExamplePreviewAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ self newExamplePreviewStencil asElement
]

{ #category : #accessing }
GtExamplePreviewAttribute >> document [
	^ document
]

{ #category : #accessing }
GtExamplePreviewAttribute >> document: anObject [
	self traceCr.
	document := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> elementId [
	^ elementId
]

{ #category : #accessing }
GtExamplePreviewAttribute >> elementId: anObject [
	elementId := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> example [
	^ example
]

{ #category : #accessing }
GtExamplePreviewAttribute >> example: aGtExample [
	self 
		assert: [ aGtExample isNotNil ] 
		description: [ 'Gt Example must be non-nil' ].
	example := aGtExample
]

{ #category : #'instance creation' }
GtExamplePreviewAttribute >> examplePreviewStencilClass [
	^ GtExamplePreviewStencil
]

{ #category : #initialization }
GtExamplePreviewAttribute >> initialize [
	super initialize.
	self beLazy.
	codeExpanded := true.
	noCode := true.
	previewExpanded := self constants defaultPreviewExpanded.
	previewHeight := self constants defaultPreviewHeight.
	previewShowSelector := self constants defaultShowSelector.
	
]

{ #category : #initialization }
GtExamplePreviewAttribute >> initializeLazyElement: aBlLazyElement [
	aBlLazyElement 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c margin: (BlInsets top: 0 left: 20 bottom: 0 right: 20).
			c vertical exact: self totalHeight ];
		postAction: [ :theLazyElement | 
			theLazyElement constraintsDo: [ :c | c vertical fitContent ] ]
]

{ #category : #'instance creation' }
GtExamplePreviewAttribute >> newExamplePreviewStencil [
	^ self examplePreviewStencilClass new
		example: self example asCachedExampleWithResult;
		codeExpanded: self codeExpanded;
		noCode: self noCode;
		previewExpanded: self previewExpanded;
		previewShowSelector: self previewShowSelector;
		previewSelectSelector: self previewSelectSelector;
		previewHeight: self previewHeight;
		elementId: self elementId
]

{ #category : #accessing }
GtExamplePreviewAttribute >> noCode [
	^ noCode
]

{ #category : #accessing }
GtExamplePreviewAttribute >> noCode: anObject [
	noCode := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewExpanded [
	^ previewExpanded
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewExpanded: anObject [
	previewExpanded := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewHeight [
	^ previewHeight
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewHeight: anObject [
	previewHeight := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewSelectSelector [
	^ previewSelectSelector
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewSelectSelector: aSelector [
	previewSelectSelector := aSelector
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewShowSelector [
	^ previewShowSelector
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewShowSelector: aSelector [
	previewShowSelector := aSelector
]

{ #category : #accessing }
GtExamplePreviewAttribute >> resultVariableName [
	^ resultVariableName
]

{ #category : #accessing }
GtExamplePreviewAttribute >> resultVariableName: anObject [
	resultVariableName := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> totalHeight [
	"only preview"
	self noCode ifTrue: [ ^ self previewHeight ].
	"collapsed code, arrow, expanded preview"
	(self codeExpanded not and: [ self previewExpanded ]) 
		ifTrue: [ ^ 70 + 16 + self previewHeight ].
	"expanded code, no arrow, no preview"
	(self codeExpanded and: [ self previewExpanded not ]) 
		ifTrue: [ ^ "code" (self example sourceCode lines size * 16) + "header" 75 + "buttons" 30 ].
	"expanded code, arrow, expanded preview"
	 ^ "code" (self example sourceCode lines size * 16) + "header" 75 + "buttons" 30 +
		"arrow" 16 + "preview" self previewHeight
]
