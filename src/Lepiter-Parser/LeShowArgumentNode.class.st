Class {
	#name : #LeShowArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeShowArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitShowArgument: self
]

{ #category : #generated }
LeShowArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeShowArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeShowArgumentNode >> isShow [
	^ true
]

{ #category : #generated }
LeShowArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeShowArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeShowArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeShowArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeShowArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
