Class {
	#name : #LePreviewExpandedArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePreviewExpandedArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPreviewExpandedArgument: self
]

{ #category : #generated }
LePreviewExpandedArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LePreviewExpandedArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LePreviewExpandedArgumentNode >> isPreviewExpanded [
	^ true
]

{ #category : #generated }
LePreviewExpandedArgumentNode >> name [
	^ name
]

{ #category : #generated }
LePreviewExpandedArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LePreviewExpandedArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LePreviewExpandedArgumentNode >> value [
	^ value
]

{ #category : #generated }
LePreviewExpandedArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
