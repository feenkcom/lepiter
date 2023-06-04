Class {
	#name : #LeExportSpecifications,
	#superclass : #Object,
	#traits : 'TLeExportSpecifications',
	#classTraits : 'TLeExportSpecifications classTrait',
	#instVars : [
		'specifications'
	],
	#category : #'Lepiter-Export-Specification - Model'
}

{ #category : #'add / remove' }
LeExportSpecifications >> addSpecification: aSpecification [
	"Add new specification"

	self
		assert: [ aSpecification isNotNil ]
		description: [ 'Specification must be non-nil' ].

	specifications add: aSpecification
]

{ #category : #converting }
LeExportSpecifications >> asArray [
	"Return Array instance, representing this collection"

	<return: #Array>
	^ specifications asArray
]

{ #category : #enumerating }
LeExportSpecifications >> collect: collectBlock thenReject: rejectBlock [
	^ specifications collect: collectBlock thenReject: rejectBlock
]

{ #category : #enumerating }
LeExportSpecifications >> do: aBlock [
	specifications do: aBlock
]

{ #category : #'gt - extensions' }
LeExportSpecifications >> gtSpecificationsFor: aView [
	<gtView>
	specifications ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Specifications';
		priority: 10;
		items: [ specifications ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Name' text: #label
]

{ #category : #initialization }
LeExportSpecifications >> initialize [
	super initialize.

	specifications := OrderedCollection new
]
