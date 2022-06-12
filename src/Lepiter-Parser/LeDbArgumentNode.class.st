Class {
	#name : #LeDbArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeDbArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitDbArgument: self
]

{ #category : #generated }
LeDbArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeDbArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeDbArgumentNode >> isDb [
	^ true
]

{ #category : #generated }
LeDbArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeDbArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeDbArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeDbArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeDbArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
