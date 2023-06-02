Class {
	#name : #LeExportFileImageSnippetResource,
	#superclass : #LeExportSnippetResource,
	#category : #'Lepiter-HTML-Old-! New - Model'
}

{ #category : #accessing }
LeExportFileImageSnippetResource >> imgSrc [
	"Return image source URL"

	<return: #String>
	^ self pathName
]
