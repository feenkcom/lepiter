Class {
	#name : #LeMethodAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeMethodAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitMethodAnnotation: self
]

{ #category : #testing }
LeMethodAnnotationNode >> contextMenuModelForHostElement: aHostElement [
	| aCompiledMethod |
	aCompiledMethod := self imageObject compiledMethod.
	^ aCompiledMethod
		ifNotNil: [ GtCoderMethodTarget
				menuItemsForObject: aCompiledMethod
				hostElement: aHostElement ]
]

{ #category : #testing }
LeMethodAnnotationNode >> hasContextMenuModel [
	^ self doesReferenceExist
]
