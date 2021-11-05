Class {
	#name : #LeLabelArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeLabelArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitLabelArgument: self
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
