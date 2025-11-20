Class {
	#name : #LeClassAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeClassAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitClassAnnotation: self
]

{ #category : #'as yet unclassified' }
LeClassAnnotationNode >> contextMenuModelForHostElement: aHostElement [
	| aClass |
	aClass := self imageObject.
	^ aClass
		ifNotNil: [ GtCoderClassTarget
				menuItemsForObject: aClass
				hostElement: aHostElement ]
]

{ #category : #testing }
LeClassAnnotationNode >> hasContextMenuModel [
	^ self doesReferenceExist
]

{ #category : #accessing }
LeClassAnnotationNode >> referencedClassName [
	^ self nameNode className
]
