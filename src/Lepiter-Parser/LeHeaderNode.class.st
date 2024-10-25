Class {
	#name : #LeHeaderNode,
	#superclass : #LeContentNode,
	#instVars : [
		'numberSigns',
		'parts'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeHeaderNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitHeader: self
]

{ #category : #generated }
LeHeaderNode >> compositeNodeVariables [
	^ #(#parts)
]

{ #category : #generated }
LeHeaderNode >> compositeTokenVariables [
	^ #(#numberSigns)
]

{ #category : #accessing }
LeHeaderNode >> headerLevel [
	^ numberSigns size min: 6
]

{ #category : #accessing }
LeHeaderNode >> headerName [
	^ self topParent completeSource
		copyFrom: self startPosition + self headerLevel
		to: self stopPosition
]

{ #category : #accessing }
LeHeaderNode >> hidingInterval [
	^ self startPosition to: self hidingStopPosition
]

{ #category : #accessing }
LeHeaderNode >> hidingStartPosition [
	^ self startPosition
]

{ #category : #accessing }
LeHeaderNode >> hidingStopPosition [
	"We want to hide also first separators (spaces) and display just a header text.
	For example, if users type header like `# Title 1`, we want to hide `# ` (including spaces) part, not only `#`.
	See https://github.com/feenkcom/gtoolkit/issues/4131"

	| aTextIndex aPreviousPart |
	self parts ifEmpty: [ ^ self numberSigns last stopPosition ].
	aPreviousPart := nil.
	self parts do: [ :eachPart |
		(eachPart isKindOf: LeTextNode)
			ifFalse: [
				aPreviousPart ifNil: [ ^ self numberSigns last stopPosition ].
				^ aPreviousPart stopPosition ].
	
		aTextIndex := eachPart content findFirst: [ :each | each isSeparator not ].
		aTextIndex = 0 ifFalse: [	
			^ (eachPart startPosition + aTextIndex - 2) min: self stopPosition ].
		aPreviousPart := eachPart ].
		
	 ^ self numberSigns last stopPosition 
]

{ #category : #'generated-initialize-release' }
LeHeaderNode >> initialize [
	super initialize.
	numberSigns := OrderedCollection new: 2.
	parts := OrderedCollection new: 2.
]

{ #category : #testing }
LeHeaderNode >> isHeaderNode [
	^ true
]

{ #category : #generated }
LeHeaderNode >> numberSigns [
	^ numberSigns
]

{ #category : #generated }
LeHeaderNode >> numberSigns: anOrderedCollection [
	numberSigns := anOrderedCollection
]

{ #category : #generated }
LeHeaderNode >> parts [
	^ parts
]

{ #category : #generated }
LeHeaderNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]
