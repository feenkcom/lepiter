Class {
	#name : #LeHtmlNoPageExportPart,
	#superclass : #Object,
	#traits : 'TLeHtmlPageExportPart + TGtUniqueInstance',
	#classTraits : 'TLeHtmlPageExportPart classTrait + TGtUniqueInstance classTrait',
	#category : #'Lepiter-HTML-Old-Helpers'
}

{ #category : #'api - initialization' }
LeHtmlNoPageExportPart >> withPageExportPart: aPageExportPart [
	^ aPageExportPart
]
