Class {
	#name : #LeExportResources2,
	#superclass : #Object,
	#instVars : [
		'resources'
	],
	#category : #'Lepiter-HTML-! New - Resources'
}

{ #category : #'add / remove' }
LeExportResources2 >> addResource: aResource [
	resources add: aResource
]

{ #category : #converting }
LeExportResources2 >> asArray [
	^ resources asArray
]

{ #category : #enumerating }
LeExportResources2 >> do: aBlock [
	resources do: aBlock
]

{ #category : #'gt - extensions' }
LeExportResources2 >> gtResourcesFor: aView [
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
LeExportResources2 >> initialize [
	super initialize.
	resources := OrderedCollection new
]

{ #category : #accessing }
LeExportResources2 >> size [
	^ resources size
]
