Trait {
	#name : #TLeHtmlPageDecorator,
	#category : #'Lepiter-HTML-Old-Helpers'
}

{ #category : #'api - writing' }
TLeHtmlPageDecorator >> addResourcesInto: aResourcesExporter [
	"Add extra (asset) files to a page HTML export."

	self explicitRequirement
]

{ #category : #'api - initialization' }
TLeHtmlPageDecorator >> initializeHTMLPageExporter: anExporter [
	"Configure a {{gtClass:LeHtmlPageExporterVisitor}} instance before a page export"

	self explicitRequirement
]

{ #category : #'api - writing' }
TLeHtmlPageDecorator >> writeAssetFilesUsing: aXdWriter [
	"Write extra (asset) files to a page HTML export."

	self explicitRequirement
]
