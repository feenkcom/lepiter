Class {
	#name : #LeIdArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeIdArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitIdArgument: self
]

{ #category : #generated }
LeIdArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeIdArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeIdArgumentNode >> isId [
	^ true
]

{ #category : #generated }
LeIdArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeIdArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeIdArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeIdArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeIdArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
