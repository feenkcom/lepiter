Class {
	#name : #LeExportObjectSpecification,
	#superclass : #Object,
	#traits : 'TLeExportObjectSpecification',
	#classTraits : 'TLeExportObjectSpecification classTrait',
	#instVars : [
		'specification',
		'object',
		'priority',
		'objectContext'
	],
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #accessing }
LeExportObjectSpecification >> object [
	^ object
]

{ #category : #accessing }
LeExportObjectSpecification >> object: anObject [
	object := anObject
]

{ #category : #accessing }
LeExportObjectSpecification >> priority [
	<return: #Number>
	^ priority
]

{ #category : #accessing }
LeExportObjectSpecification >> priority: anObject [
	priority := anObject
]

{ #category : #'api - building' }
LeExportObjectSpecification >> resourcer [
	"Return a resource builder that builds resources for given object specifications"

	<return: #TLeExportResourceBuilder>
	^ specification resourcerClass new objectSpecification: self
]

{ #category : #accessing }
LeExportObjectSpecification >> specification [
	<return: #TLeExportSpecification>
	^ specification
]

{ #category : #accessing }
LeExportObjectSpecification >> specification: anObject [
	specification := anObject
]
