Extension { #name : #LeExportSnippetExamples }

{ #category : #'*Lepiter-Snippet-Element' }
LeExportSnippetExamples >> elementSnippetWithGlamorousBreadcrumb [
	<gtExample>
	<return: #LeExportSnippetWithElementHolder>
	| element snippet |
	element := BrExamplesShowroom new glamorousBreadcrumb.

	self
		assert: (element isKindOf: BlElement)
		description: [ 'Element must be of BlElement kind' ].

	snippet := LeElementSnippet
			code: BrExamplesShowroom name , ' new ' , #glamorousBreadcrumb asString.

	^ LeExportSnippetWithElementHolder new
		snippet: snippet;
		element: element
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportSnippetExamples >> elementSnippetWithInexistentMethod [
	<gtExample>
	<return: #LeElementSnippet>
	| snippet |
	snippet := LeElementSnippet
			code: LeExportSnippetExamples name , ' new inexistentMethod'.

	^ snippet
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportSnippetExamples >> elementSnippetWithSlideshow [
	<gtExample>
	<return: #LeExportSnippetWithSlideshowHolder>
	| slideshow allSlides snippet |
	slideshow := GtPresenterSlideShow create: LeExportSlides new.
	allSlides := slideshow slides slides.

	self
		assert: allSlides size > 1
		description: [ 'Slideshow must have more than one slide' ].

	snippet := LeElementSnippet
			code: GtPresenterSlideShow name , ' ' , #create: asString , ' ' , LeExportSlides name
					, ' new'.

	^ LeExportSnippetWithSlideshowHolder new
		snippet: snippet;
		slideshow: slideshow;
		allSlides: allSlides
]

{ #category : #'*Lepiter-Snippet-Element' }
LeExportSnippetExamples >> elementSnippetWithZeroSlides [
	<gtExample>
	<return: #LeExportSnippetWithSlideshowHolder>
	| slideshow allSlides snippet |
	slideshow := GtPresenterSlideShow create: LeExportZeroSlides new.
	allSlides := slideshow slides slides.

	self
		assert: allSlides size isZero
		description: [ 'Slideshow must have zero slides' ].

	snippet := LeElementSnippet
			code: GtPresenterSlideShow name , ' ' , #create: asString , ' '
					, LeExportZeroSlides name , ' new'.

	^ LeExportSnippetWithSlideshowHolder new
		snippet: snippet;
		slideshow: slideshow;
		allSlides: allSlides
]
