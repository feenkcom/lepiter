Class {
	#name : #LeExportSnippetResources,
	#superclass : #Object,
	#instVars : [
		'resources'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #'gt - extensions' }
LeExportSnippetResources >> gtResourcesFor: aView [
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

{ #category : #testing }
LeExportSnippetResources >> ifEmpty: emptyBlock ifOne: oneBlock ifMore: moreBlock [

	resources ifEmpty: [ ^ emptyBlock value ].
	^ resources size = 1
		ifTrue: [ oneBlock cull: resources anyOne ]
		ifFalse: [ moreBlock cull: resources ]
]

{ #category : #printing }
LeExportSnippetResources >> printOn: aStream [
	super printOn: aStream.

	resources ifNil: [ ^ self ].

	aStream
		space;
		nextPut: $[;
		print: resources size;
		nextPutAll: (' item' asPluralBasedOn: resources size);
		nextPut: $]
]

{ #category : #accessing }
LeExportSnippetResources >> resource [
	self
		assert: [ resources size = 1 ]
		description: [ 'There must be just one resource' ].
	^ resources
]

{ #category : #accessing }
LeExportSnippetResources >> resources [
	^ resources
]

{ #category : #accessing }
LeExportSnippetResources >> resources: aCollection [
	resources := aCollection
]
