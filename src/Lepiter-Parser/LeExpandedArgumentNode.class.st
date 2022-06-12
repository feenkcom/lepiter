Class {
	#name : #LeExpandedArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeExpandedArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitExpandedArgument: self
]

{ #category : #generated }
LeExpandedArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeExpandedArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeExpandedArgumentNode >> isExpanded [
	^ true
]

{ #category : #generated }
LeExpandedArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeExpandedArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeExpandedArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeExpandedArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeExpandedArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
