Class {
	#name : #LeMissingCodeReferencesAnnotationsVisitor,
	#superclass : #LeAnnotationParseNodeVisitor,
	#traits : 'TSmaCCComponentVisitor + (TLeAnnotationParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeAnnotationParseNodeVisitor classTrait',
	#instVars : [
		'missingReferences'
	],
	#category : 'Lepiter-Validator-Visitors'
}

{ #category : #visiting }
LeMissingCodeReferencesAnnotationsVisitor >> visitClassAnnotation: aClassAnnotation [
	super visitClassAnnotation: aClassAnnotation.
	aClassAnnotation doesReferenceExist ifFalse: [ 
		self composite missingReferences 
			addMissingClassAnnotation: aClassAnnotation ] 
]

{ #category : #generated }
LeMissingCodeReferencesAnnotationsVisitor >> visitExampleAnnotation: anExampleAnnotation [
	super visitExampleAnnotation: anExampleAnnotation.
	anExampleAnnotation doesReferenceExist ifFalse: [ 
		self composite missingReferences 
			addMissingExampleAnnotation: anExampleAnnotation ]
]

{ #category : #generated }
LeMissingCodeReferencesAnnotationsVisitor >> visitMethodAnnotation: aMethodAnnotation [
	super visitMethodAnnotation: aMethodAnnotation.
	aMethodAnnotation doesReferenceExist ifFalse: [ 
		self composite missingReferences 
			addMissingMethodAnnotation: aMethodAnnotation ]
]
