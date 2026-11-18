Class {
	#name : #LeExportResourceAssemblerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Resources - Examples'
}

{ #category : #examples }
LeExportResourceAssemblerExamples >> optionalCachedPreview [
	<gtExample>
	| resource cache output resources |
	cache := FileSystem memory root / 'cached.png'.
	cache binaryWriteStreamDo: [ :out | out nextPutAll: #[1 2 3] ].
	resource := LeExportTextSnippetExampleAnnotationResource new
			reference: cache;
			path: (Path from: 'preview.png').
	resources := LeExportResources new.
	resources addResource: resource.
	self assert: resource isOptionalResource.
	LeExportResourcesAssembler new
		resources: resources;
		assemble.
	self assert: resource isOptionalResource.
	output := FileSystem memory root / 'output'.
	output ensureCreateDirectory.
	LeExportResourcesDirectorySaver new
		resources: resources;
		rootDirectory: output;
		save.
	self assert: output children isEmpty.
	resource beRequiredResource.
	self assert: resource isOptionalResource not.
	LeExportResourcesAssembler new
		resources: resources;
		assemble.
	self assert: resource state isReady.
	resource beRequiredResource.
	self assert: resource state isReady.
	LeExportResourcesDirectorySaver new
		resources: resources;
		rootDirectory: output;
		save.
	self assert: (output / 'preview.png') exists.
	resource beProblemMessage: 'Test failure'.
	resource beRequiredResource.
	self assert: resource state isFailure.
	^ resource
]
