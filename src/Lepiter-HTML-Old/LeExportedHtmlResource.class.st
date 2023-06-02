Class {
	#name : #LeExportedHtmlResource,
	#superclass : #Object,
	#traits : 'TLeExportResource',
	#classTraits : 'TLeExportResource classTrait',
	#instVars : [
		'content',
		'pageLink'
	],
	#category : #'Lepiter-HTML-Old-Model'
}

{ #category : #visiting }
LeExportedHtmlResource >> accept: aVisitor [
	^ aVisitor visitExportedHtmlResource: self
]

{ #category : #accessing }
LeExportedHtmlResource >> content [
	<return: #String>
	^ content
]

{ #category : #accessing }
LeExportedHtmlResource >> content: aString [
	content := aString
]

{ #category : #'gt - extensions' }
LeExportedHtmlResource >> gtContentFor: aView [
	<gtView>
	^ aView textEditor
		title: 'HTML';
		priority: 5;
		text: [ self content ifNil: [ '' ] ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		actionUpdateButton
]

{ #category : #'gt - extensions' }
LeExportedHtmlResource >> gtLiveFor: aView [
	<gtView>
	self pageLink ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self pageLink ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeExportedHtmlResource >> pageLink [
	<return: #TLeHtmlBookPageLink>
	^ pageLink
]

{ #category : #accessing }
LeExportedHtmlResource >> pageLink: aTLeHtmlBookPageLink [
	pageLink := aTLeHtmlBookPageLink
]

{ #category : #accessing }
LeExportedHtmlResource >> path [
	"Return a path of the export"

	<return: #RelativePath>
	^ Path * self pageLink fileName
]

{ #category : #accessing }
LeExportedHtmlResource >> source [
	"Return a source of the export"

	^ self pageLink page
]
