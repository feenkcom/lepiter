Class {
	#name : #LeExportPresenterSlideShowElementResourceBuilder,
	#superclass : #LeExportResourceBuilder,
	#instVars : [
		'allSlides',
		'elementHeight'
	],
	#category : #'Lepiter-Export-Resources - Builders'
}

{ #category : #accessing }
LeExportPresenterSlideShowElementResourceBuilder >> allSlides [
	<return: #GtPresenterSlide>
	^ allSlides
]

{ #category : #'api - building' }
LeExportPresenterSlideShowElementResourceBuilder >> buildSlides [
	"Build resources"

	allSlides
		ifEmpty: [ self exportSnippetElement ]
		ifNotEmpty: [ self exportSlides ]
]

{ #category : #'private - building' }
LeExportPresenterSlideShowElementResourceBuilder >> exportSlide: aSlide [
	| aPath aFileReference aResource |
	
	"Prepare file"
	aPath := self nextPath.
	aFileReference := self nextFileReferenceTo: aPath.

	aResource := LeExportSlideResource new
			slide: aSlide;
			snippet: snippet;
			path: aPath;
			height: elementHeight;
			reference: aFileReference.

	self addResource: aResource
]

{ #category : #'private - building' }
LeExportPresenterSlideShowElementResourceBuilder >> exportSlides [
	allSlides do: [ :aSlide | self exportSlide: aSlide ]
]

{ #category : #'private - building' }
LeExportPresenterSlideShowElementResourceBuilder >> exportSnippetElement [
	| aPath aFileReference aResource |
	
	"Prepare file"
	aPath := self nextPath.
	aFileReference := self nextFileReferenceTo: aPath.

	aResource := LeExportElementSnippetResource new
			snippet: snippet;
			element: objectSpecification object;
			path: aPath;
			height: elementHeight;
			reference: aFileReference.

	self addResource: aResource
]

{ #category : #'private - building' }
LeExportPresenterSlideShowElementResourceBuilder >> setSlides [
	allSlides := objectSpecification pickedObject slideShowViewModel slideShow
			slides slides
]

{ #category : #visiting }
LeExportPresenterSlideShowElementResourceBuilder >> visitElementSnippet: aLeElementSnippet [

	"Prepare slides"
	self setSlides.
	
	"Compute height"
	elementHeight := LeExportUtility elementSnippetHeightFor: aLeElementSnippet.
	
	self buildSlides.

	^ aLeElementSnippet.
]
