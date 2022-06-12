Class {
	#name : #LePreviewShowArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePreviewShowArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPreviewShowArgument: self
]

{ #category : #generated }
LePreviewShowArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LePreviewShowArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LePreviewShowArgumentNode >> isPreviewShow [
	^ true
]

{ #category : #generated }
LePreviewShowArgumentNode >> name [
	^ name
]

{ #category : #generated }
LePreviewShowArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LePreviewShowArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LePreviewShowArgumentNode >> value [
	^ value
]

{ #category : #generated }
LePreviewShowArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
