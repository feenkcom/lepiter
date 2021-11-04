Class {
	#name : #GtEpiceaDiffAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TLepiterConstants',
	#classTraits : 'TLepiterConstants classTrait',
	#instVars : [
		'text'
	],
	#category : #'Lepiter-UI-Core-Epicea'
}

{ #category : #accessing }
GtEpiceaDiffAttribute class >> constants [
	^ LepiterConstants
]

{ #category : #accessing }
GtEpiceaDiffAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ BrLabel new
		text: self text;
		aptitude: BrGlamorousLabelAptitude new;
		background: Color gray;
		padding: (BlInsets all: 3)
]

{ #category : #initialization }
GtEpiceaDiffAttribute >> asInsert [
	self text: self constants insertLineIdentificator asRopedText.
	self text foreground: self constants insertLineColor.
]

{ #category : #initialization }
GtEpiceaDiffAttribute >> asMatch [
	self text: self constants matchLineIdentificator asRopedText glamorousCodeFontAndSize.
	self text foreground: self constants matchLineColor.
]

{ #category : #initialization }
GtEpiceaDiffAttribute >> asRemove [
	self text: self constants removeLineIdentificator asRopedText glamorousCodeFontAndSize.
	self text foreground: self constants removeLineColor.
]

{ #category : #accessing }
GtEpiceaDiffAttribute >> constants [
	^ LepiterConstants
]

{ #category : #initialization }
GtEpiceaDiffAttribute >> initialize [
	super initialize.
	self asMatch.
	self beAppend.
]

{ #category : #accessing }
GtEpiceaDiffAttribute >> text [
	^ text
]

{ #category : #accessing }
GtEpiceaDiffAttribute >> text: anObject [
	text := anObject
]
