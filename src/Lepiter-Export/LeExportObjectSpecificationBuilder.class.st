Class {
	#name : #LeExportObjectSpecificationBuilder,
	#superclass : #Object,
	#instVars : [
		'object',
		'specifications'
	],
	#category : #'Lepiter-Export-Specification - Support'
}

{ #category : #'api - building' }
LeExportObjectSpecificationBuilder >> build [
	self findSpecification
]

{ #category : #'api - building' }
LeExportObjectSpecificationBuilder >> findSpecification [
	| objectContext |
	objectContext := LeExportObjectSpecificationContext new
		specifications: specifications;
		object: object.
	
	specifications do: [ :each | 
		each objectSpecificationFor: objectContext ].
]

{ #category : #accessing }
LeExportObjectSpecificationBuilder >> object [
	^ object
]

{ #category : #accessing }
LeExportObjectSpecificationBuilder >> object: anObject [
	object := anObject
]

{ #category : #accessing }
LeExportObjectSpecificationBuilder >> specifications [
	^ specifications
]

{ #category : #accessing }
LeExportObjectSpecificationBuilder >> specifications: anObject [
	specifications := anObject
]
