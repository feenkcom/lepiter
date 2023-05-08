Trait {
	#name : #TLeHtmlPageExportPart,
	#category : #'Lepiter-HTML-Helpers'
}

{ #category : #'api - exporting' }
TLeHtmlPageExportPart >> exportBodyContentPrecedingPart: aContext [
	"Export a content that is part of a HTML <body> tag 
	and precedes the main content (the page export)."

	
]

{ #category : #'api - initialization' }
TLeHtmlPageExportPart >> withPageExportPart: aPageExportPart [
	^ LeHtmlCompositePageExportPart new
		parts: {self. aPageExportPart}
]
