Class {
	#name : #LeExportExternalImageSnippetResource,
	#superclass : #LeExportedSnippetResource,
	#instVars : [
		'imgSrc'
	],
	#category : #'Lepiter-HTML-! New - Model'
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
