Class {
	#name : #LeNameArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeNameArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitNameArgument: self
]

{ #category : #generated }
LeNameArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeNameArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #accessing }
LeNameArgumentNode >> imageObject [
	^ self subclassResponsibility
]

{ #category : #testing }
LeNameArgumentNode >> isDefined [
	^ self imageObject notNil
]

{ #category : #testing }
LeNameArgumentNode >> isName [
	^ true
]

{ #category : #generated }
LeNameArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeNameArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeNameArgumentNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LeNameArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeNameArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
