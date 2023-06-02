Class {
	#name : #LeExportResourcerResult,
	#superclass : #Object,
	#instVars : [
		'createdResources'
	],
	#category : #'Lepiter-HTML-Old-! New - Support'
}

{ #category : #asserting }
LeExportResourcerResult >> assertOneResource [
	self
		assert: [ createdResources size = 1 ]
		description: [ 'There must be exactly one resource but have {1} resources'
				format: {createdResources size} ]
]

{ #category : #'api - initialization' }
LeExportResourcerResult >> createdResources: aCollectionOfExportedResource [
	self
		assert: [ aCollectionOfExportedResource isNotNil ]
		description: [ 'Created resources must be non-nil' ].
	self
		assert: [ createdResources isNil ]
		description: [ 'Created resources must be initialized only once' ].
		
	createdResources := aCollectionOfExportedResource
]

{ #category : #'gt - extensions' }
LeExportResourcerResult >> gtResourcesFor: aView [
	<gtView>
	createdResources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Resources';
		priority: 1;
		items: [ createdResources ifNil: [ #() ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ]
]

{ #category : #accessing }
LeExportResourcerResult >> resource [
	<return: #TLeExportResource>
	self assertOneResource.

	^ createdResources anyOne
]

{ #category : #accessing }
LeExportResourcerResult >> resources [
	<return: #Array of: #TLeExportResource>
	^ createdResources
]

{ #category : #accessing }
LeExportResourcerResult >> size [
	^ createdResources size
]
