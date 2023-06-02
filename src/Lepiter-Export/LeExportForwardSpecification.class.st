Class {
	#name : #LeExportForwardSpecification,
	#superclass : #Object,
	#traits : 'TLeExportSpecification',
	#classTraits : 'TLeExportSpecification classTrait',
	#instVars : [
		'forwardTo',
		'classKind',
		'condition'
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
LeExportForwardSpecification >> condition [
	^ condition
]

{ #category : #accessing }
LeExportForwardSpecification >> condition: aBlock [
	"Set a block that receives one argument and returns a boolean value.
	The block returns true if a forward object is an expected one, e.g., non-nil."

	condition := aBlock
]

{ #category : #accessing }
LeExportForwardSpecification >> forwardTo [
	^ forwardTo
]

{ #category : #accessing }
LeExportForwardSpecification >> forwardTo: anObject [
	forwardTo := anObject
]

{ #category : #initialization }
LeExportForwardSpecification >> initialize [
	super initialize.
	
	condition := [ :forwardObject | true ]
]

{ #category : #accessing }
LeExportForwardSpecification >> label [
	<return: #BlRope or: #String>
	^ 'Forward {1} kind to {2}' format: {classKind. forwardTo}
]

{ #category : #'api - building' }
LeExportForwardSpecification >> objectSpecificationFor: objectContext [
	"Return specification that represents given object."

	<return: #TLeExportObjectSpecification or: nil>
	| anotherObject finder objectSpecification |
	(objectContext object isKindOf: classKind) ifFalse: [ ^ nil ].
	
	[ anotherObject := forwardTo cull: objectContext object ]
		on: Error 
		do: [ :anException | 
			"We should log this issue."
			self flag: #todo.
			^ nil ].
			
	[ (condition cull: anotherObject) ifFalse: [
		^ nil ]
		 ]
		on: Error 
		do: [ :anException | 
			"We should log this issue."
			self flag: #todo.
			^ nil ].
	
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
