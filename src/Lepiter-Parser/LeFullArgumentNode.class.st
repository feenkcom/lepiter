Class {
	#name : #LeFullArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeFullArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitFullArgument: self
]

{ #category : #generated }
LeFullArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeFullArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LeFullArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeFullArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeFullArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeFullArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeFullArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
