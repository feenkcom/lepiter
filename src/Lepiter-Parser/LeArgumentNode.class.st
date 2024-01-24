Class {
	#name : #LeArgumentNode,
	#superclass : #LeAnnotationParseNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitArgument: self
]

{ #category : #accessing }
LeArgumentNode >> booleanValue [
	^ value isNil or: [ value source sameAs: 'true' ]
]

{ #category : #accessing }
LeArgumentNode >> booleanValueWithDefault: aBoolean [
	^ value isNil
		ifTrue: [ aBoolean ]
		ifFalse: [ value source sameAs: 'true' ]
]

{ #category : #private }
LeArgumentNode >> dequote: aString [
	| input |
	input := aString readStream.
	^ String
		streamContents: [ :output | 
			[ input atEnd ]
				whileFalse: [ output nextPutAll: (input upTo: $\).
					input atEnd
						ifFalse: [ output nextPut: input next ] ] ]
]

{ #category : #generated }
LeArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #accessing }
LeArgumentNode >> hasValidBooleanValue [
	value isNil
		ifTrue: [ ^ false ].

	^ (value source sameAs: 'true')
		or: [ (value source sameAs: 'false') ]
]

{ #category : #accessing }
LeArgumentNode >> integerValue [
	^ value notNil
		ifTrue: [ value source asInteger ]
]

{ #category : #testing }
LeArgumentNode >> isAlignment [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isCodeExpanded [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isDate [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isDb [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isDefined [

	^ name isNotNil and: [ value isNotNil ]
]

{ #category : #testing }
LeArgumentNode >> isExpanded [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isHeight [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isId [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isLabel [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isName [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isNoCode [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isPath [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isPreviewExpanded [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isPreviewHeight [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isPreviewSelect [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isPreviewShow [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isShow [
	^ false
]

{ #category : #testing }
LeArgumentNode >> isTag [
	^ false
]

{ #category : #generated }
LeArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
LeArgumentNode >> selectorFrom: aString [
	^ (self
		dequote:
			(aString first = $#
				ifTrue: [ aString allButFirst ]
				ifFalse: [ aString ])) asSymbol
]

{ #category : #accessing }
LeArgumentNode >> selectorValue [
	^ self selectorFrom: value source
]

{ #category : #accessing }
LeArgumentNode >> stringValue [
	^ value ifNil: [ '' ] ifNotNil: [ value source ]
]

{ #category : #generated }
LeArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
