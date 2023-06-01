Trait {
	#name : #TLeExportResourcesAssembler,
	#instVars : [
		''
	],
	#category : #'Lepiter-Export-Resources - Builders'
}

{ #category : #'api - building' }
TLeExportResourcesAssembler >> assemble [
	"Assemble all non-ready resources"
]

{ #category : #accessing }
TLeExportResourcesAssembler >> resources: aLeExportResources [
	self explicitRequirement
]
