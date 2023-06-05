Class {
	#name : #LeExportObjectForwardSpecification,
	#superclass : #Object,
	#traits : 'TLeExportObjectSpecification',
	#classTraits : 'TLeExportObjectSpecification classTrait',
	#instVars : [
		'specification',
		'object',
		'forwardedTo'
	],
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #enumerating }
LeExportObjectForwardSpecification >> allObjectSpecifications [
	^ Array streamContents: [ :aStream | 
		self objectSpecificationsDo: [ :anObjectSpecification | 
			aStream nextPut: anObjectSpecification ] ]
]

{ #category : #accessing }
LeExportObjectForwardSpecification >> forwardedTo [
	<return: #TLeExportObjectSpecification>
	^ forwardedTo
]

{ #category : #accessing }
LeExportObjectForwardSpecification >> forwardedTo: anObjectSpecification [
	forwardedTo := anObjectSpecification
]

{ #category : #'gt - extensions' }
LeExportObjectForwardSpecification >> gtObjectSpecificationsFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'Object specifications';
		priority: 15;
		items: [ self allObjectSpecifications ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Object' text: #object;
		column: 'Specification' text: #specification;
		column: 'Priority' text: #priority width: 50
]

{ #category : #accessing }
LeExportObjectForwardSpecification >> object [
	^ object
]

{ #category : #accessing }
LeExportObjectForwardSpecification >> object: anObject [
	object := anObject
]

{ #category : #enumerating }
LeExportObjectForwardSpecification >> objectSpecificationsDo: aBlock [
	aBlock cull: self.
	forwardedTo objectSpecificationsDo: aBlock
]

{ #category : #accessing }
LeExportObjectForwardSpecification >> pickedObject [
	"Return object that was used to determine picked specification"

	^ forwardedTo pickedObject
]

{ #category : #accessing }
LeExportObjectForwardSpecification >> priority [
	<return: #Number>
	^ forwardedTo priority
]

{ #category : #'api - building' }
LeExportObjectForwardSpecification >> resourcer [
	<return: #TLeExportResourceBuilder>
	^ forwardedTo resourcer
		objectSpecification: self
]

{ #category : #accessing }
LeExportObjectForwardSpecification >> specification [
	<return: #TLeExportSpecification>
	^ specification
]

{ #category : #accessing }
LeExportObjectForwardSpecification >> specification: anObject [
	specification := anObject
]
