Class {
	#name : #LeExportVisitor,
	#superclass : #Object,
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-Export-! Core'
}

{ #category : #accessing }
LeExportVisitor >> context [
	<return: #TLeExportContext>
	^ context
]

{ #category : #accessing }
LeExportVisitor >> context: aContext [
	context := aContext
]

{ #category : #'private - exporting' }
LeExportVisitor >> specificationFor: anObject [
	<return: #TLeObjectExportSpecification>
	^ context specificationFor: anObject
]

{ #category : #visiting }
LeExportVisitor >> visitElementSnippet: aLeElementSnippet [

	| element specification |
	element := LeExportUtility newSnippetElementFor: aLeElementSnippet.
	specification := self specificationFor: element.
	
	"specification buildResource."

	^ self visitTextualSnippet: aLeElementSnippet
]
