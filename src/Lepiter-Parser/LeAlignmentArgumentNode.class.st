Class {
	#name : #LeAlignmentArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeAlignmentArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitAlignmentArgument: self
]

{ #category : #generated }
LeAlignmentArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeAlignmentArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #testing }
LeAlignmentArgumentNode >> isAlignment [
	^ true
]

{ #category : #generated }
LeAlignmentArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeAlignmentArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeAlignmentArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeAlignmentArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeAlignmentArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
