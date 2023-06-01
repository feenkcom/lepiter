Class {
	#name : #LeExportResources,
	#superclass : #Object,
	#traits : 'TLeExportResources',
	#classTraits : 'TLeExportResources classTrait',
	#instVars : [
		'resources'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #'add / remove' }
LeExportResources >> addResource: aResource [
	resources add: aResource
]

{ #category : #converting }
LeExportResources >> asArray [
	^ resources asArray
]

{ #category : #enumerating }
LeExportResources >> do: aBlock [
	resources do: aBlock
]

{ #category : #'gt - extensions' }
LeExportResources >> gtResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Resources';
		priority: 1;
		items: [ resources ifNil: [ #() ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
]

{ #category : #accessing }
LeExportResources >> initialize [
	super initialize.
	resources := OrderedCollection new
]

{ #category : #accessing }
LeExportResources >> size [
	^ resources size
]
