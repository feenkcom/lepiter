Class {
	#name : #LeLabelArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeLabelArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitLabelArgument: self
]

{ #category : #generated }
LeLabelArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeLabelArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeLabelArgumentNode >> isLabel [
	^ true
]

{ #category : #accessing }
LeLabelArgumentNode >> labelFor: anObject [
	| label |
	label := self stringValue.
	^ (label beginsWith: '#')
		ifTrue: [ [ (anObject perform: label allButFirst trimBoth asSymbol) asString ]
				on: Error
				do: [ :anException | anException printString ] ]
		ifFalse: [ label ]
]

{ #category : #generated }
LeLabelArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeLabelArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeLabelArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeLabelArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeLabelArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
