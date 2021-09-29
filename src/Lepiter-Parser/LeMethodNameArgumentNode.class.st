Class {
	#name : 'LeMethodNameArgumentNode',
	#superclass : 'LeClassNameArgumentNode',
	#instVars : [
		'gtGt',
		'selector'
	],
	#category : 'Lepiter-Parser'
}

{ #category : 'generated' }
LeMethodNameArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitMethodNameArgument: self
]

{ #category : 'generated' }
LeMethodNameArgumentNode >> gtGt [
	^ gtGt
]

{ #category : 'generated' }
LeMethodNameArgumentNode >> gtGt: aSmaCCToken [
	gtGt := aSmaCCToken
]

{ #category : 'accessing' }
LeMethodNameArgumentNode >> imageObject [
	^ super imageObject
		ifNotNil: [ :cls | 
			cls isBehavior
				ifTrue: [ (cls compiledMethodAt: self methodName ifAbsent: [ nil ]) notNil
						ifTrue: [ RGMethodDefinition realClass: cls selector: self methodName ] ] ]
]

{ #category : 'accessing' }
LeMethodNameArgumentNode >> methodName [
	^ self selectorFrom: selector source
]

{ #category : 'generated' }
LeMethodNameArgumentNode >> selector [
	^ selector
]

{ #category : 'generated' }
LeMethodNameArgumentNode >> selector: aSmaCCToken [
	selector := aSmaCCToken
]

{ #category : 'generated' }
LeMethodNameArgumentNode >> tokenVariables [
	^ #(#gtGt #selector #classToken #name #equals #value)
]
