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
LeExportResources >> assembledResources [
	| assembled |
	assembled := resources select: [ :each | each state isAssembledState ].
	assembled sort: [ :a :b | a state duration > b state duration ].
	^ assembled
]

{ #category : #enumerating }
LeExportResources >> collect: aBlock [
	^ resources collect: aBlock as: Array
]

{ #category : #enumerating }
LeExportResources >> do: aBlock [
	resources do: aBlock
]

{ #category : #enumerating }
LeExportResources >> failedResources [
	^ resources select: [ :each | each state isFailure ].
]

{ #category : #'gt - extensions' }
LeExportResources >> gtAssembledResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Assembled';
		priority: 20;
		items: [ self assembledResources ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Duration'
			text: [ :aResource | aResource state duration gtShortPrintString ]
			width: 70;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
]

{ #category : #'gt - extensions' }
LeExportResources >> gtFailedResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Failures';
		priority: 15;
		items: [ self failedResources ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
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

{ #category : #'gt - extensions' }
LeExportResources >> gtResourcesGroupedBySourceTypeFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Resources by types';
		priority: 9;
		items: [ LeExportGroupedResource 
			resources: self 
			groupedBy: #sourceType ];
		children: #children;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ];
		send: #object
]

{ #category : #accessing }
LeExportResources >> initialize [
	super initialize.
	resources := OrderedCollection new
]

{ #category : #printing }
LeExportResources >> printOn: aStream [
	super printOn: aStream.

	resources ifNil: [ ^ self ].

	aStream
		space;
		nextPut: $[;
		print: self size;
		nextPutAll: (' item' asPluralBasedOn: self size);
		nextPut: $]
]

{ #category : #enumerating }
LeExportResources >> select: aBlock [
	^ resources select: aBlock
]

{ #category : #accessing }
LeExportResources >> size [
	^ resources size
]
