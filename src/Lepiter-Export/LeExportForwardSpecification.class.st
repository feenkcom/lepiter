Class {
	#name : #LeExportForwardSpecification,
	#superclass : #Object,
	#traits : 'TLeExportSpecification',
	#classTraits : 'TLeExportSpecification classTrait',
	#instVars : [
		'forwardTo',
		'classKind'
	],
	#category : #'Lepiter-Export-Specification - Model'
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

{ #category : #'api - building' }
LeExportForwardSpecification >> objectSpecificationFor: objectContext [
	"Return specification that represents given object."

	<return: #TLeExportObjectSpecification or: nil>
	| anotherObject finder objectSpecification |
	(objectContext object isKindOf: classKind) ifFalse: [ ^ nil ].
	
	anotherObject := forwardTo cull: objectContext object.
	
	objectSpecification := LeExportObjectForwardSpecification new
		object: objectContext object;
		specification: self.
	
	finder := LeExportObjectSpecificationForwardFinder new
		specifications: objectContext specifications;
		object: anotherObject;
		previousObjectContext: objectContext;
		find.
		
	objectSpecification
		forwardedTo: finder objectSpecification.
	
	^ objectSpecification
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
