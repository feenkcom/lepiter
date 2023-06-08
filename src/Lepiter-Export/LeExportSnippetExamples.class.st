Class {
	#name : #LeExportSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #examples }
LeExportSnippetExamples >> elementSnippetWithGlamorousBreadcrumb [
	<gtExample>
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

{ #category : #examples }
LeExportSnippetExamples >> elementSnippetWithInexistentMethod [
	<gtExample>
	| snippet |

	snippet := LeElementSnippet
			code: LeExportSnippetExamples name , ' new inexistentMethod'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> elementSnippetWithSlideshow [
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
LeExportSnippetExamples >> elementSnippetWithZeroSlides [
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

{ #category : #support }
LeExportSnippetExamples >> pictureFile_ExistingOne [
	^ (GtResourcesUtility resourceAtPath: Path 
		* 'feenkcom'
		/ 'gtoolkit-demos' 
		/ 'data' 
		/ 'faceapi' 
		/ '1280px-Einstein-with-habicht-and-solovine.jpg') asUrl asString
]

{ #category : #support }
LeExportSnippetExamples >> pictureFile_MissingOne [
	^ (GtResourcesUtility resourceAtPath: Path 
		* 'feenkcom'
		/ 'gtoolkit' 
		/ 'data' 
		/ 'inexistent-image-file.jpg') asUrl asString
]

{ #category : #examples }
LeExportSnippetExamples >> pictureSnippetWithExistingFileReference [
	<gtExample>
	| snippet |
	snippet := LePictureSnippet new urlString: self pictureFile_ExistingOne.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> pictureSnippetWithHttps [
	<gtExample>
	| snippet |
	snippet := LePictureSnippet new urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> pictureSnippetWithMissingFileReference [
	<gtExample>
	| snippet |
	snippet := LePictureSnippet new urlString: self pictureFile_MissingOne.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotation [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtExample:', BrExamplesShowroom name, ' >> #', #glamorousLargeButton, '}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotationWithLabel [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtExample:', BrExamplesShowroom name, ' >> #', #glamorousLargeButton, ' | label=#printString}}'.

	^ snippet
]

{ #category : #examples }
LeExportSnippetExamples >> textSnippetWithExampleAnnotationWithPreviewExpanded [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtExample:', BrExamplesShowroom name, ' >> #', #glamorousLargeButton, ' | previewExpanded=true}}'.

	^ snippet
]
