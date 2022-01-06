Class {
	#name : #LeDateArgumentNode,
	#superclass : #LeArgumentNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeDateArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitDateArgument: self
]

{ #category : #accessing }
LeDateArgumentNode >> date [
	^ [ value ifNotNil: [ Date fromString: value source ] ] on: Error do: [ :ex | ex return ]
]

{ #category : #testing }
LeDateArgumentNode >> isDate [
	^ true
]
