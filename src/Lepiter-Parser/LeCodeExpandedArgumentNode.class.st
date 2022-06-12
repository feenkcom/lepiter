Class {
	#name : #LeCodeExpandedArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeCodeExpandedArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitCodeExpandedArgument: self
]

{ #category : #generated }
LeCodeExpandedArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeCodeExpandedArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeCodeExpandedArgumentNode >> isCodeExpanded [
	^ true
]

{ #category : #generated }
LeCodeExpandedArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeCodeExpandedArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeCodeExpandedArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeCodeExpandedArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeCodeExpandedArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
