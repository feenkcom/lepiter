Class {
	#name : #LeDateArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeDateArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitDateArgument: self
]

{ #category : #accessing }
LeDateArgumentNode >> date [
	^ [ value ifNotNil: [ Date fromString: value source ] ] on: Error do: [ :ex | ex return ]
]

{ #category : #generated }
LeDateArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeDateArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeDateArgumentNode >> isDate [
	^ true
]

{ #category : #generated }
LeDateArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeDateArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeDateArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeDateArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeDateArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
