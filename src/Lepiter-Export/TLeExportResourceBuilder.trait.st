Trait {
	#name : #TLeExportResourceBuilder,
	#category : #'Lepiter-Export-Resources - Support'
}

{ #category : #'api - building' }
TLeExportResourceBuilder >> build [
	"Build resources"

	self explicitRequirement
]

{ #category : #'api - initialization' }
TLeExportResourceBuilder >> fileStore: aFileStore [
	"Set a file store that is used to store some resources as files."

	self explicitRequirement
]

{ #category : #'api - initialization' }
TLeExportResourceBuilder >> objectSpecification: aLeExportObjectSpecification [
	"Set object specification for which resources are built."

	self explicitRequirement
]

{ #category : #'api - initialization' }
TLeExportResourceBuilder >> resources: aLeExportResources [
	"Set resources collection to which new resources are added."

	self explicitRequirement
]

{ #category : #'api - initialization' }
TLeExportResourceBuilder >> sequencer: aSequencer [
	"Set a sequencer that generates unique IDs."

	self explicitRequirement
]

{ #category : #'api - initialization' }
TLeExportResourceBuilder >> snippet: aSnippet [
	"Set a snippet instance where resources come from."

	self explicitRequirement
]
