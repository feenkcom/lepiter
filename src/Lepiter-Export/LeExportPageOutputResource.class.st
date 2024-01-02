Class {
	#name : #LeExportPageOutputResource,
	#superclass : #Object,
	#traits : 'TLeExportResource',
	#classTraits : 'TLeExportResource classTrait',
	#instVars : [
		'pageLink',
		'contents',
		'hrefBuilder'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #visiting }
LeExportPageOutputResource >> acceptVisitor: aVisitor [
	^ aVisitor visitLeExportPageOutputResource: self
]

{ #category : #accessing }
LeExportPageOutputResource >> content [
	<return: #String>
	^ contents
]

{ #category : #accessing }
LeExportPageOutputResource >> content: aString [
	contents := aString
]

{ #category : #accessing }
LeExportPageOutputResource >> contents [
	<return: #String>
	^ contents
]

{ #category : #accessing }
LeExportPageOutputResource >> contents: aString [
	contents := aString
]

{ #category : #accessing }
LeExportPageOutputResource >> defaultHrefBuilder [
	^ LeExportFilenameAndExtensionHypertextReferenceBuilder new
]

{ #category : #initialization }
LeExportPageOutputResource >> defaultState [
	<return: #LeExportResourceState>
	^ LeExportResourceState  ready
]

{ #category : #'gt - extensions' }
LeExportPageOutputResource >> gtContentFor: aView [
	<gtView>
	^ aView textEditor
		title: 'HTML';
		priority: 5;
		text: [ self content ifNil: [ '' ] ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
LeExportPageOutputResource >> gtLiveFor: aView [
	<gtView>
	self pageLink ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self pageLink ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeExportPageOutputResource >> hrefBuilder [
	<return: #TLeExportHypertextReferenceBuilder>
	^ hrefBuilder ifNil: [ hrefBuilder := self defaultHrefBuilder ]
]

{ #category : #accessing }
LeExportPageOutputResource >> hrefBuilder: aBuilder [
	hrefBuilder := aBuilder
]

{ #category : #accessing }
LeExportPageOutputResource >> pageLink [
	<return: #TLeExportBookPageLink>
	^ pageLink
]

{ #category : #accessing }
LeExportPageOutputResource >> pageLink: aTLeHtmlBookPageLink [
	pageLink := aTLeHtmlBookPageLink
]

{ #category : #accessing }
LeExportPageOutputResource >> path [
	"Return a path of the export"

	<return: #RelativePath>
	^ Path * (self hrefBuilder hrefFromPageLink: self pageLink)
]

{ #category : #accessing }
LeExportPageOutputResource >> source [
	"Return a source of the export"

	^ self pageLink page
]

{ #category : #accessing }
LeExportPageOutputResource >> sourceType [
	"Return an object,e.g., a class, that represents the source type.
	I can be used for grouping resources by this type."

	^ self pageLink page
]
