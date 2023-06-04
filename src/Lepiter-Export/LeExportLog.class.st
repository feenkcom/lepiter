Class {
	#name : #LeExportLog,
	#superclass : #Object,
	#traits : 'TLeExportLog',
	#classTraits : 'TLeExportLog classTrait',
	#instVars : [
		'items'
	],
	#category : #'Lepiter-Export-Log - Model'
}

{ #category : #'add / remove' }
LeExportLog >> addItem: aLogItem [
	items add: aLogItem
]

{ #category : #converting }
LeExportLog >> asArray [
	^ items asArray
]

{ #category : #'gt - extensions' }
LeExportLog >> gtLogItemsFor: aView [
	<gtView>
	items ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Log';
		priority: 10;
		items: [ items reversed ];
		column: 'Index'
			text: [ :_ :anIndex | items size - anIndex + 1 ]
			width: 40;
		column: 'Name' text: #label;
		column: 'Description'
			text: #description
			weight: 3
]

{ #category : #initialization }
LeExportLog >> initialize [
	super initialize.
	items := OrderedCollection new
]
