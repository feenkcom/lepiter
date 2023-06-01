Class {
	#name : #LeExportContext,
	#superclass : #Object,
	#traits : 'TLeExportContext',
	#classTraits : 'TLeExportContext classTrait',
	#instVars : [
		'specifications'
	],
	#category : #'Lepiter-Export-! Core'
}

{ #category : #'api - builders' }
LeExportContext >> specificationFinder [
	^ LeExportObjectSpecificationFinder new
		specifications: specifications;
		find
]

{ #category : #'api - builders' }
LeExportContext >> specificationFor: anObject [
	"Return object specification for a given object"

	<return: #TLeObjectExportSpecification>
	^ self specificationFinder
		object: anObject;
		find;
		objectSpecification
]

{ #category : #accessing }
LeExportContext >> specifications [
	<return: #TLeExportSpecifications>
	^ specifications
]

{ #category : #accessing }
LeExportContext >> specifications: aTLeExportSpecifications [
	specifications := aTLeExportSpecifications
]
