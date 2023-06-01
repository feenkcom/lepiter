Class {
	#name : #LeExportForwardSpecification,
	#superclass : #Object,
	#traits : 'TLeExportSpecification',
	#classTraits : 'TLeExportSpecification classTrait',
	#instVars : [
		'forwardTo',
		'classKind'
	],
	#category : #'Lepiter-HTML-! New - Specifications'
}

{ #category : #accessing }
LeExportForwardSpecification >> classKind [
	<return: #Class>
	^ classKind
]

{ #category : #accessing }
LeExportForwardSpecification >> classKind: aClass [
	classKind := aClass
]

{ #category : #accessing }
LeExportForwardSpecification >> forwardTo [
	^ forwardTo
]

{ #category : #accessing }
LeExportForwardSpecification >> forwardTo: anObject [
	forwardTo := anObject
]

{ #category : #'api - testing' }
LeExportForwardSpecification >> isForObject: anObject [
	"Return true if the specification covers given object"

	<return: #Boolean>
	^ anObject isKindOf: classKind
]

{ #category : #accessing }
LeExportForwardSpecification >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		print: classKind;
		nextPutAll: '>>';
		print: forwardTo;
		nextPut: $)
]
