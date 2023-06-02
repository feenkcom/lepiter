Class {
	#name : #LeExportClassKindSpecification,
	#superclass : #Object,
	#traits : 'TLeExportSpecification',
	#classTraits : 'TLeExportSpecification classTrait',
	#instVars : [
		'classKind',
		'resourcerClass'
	],
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #accessing }
LeExportClassKindSpecification >> classKind [
	<return: #Class>
	^ classKind
]

{ #category : #accessing }
LeExportClassKindSpecification >> classKind: aClass [
	classKind := aClass
]

{ #category : #accessing }
LeExportClassKindSpecification >> label [
	<return: #BlRope or: #String>
	^ '{1} kind' format: { classKind }
]

{ #category : #'api - building' }
LeExportClassKindSpecification >> objectSpecificationFor: objectContext [
	"Return specification that represents given object."

	<return: #TLeExportObjectSpecification or: nil>
	^ (objectContext object isKindOf: classKind)
		ifTrue: [ 
			| priority |
			priority := LeExportSpecificationUtility
				distanceFromSubclass: objectContext object class 
				toSuperclass: classKind.
			^ LeExportObjectSpecification new
				object: objectContext object;
				priority: priority;
				specification: self ]
		ifFalse: [ nil ]
]

{ #category : #printing }
LeExportClassKindSpecification >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		print: classKind;
		nextPut: $)
]

{ #category : #'api - building' }
LeExportClassKindSpecification >> resourcerClass [
	<return: #'TLeExportResourceBuilder class'>
	^ resourcerClass
]

{ #category : #accessing }
LeExportClassKindSpecification >> resourcerClass: anObject [
	resourcerClass := anObject
]
