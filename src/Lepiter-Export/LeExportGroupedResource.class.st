Class {
	#name : #LeExportGroupedResource,
	#superclass : #Object,
	#instVars : [
		'type',
		'children'
	],
	#category : #'Lepiter-Export-Resources - Support'
}

{ #category : #'instance creation' }
LeExportGroupedResource class >> resources: aResources groupedBy: aBlock [
	| aDictionary aCollection |
	aDictionary := aResources asArray groupedBy: aBlock.
	
	aCollection := Array streamContents: [ :aStream | 
		aDictionary keysAndValuesDo: [ :aType :aValues | 
			| aChildren anInstance |
			aChildren := aValues collect: [ :each | 
				LeExportGroupedResourceChild new 
					resource: each ].
			
			anInstance := self new 
				type: aType;
				children: aChildren.
				
			aStream nextPut: anInstance
	] ].
	
	aCollection sort: [ :a :b | 
		a source gtDisplayString < b source gtDisplayString ].
		
	^ aCollection
]

{ #category : #accessing }
LeExportGroupedResource >> children [
	^ children
]

{ #category : #accessing }
LeExportGroupedResource >> children: anObject [
	children := anObject
]

{ #category : #'gt - extensions' }
LeExportGroupedResource >> gtResourcesFor: aView [
	<gtView>
	children ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Resources';
		priority: 1;
		items: [ children ifNil: [ #() ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
]

{ #category : #accessing }
LeExportGroupedResource >> object [
	^ children size = 1 ifTrue: [ children anyOne object ] ifFalse: [ self ]
]

{ #category : #accessing }
LeExportGroupedResource >> pathName [
	^ String streamContents: [ :aStream | 
		aStream
			print: children size;
			nextPutAll: (' resource' asPluralBasedOn: children size)
	]
]

{ #category : #accessing }
LeExportGroupedResource >> source [
	^ type
]

{ #category : #accessing }
LeExportGroupedResource >> state [
	| allStates stateTypes someChildren label name |
	children size = 1 ifTrue: [ ^ children anyOne state ].
	
	someChildren := children reject: [ :each | each source == type ].
	allStates := someChildren collect: #state.
	stateTypes := allStates groupedBy: #class.

	stateTypes size = 1 ifTrue: [ ^ allStates anyOne ].
	
	name := ''.
	label := '' asRopedText.
	
	stateTypes keysAndValuesDo: [ :stateClass :states | 
		name := name, ' ', states anyOne name.
		label ifNotEmpty: [ label append: ' ' asRopedText ].
		label append: states anyOne label.
	].

	^ LeExportGroupedResourceState new
		states: allStates;
		name: name;
		label: label
]

{ #category : #accessing }
LeExportGroupedResource >> type [
	^ type
]

{ #category : #accessing }
LeExportGroupedResource >> type: anObject [
	type := anObject
]
