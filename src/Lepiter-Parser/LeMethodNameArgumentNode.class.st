Class {
	#name : #LeMethodNameArgumentNode,
	#superclass : #LeClassNameArgumentNode,
	#instVars : [
		'gtGt',
		'selector'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeMethodNameArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitMethodNameArgument: self
]

{ #category : #accessing }
LeMethodNameArgumentNode >> fullName [
	^ self className asString , '>>#' , self methodName asString
]

{ #category : #generated }
LeMethodNameArgumentNode >> gtGt [
	^ gtGt
]

{ #category : #generated }
LeMethodNameArgumentNode >> gtGt: aSmaCCToken [
	gtGt := aSmaCCToken
]

{ #category : #accessing }
LeMethodNameArgumentNode >> imageObject [
	| aBehavior aMethod |
	aBehavior := super imageObject.
	aBehavior isBehavior ifFalse: [ ^ nil ].
	
	aMethod := aBehavior lookupSelector: self methodName.
	aMethod ifNil: [ ^ nil ].
	
	^ aMethod asActiveRingDefinition.
]

{ #category : #accessing }
LeMethodNameArgumentNode >> methodName [
	^ self selectorFrom: selector source
]

{ #category : #generated }
LeMethodNameArgumentNode >> selector [
	^ selector
]

{ #category : #generated }
LeMethodNameArgumentNode >> selector: aSmaCCToken [
	selector := aSmaCCToken
]

{ #category : #generated }
LeMethodNameArgumentNode >> tokenVariables [
	^ #(#gtGt #selector #classToken #name #equals #value)
]
