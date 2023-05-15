Class {
	#name : #LeHtmlNoPageExportPart,
	#superclass : #Object,
	#traits : 'TLeHtmlPageExportPart + TGtUniqueInstance',
	#classTraits : 'TLeHtmlPageExportPart classTrait + TGtUniqueInstance classTrait',
	#category : #'Lepiter-HTML-Helpers'
}

{ #category : #'api - initialization' }
LeHtmlNoPageExportPart >> withPageExportPart: aPageExportPart [
	^ aPageExportPart
]
