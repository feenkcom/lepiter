"
I am a HTML export resource, e.g., CSS and JavaScript file.
A {{gtMethod:LeFileAssetResource >> #sourceFile | label=source file}} content can be copied to an appropriate {{gtMethod:LeFileAssetResource >> #path | label=path}}. 
"
Class {
	#name : #LeFileAssetResource,
	#superclass : #Object,
	#traits : 'TLeExportedResource',
	#classTraits : 'TLeExportedResource classTrait',
	#instVars : [
		'sourceFile',
		'path'
	],
	#category : #'Lepiter-HTML-Model'
}

{ #category : #visiting }
LeFileAssetResource >> accept: aVisitor [
	^ aVisitor visitFileAssetResource: self
]

{ #category : #accessing }
LeFileAssetResource >> path [
	"Return a path of the export"

	<return: #RelativePath>
	^ path
]

{ #category : #accessing }
LeFileAssetResource >> path: anObject [
	path := anObject
]

{ #category : #accessing }
LeFileAssetResource >> source [
	"Return a source of the export"

	^ sourceFile
]

{ #category : #accessing }
LeFileAssetResource >> sourceFile [
	<return: #FileReference>
	^ sourceFile
]

{ #category : #accessing }
LeFileAssetResource >> sourceFile: anObject [
	sourceFile := anObject
]
