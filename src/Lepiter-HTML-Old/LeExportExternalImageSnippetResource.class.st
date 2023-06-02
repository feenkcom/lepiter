Class {
	#name : #LeExportExternalImageSnippetResource,
	#superclass : #LeExportSnippetResource,
	#instVars : [
		'imgSrc'
	],
	#category : #'Lepiter-HTML-Old-! New - Model'
}

{ #category : #accessing }
LeExportExternalImageSnippetResource >> imgSrc [
	^ imgSrc
]

{ #category : #accessing }
LeExportExternalImageSnippetResource >> imgSrc: anObject [
	imgSrc := anObject
]

{ #category : #accessing }
LeExportExternalImageSnippetResource >> pathName [
	^ self imgSrc
]
