Class {
	#name : #LeNoCodeArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeNoCodeArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitNoCodeArgument: self
]

{ #category : #generated }
LeNoCodeArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeNoCodeArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeNoCodeArgumentNode >> isNoCode [
	^ true
]

{ #category : #generated }
LeNoCodeArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeNoCodeArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeNoCodeArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeNoCodeArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeNoCodeArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
