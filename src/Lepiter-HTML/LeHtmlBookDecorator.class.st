Class {
	#name : #LeHtmlBookDecorator,
	#superclass : #Object,
	#traits : 'TLeHtmlPageDecorator',
	#classTraits : 'TLeHtmlPageDecorator classTrait',
	#instVars : [
		'pageDecorator'
	],
	#category : #'Lepiter-HTML-Helpers'
}

{ #category : #'api - writing' }
LeHtmlBookDecorator >> addResourcesInto: aResourcesExporter [
	"Add extra (asset) files to a page HTML export.
	
	Do nothing. The book exporter adds when all pages are exported."
]

{ #category : #'api - initialization' }
LeHtmlBookDecorator >> initializeHTMLPageExporter: anExporter [
	"Configure a {{gtClass:LeHtmlPageExporterVisitor}} instance before a page export"

	pageDecorator ifNotNil: [ :aDecorator | 
		aDecorator initializeHTMLPageExporter: anExporter ]
]

{ #category : #accessing }
LeHtmlBookDecorator >> pageDecorator [
	<return: #TLeHtmlPageDecorator or: nil>
	^ pageDecorator
]

{ #category : #accessing }
LeHtmlBookDecorator >> pageDecorator: aDecorator [
	pageDecorator := aDecorator
]

{ #category : #'api - writing' }
LeHtmlBookDecorator >> writeAssetFilesUsing: aXdWriter [
	"Write extra (asset) files to a page HTML export.
	
	Do nothig. The book exporter write assets when all pages are exported."

	
]
