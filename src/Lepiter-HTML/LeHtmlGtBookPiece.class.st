Class {
	#name : #LeHtmlGtBookPiece,
	#superclass : #Object,
	#traits : 'TLeHtmlPiece',
	#classTraits : 'TLeHtmlPiece classTrait',
	#instVars : [
		'formatPiece'
	],
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #'instance creation' }
LeHtmlGtBookPiece class >> fromFile: aFileReference [
	self
		assert: [ aFileReference exists ]
		description: [ 'File with template must exist: {1}' 
			format: {aFileReference} ].

	^ self new template: aFileReference contents
]

{ #category : #'instance creation' }
LeHtmlGtBookPiece class >> gtBook [
	^ self fromFile: FileLocator gtResource 
		/ 'feenkcom' 
		/ 'lepiter' 
		/ 'doc' 
		/ 'gtbook'
		/ 'page-template.html'
]

{ #category : #'instance creation' }
LeHtmlGtBookPiece class >> gtSinglePage [
	^ self fromFile: FileLocator gtResource 
		/ 'feenkcom' 
		/ 'lepiter' 
		/ 'doc' 
		/ 'gtbook'
		/ 'single-page-template.html'
]

{ #category : #initialization }
LeHtmlGtBookPiece >> initialize [
	super initialize.

	formatPiece := LeHtmlDoubleBracketFormatPiece new
		at: #title put: LeHtmlPageTitlePiece;
		at: #titleAttribute put: LeHtmlPageTitleAttributePiece;
		at: #descriptionAttribute put: LeHtmlPageDescriptionAttributePiece;
		at: #urlAttribute put: LeHtmlPageUrlAttributePiece;
		at: #gtVersion put: LeHtmlGToolkitVersionPiece;
		at: #navigation put: LeHtmlNavigationPiece;
		at: #content put: LeHtmlPagePiece;
		at: #date put: LeHtmlDatePiece;
		at: #author put: LeHtmlAuthorPiece
]

{ #category : #'api - initialization' }
LeHtmlGtBookPiece >> template: aTemplate [
	formatPiece template: aTemplate
]

{ #category : #'api - writing' }
LeHtmlGtBookPiece >> writeWithContext: aContext [
	formatPiece writeWithContext: aContext
]
