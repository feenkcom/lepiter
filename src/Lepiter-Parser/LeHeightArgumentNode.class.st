Class {
	#name : #LeHeightArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeHeightArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitHeightArgument: self
]

{ #category : #generated }
LeHeightArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeHeightArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeHeightArgumentNode >> isHeight [
	^ true
]

{ #category : #generated }
LeHeightArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeHeightArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeHeightArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeHeightArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeHeightArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
