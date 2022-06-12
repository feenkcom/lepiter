Class {
	#name : #LePreviewHeightArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePreviewHeightArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPreviewHeightArgument: self
]

{ #category : #generated }
LePreviewHeightArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LePreviewHeightArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LePreviewHeightArgumentNode >> isPreviewHeight [
	^ true
]

{ #category : #generated }
LePreviewHeightArgumentNode >> name [
	^ name
]

{ #category : #generated }
LePreviewHeightArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LePreviewHeightArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LePreviewHeightArgumentNode >> value [
	^ value
]

{ #category : #generated }
LePreviewHeightArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
