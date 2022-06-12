Class {
	#name : #LeReturnArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeReturnArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitReturnArgument: self
]

{ #category : #generated }
LeReturnArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeReturnArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LeReturnArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeReturnArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeReturnArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeReturnArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeReturnArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
