Class {
	#name : #LeExportObjectSpecificationContext,
	#superclass : #Object,
	#instVars : [
		'object',
		'specifications'
	],
	#category : #'Lepiter-Export-Specification - Support'
}

{ #category : #enumerating }
LeExportObjectSpecificationContext >> allObjectContexts [
	^ Array streamContents: [ :aStream | 
		self objectContextsDo: [ :aContext | 
			aStream nextPut: aContext ] ]
]

{ #category : #'gt - extensions' }
LeExportObjectSpecificationContext >> gtAllObjectContextsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Object contexts';
		priority: 10;
		items: [ self allObjectContexts ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Object' text: #object
]

{ #category : #accessing }
LeExportObjectSpecificationContext >> object [
	^ object
]

{ #category : #accessing }
LeExportObjectSpecificationContext >> object: anObject [
	object := anObject
]

{ #category : #enumerating }
LeExportObjectSpecificationContext >> objectContextsDo: aBlock [
	aBlock cull: self
]

{ #category : #accessing }
LeExportObjectSpecificationContext >> specifications [
	^ specifications
]

{ #category : #accessing }
LeExportObjectSpecificationContext >> specifications: anObject [
	specifications := anObject
]
