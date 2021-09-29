Class {
	#name : 'LePageArgumentNode',
	#superclass : 'LeArgumentNode',
	#category : 'Lepiter-Parser'
}

{ #category : 'generated' }
LePageArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPageArgument: self
]

{ #category : 'testing' }
LePageArgumentNode >> isDefined [

	^ value value isNotNil
]
