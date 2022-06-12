Class {
	#name : #LePackageTagArgumentNode,
	#superclass : #LeArgumentNode,
	#instVars : [
		'tag',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePackageTagArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPackageTagArgument: self
]

{ #category : #generated }
LePackageTagArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LePackageTagArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #accessing }
LePackageTagArgumentNode >> imageObjectOn: anImageObject [
	^ anImageObject classTagNamed: self value source asSymbol ifAbsent: [ nil ]
]

{ #category : #accessing }
LePackageTagArgumentNode >> isDefinedIn: anImageObject [
	^ (self imageObjectOn: anImageObject) notNil
]

{ #category : #accessing }
LePackageTagArgumentNode >> isTag [
	^ true
]

{ #category : #generated }
LePackageTagArgumentNode >> tag [
	^ tag
]

{ #category : #generated }
LePackageTagArgumentNode >> tag: aSmaCCToken [
	tag := aSmaCCToken
]

{ #category : #generated }
LePackageTagArgumentNode >> tokenVariables [
	^ #(#tag #equals #value)
]

{ #category : #generated }
LePackageTagArgumentNode >> value [
	^ value
]

{ #category : #generated }
LePackageTagArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
