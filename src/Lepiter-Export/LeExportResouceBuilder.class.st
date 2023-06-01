Class {
	#name : #LeExportResouceBuilder,
	#superclass : #Object,
	#traits : 'TLeExportResourceBuilder + TLeModelVisitor',
	#classTraits : 'TLeExportResourceBuilder classTrait + TLeModelVisitor classTrait',
	#instVars : [
		'objectSpecification',
		'resources',
		'sequencer',
		'fileStore',
		'snippet',
		'createdResources'
	],
	#category : #'Lepiter-Export-Resources - Builders'
}

{ #category : #'private - building' }
LeExportResouceBuilder >> addLocalResource: aResource [
	createdResources add: aResource
]

{ #category : #'private - building' }
LeExportResouceBuilder >> addResource: aResource [
	resources addResource: aResource.
	self addLocalResource: aResource
]

{ #category : #'api - building' }
LeExportResouceBuilder >> build [
	"Build resources"

	snippet acceptVisitor: self
]

{ #category : #accessing }
LeExportResouceBuilder >> createdResources [
	<return: #Array of: #TLeExportResource>
	^ createdResources asArray
]

{ #category : #'api - initialization' }
LeExportResouceBuilder >> fileStore: aFileStore [
	"Set a file store that is used to store some resources as files."

	fileStore := aFileStore
]

{ #category : #'gt - extensions' }
LeExportResouceBuilder >> gtResourcesFor: aView [
	<gtView>
	createdResources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Local resources';
		priority: 1;
		items: [ createdResources ifNil: [ #() ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
]

{ #category : #initialization }
LeExportResouceBuilder >> initialize [
	super initialize.

	createdResources := OrderedCollection new
]

{ #category : #convenience }
LeExportResouceBuilder >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ fileStore nextFileReferenceTo: aRelativePath
]

{ #category : #convenience }
LeExportResouceBuilder >> nextPath [
	<return: #RelativePath>
	^ self nextPathWithExtension: LepiterConstants exportedResultsExtension
]

{ #category : #convenience }
LeExportResouceBuilder >> nextPathWithExtension: anExtension [
	<return: #RelativePath>
	^ LepiterConstants exportedResultsDirectoryPath / self nextSequence asString
		withExtension: anExtension
]

{ #category : #convenience }
LeExportResouceBuilder >> nextSequence [
	<return: #String>
	^ sequencer nextId
]

{ #category : #'api - initialization' }
LeExportResouceBuilder >> objectSpecification: aLeExportObjectSpecification [
	"Set object specification for which resources are built."

	objectSpecification := aLeExportObjectSpecification
]

{ #category : #'api - initialization' }
LeExportResouceBuilder >> resources: aLeExportResources [
	"Set resources collection to which new resources are added."

	resources := aLeExportResources
]

{ #category : #'api - initialization' }
LeExportResouceBuilder >> sequencer: aSequencer [
	"Set a sequencer that generates unique IDs."

	sequencer := aSequencer
]

{ #category : #'api - initialization' }
LeExportResouceBuilder >> snippet: aSnippet [
	"Set a snippet instance where resources come from."

	snippet := aSnippet
]
