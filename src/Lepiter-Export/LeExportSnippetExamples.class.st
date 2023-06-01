Class {
	#name : #LeExportSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #examples }
LeExportSnippetExamples >> snippetElementWithSlideshow [
	<gtExample>

	| slideshow allSlides snippet |
	slideshow := GtPresenterSlideShow create: LeExportSlides new.
	allSlides := slideshow slides slides.

	self
		assert: allSlides size > 1
		description: [ 'Slideshow must have more than one slide' ].

	snippet := LeElementSnippet
			code: GtPresenterSlideShow name , ' ' , #create: asString , ' ' , LeExportSlides name , ' new'.
			
	^ LeExportSnippetWithSlideshowHolder new
		snippet: snippet;
		slideshow: slideshow;
		allSlides: allSlides
]

{ #category : #examples }
LeExportSnippetExamples >> snippetElementWithZeroSlides [
	<gtExample>

	| slideshow allSlides snippet |
	slideshow := GtPresenterSlideShow create: LeExportZeroSlides new.
	allSlides := slideshow slides slides.

	self
		assert: allSlides size isZero
		description: [ 'Slideshow must have zero slides' ].

	snippet := LeElementSnippet
			code: GtPresenterSlideShow name , ' ' , #create: asString , ' ' , LeExportZeroSlides name , ' new'.
			
	^ LeExportSnippetWithSlideshowHolder new
		snippet: snippet;
		slideshow: slideshow;
		allSlides: allSlides
]
