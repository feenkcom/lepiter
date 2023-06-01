Class {
	#name : #LeExportSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #examples }
LeExportSnippetExamples >> snippetElementWithSlideshow [
	<gtExample>

	| slideshow allSlides snippet |
	slideshow := GtPresenterSlideShow create: GtTour new.
	allSlides := slideshow slides slides.

	self
		assert: allSlides size > 1
		description: [ 'Slide show must have more than one slide' ].

	snippet := LeElementSnippet
			code: GtPresenterSlideShow name , ' ' , #create: asString , ' ' , GtTour name , ' new'.
			
	^ LeExportSnippetWithSlideshowHolder new
		snippet: snippet;
		slideshow: slideshow;
		allSlides: allSlides
]
