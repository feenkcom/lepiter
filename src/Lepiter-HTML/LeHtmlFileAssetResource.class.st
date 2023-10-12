"
I am a HTML export resource, e.g., CSS and JavaScript file.
A {{gtMethod:LeHtmlFileAssetResource >> #sourceFile | label=source file}} content can be copied to an appropriate {{gtMethod:LeHtmlFileAssetResource >> #path | label=path}}. 
"
Class {
	#name : #LeHtmlFileAssetResource,
	#superclass : #Object,
	#traits : 'TLeExportResource',
	#classTraits : 'TLeExportResource classTrait',
	#instVars : [
		'sourceFile',
		'path'
	],
	#category : #'Lepiter-HTML-Resources - Model'
}

{ #category : #visiting }
LeHtmlFileAssetResource >> accept: aVisitor [
	^ aVisitor visitFileAssetResource: self
]

{ #category : #initialization }
LeHtmlFileAssetResource >> defaultState [
	<return: #LeExportResourceState>
	^ LeExportResourceState ready
]

{ #category : #testing }
LeHtmlFileAssetResource >> isAssetResource [
	^ true
]

{ #category : #accessing }
LeHtmlFileAssetResource >> path [
	"Return a path of the export"

	<return: #RelativePath>
	^ path
]

{ #category : #accessing }
LeHtmlFileAssetResource >> path: anObject [
	path := anObject
]

{ #category : #accessing }
LeHtmlFileAssetResource >> source [
	"Return a source of the export"

	^ sourceFile
]

{ #category : #accessing }
LeHtmlFileAssetResource >> sourceFile [
	<return: #FileReference>
	^ sourceFile
]

{ #category : #accessing }
LeHtmlFileAssetResource >> sourceFile: anObject [
	sourceFile := anObject
]

{ #category : #accessing }
LeHtmlFileAssetResource >> sourceType [
	"Return an object,e.g., a class, that represents the source type.
	I can be used for grouping resources by this type."

	^ self path withParents first 
]
