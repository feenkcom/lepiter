Class {
	#name : #LePackageTagArgumentNode,
	#superclass : #LeArgumentNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePackageTagArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPackageTagArgument: self
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
