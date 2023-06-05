Class {
	#name : #LeExportFileImageSnippetResource,
	#superclass : #LeExportSnippetResource,
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #accessing }
LeExportFileImageSnippetResource >> imgSrc [
	"Return image source URL"

	<return: #String>
	^ self pathName
]
