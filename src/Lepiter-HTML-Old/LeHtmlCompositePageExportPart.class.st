Class {
	#name : #LeHtmlCompositePageExportPart,
	#superclass : #Object,
	#traits : 'TLeHtmlPageExportPart',
	#classTraits : 'TLeHtmlPageExportPart classTrait',
	#instVars : [
		'parts'
	],
	#category : #'Lepiter-HTML-Old-Helpers'
}

{ #category : #'api - exporting' }
LeHtmlCompositePageExportPart >> exportBodyContentPrecedingPart: aContext [
	"Export a content that is part of a HTML <body> tag 
	and precedes the main content (the page export)."

	parts do: [ :aPart | aPart exportBodyContentPrecedingPart: aContext ]
]

{ #category : #accessing }
LeHtmlCompositePageExportPart >> parts [
	^ parts ifNil: [ #() ]
]

{ #category : #accessing }
LeHtmlCompositePageExportPart >> parts: anObject [
	parts := anObject
]

{ #category : #'api - initialization' }
LeHtmlCompositePageExportPart >> withPageExportPart: aPageExportPart [
	^ self parts: (self parts copyWith: aPageExportPart)
]
