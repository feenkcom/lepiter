Class {
	#name : #LeExportExternalImageSnippetResource,
	#superclass : #LeExportSnippetResource,
	#instVars : [
		'imgSrc'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
LeExportExternalImageSnippetResource >> acceptVisitor: aVisitor [
	^ aVisitor visitExportExternalImageSnippetResource: self
]

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

{ #category : #printing }
LeExportExternalImageSnippetResource >> printDetailsOn: aStream [
	super printDetailsOn: aStream.
	aStream
		nextPutAll: ', imgSrc=';
		print: self imgSrc
]
