Class {
	#name : #LePackageNameArgumentNode,
	#superclass : #LeNameArgumentNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePackageNameArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPackageNameArgument: self
]

{ #category : #accessing }
LePackageNameArgumentNode >> imageObject [
	^ RPackageOrganizer default packageNamed: value source asString ifAbsent: nil
]
