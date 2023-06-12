Class {
	#name : #LeExportResourceBuilder,
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
LeExportResourceBuilder >> addLocalResource: aResource [
	createdResources addResource: aResource
]

{ #category : #'private - building' }
LeExportResourceBuilder >> addResource: aResource [
	resources addResource: aResource.
	self addLocalResource: aResource
]

{ #category : #'api - building' }
LeExportResourceBuilder >> build [
	"Build resources"

	snippet acceptVisitor: self
]

{ #category : #accessing }
LeExportResourceBuilder >> createdResources [
	<return: #LeExportSnippetResources>
	^ LeExportSnippetResources new
		resources:createdResources asArray
]

{ #category : #'api - initialization' }
LeExportResourceBuilder >> fileStore: aFileStore [
	"Set a file store that is used to store some resources as files."

	fileStore := aFileStore
]

{ #category : #'gt - extensions' }
LeExportResourceBuilder >> gtResourcesFor: aView [
	<gtView>
	createdResources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Local resources';
		priority: 1;
		items: [ createdResources ifNil: [ #() ] ifNotNil: #asArray ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
]

{ #category : #initialization }
LeExportResourceBuilder >> initialize [
	super initialize.

	createdResources := LeExportResources new
]

{ #category : #convenience }
LeExportResourceBuilder >> nextFileReferenceTo: aRelativePath [
	<return: #FileReference>
	^ fileStore nextFileReferenceTo: aRelativePath
]

{ #category : #convenience }
LeExportResourceBuilder >> nextPath [
	<return: #RelativePath>
	^ self nextPathWithExtension: LepiterConstants exportedResultsExtension
]

{ #category : #convenience }
LeExportResourceBuilder >> nextPathWithExtension: anExtension [
	<return: #RelativePath>
	^ LepiterConstants exportedResultsDirectoryPath / self nextSequence asString
		withExtension: anExtension
]

{ #category : #convenience }
LeExportResourceBuilder >> nextSequence [
	<return: #String>
	^ sequencer nextId
]

{ #category : #'api - initialization' }
LeExportResourceBuilder >> objectSpecification: aLeExportObjectSpecification [
	"Set object specification for which resources are built."

	objectSpecification := aLeExportObjectSpecification
]

{ #category : #accessing }
LeExportResourceBuilder >> resources [
	<return: #TLeExportResources>
	^ resources
]

{ #category : #'api - initialization' }
LeExportResourceBuilder >> resources: aLeExportResources [
	"Set resources collection to which new resources are added."

	resources := aLeExportResources
]

{ #category : #'api - initialization' }
LeExportResourceBuilder >> sequencer: aSequencer [
	"Set a sequencer that generates unique IDs."

	sequencer := aSequencer
]

{ #category : #'api - initialization' }
LeExportResourceBuilder >> snippet: aSnippet [
	"Set a snippet instance where resources come from."

	snippet := aSnippet
]

{ #category : #visiting }
LeExportResourceBuilder >> visitContent: aLeContent [
	"We do not want to iterate snippet children"

	
]

{ #category : #visiting }
LeExportResourceBuilder >> visitSnippet: aLeSnippet [
	"We do not want to iterate snippet children"

	^ aLeSnippet
]
