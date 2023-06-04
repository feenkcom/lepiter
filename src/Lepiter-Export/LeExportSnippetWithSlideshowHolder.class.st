Class {
	#name : #LeExportSnippetWithSlideshowHolder,
	#superclass : #Object,
	#instVars : [
		'snippet',
		'slideshow',
		'allSlides'
	],
	#category : #'Lepiter-Export-Examples'
}

{ #category : #accessing }
LeExportSnippetWithSlideshowHolder >> allSlides [
	^ allSlides
]

{ #category : #accessing }
LeExportSnippetWithSlideshowHolder >> allSlides: anObject [
	allSlides := anObject
]

{ #category : #'gt - extensions' }
LeExportSnippetWithSlideshowHolder >> gtAllSlidesFor: aView [
	<gtView>
	allSlides ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Slides';
		priority: 15;
		items: [ allSlides ifNil: [ #() ] ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' 
			text: [ :eachItem | eachItem gtDisplayText ].
]

{ #category : #'gt - extensions' }
LeExportSnippetWithSlideshowHolder >> gtSlideshowFor: aView [
	<gtView>
	slideshow ifNil: [ ^ aView empty ].
	allSlides ifNil: [ ^ aView empty ].
	allSlides ifEmpty: [ ^ aView empty ].

	^ aView forward
		title: 'Slideshow';
		priority: 10;
		object: [ slideshow ];
		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
LeExportSnippetWithSlideshowHolder >> gtSnippetFor: aView [
	<gtView>
	snippet ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Snippet';
		priority: 20;
		object: [ snippet ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeExportSnippetWithSlideshowHolder >> slideshow [
	^ slideshow
]

{ #category : #accessing }
LeExportSnippetWithSlideshowHolder >> slideshow: anObject [
	slideshow := anObject
]

{ #category : #accessing }
LeExportSnippetWithSlideshowHolder >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExportSnippetWithSlideshowHolder >> snippet: anObject [
	snippet := anObject
]
