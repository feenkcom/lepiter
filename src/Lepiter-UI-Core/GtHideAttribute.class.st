Class {
	#name : #GtHideAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TLepiterConstants',
	#classTraits : 'TLepiterConstants classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Lepiter-UI-Core-Text - Attributes'
}

{ #category : #cleanup }
GtHideAttribute class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #accessing }
GtHideAttribute class >> constants [
	^ LepiterConstants
]

{ #category : #cleanup }
GtHideAttribute class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
GtHideAttribute class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GtHideAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ #()
]

{ #category : #accessing }
GtHideAttribute >> constants [
	^ LepiterConstants
]

{ #category : #initialization }
GtHideAttribute >> initialize [
	super initialize.
	self beReplace
]
