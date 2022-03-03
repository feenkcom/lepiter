Class {
	#name : #GtPreviewAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TLepiterConstants',
	#classTraits : 'TLepiterConstants classTrait',
	#instVars : [
		'result',
		'showSelector',
		'height'
	],
	#category : #'Lepiter-UI-Core-Text - Attributes'
}

{ #category : #accessing }
GtPreviewAttribute class >> constants [
	^ LepiterConstants
]

{ #category : #accessing }
GtPreviewAttribute >> constants [
	^ LepiterConstants
]

{ #category : #initialization }
GtPreviewAttribute >> defaultHeight [
	^ self constants defaultPreviewHeight
]

{ #category : #accessing }
GtPreviewAttribute >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ GtPreviewStencil new
		result: self result;
		showSelector: self showSelector;
		asElement
]

{ #category : #accessing }
GtPreviewAttribute >> height [
	<return: #Number or: nil>
	^ height
]

{ #category : #accessing }
GtPreviewAttribute >> height: anInteger [
	self 
		assert: [ anInteger notNil ] 
		description: [ 'Height value must be non-nil' ].
	self 
		assert: [ anInteger > 0 ] 
		description: [ 'Height value must be a pozitive number' ].
	height := anInteger
]

{ #category : #initialization }
GtPreviewAttribute >> initialize [
	super initialize.
	
	self beAppend.
	self beLazy.
	result := self.
	showSelector := self constants defaultShowSelector.
	height := self defaultHeight.
]

{ #category : #initialization }
GtPreviewAttribute >> initializeLazyElement: aBlLazyElement [
	aBlLazyElement 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical exact: self height ];
		postAction: [ :theLazyElement | 
			theLazyElement constraintsDo: [ :c | c vertical fitContent ] ]
]

{ #category : #accessing }
GtPreviewAttribute >> result [
	^ result
]

{ #category : #accessing }
GtPreviewAttribute >> result: anObject [
	result := anObject
]

{ #category : #accessing }
GtPreviewAttribute >> showSelector [
	^ showSelector
]

{ #category : #accessing }
GtPreviewAttribute >> showSelector: aSymbol [
	self 
		assert: [ aSymbol notNil ] 
		description: [ 'Show selector name must be non-nil' ].
	self 
		assert: [ aSymbol isSymbol ] 
		description: [ 'Show selector name must be a symbol' ].
	showSelector := aSymbol
]
