Class {
	#name : #LePictureSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #'examples - domain model' }
LePictureSnippetExamples >> defaultPictureSnippet [
	<gtExample>
	| pictureSnippet |

	pictureSnippet := LePictureSnippet new.
	self assert: pictureSnippet isEmpty.
	self assert: pictureSnippet urlString equals: ''.
	self assert: pictureSnippet caption equals: ''.
	self assert: pictureSnippet contentAsString equals: ''.

	^ pictureSnippet
]

{ #category : #'examples - view' }
LePictureSnippetExamples >> defaultPictureSnippetElement [
	<gtExample>
	| pictureSnippetViewModel pictureSnippetElement |
	
	pictureSnippetViewModel := self defaultPictureSnippetViewModel.
	
	pictureSnippetElement := pictureSnippetViewModel snippetElementClass new
		snippetViewModel: pictureSnippetViewModel.
		
	self assert: pictureSnippetElement snippetViewModel equals: pictureSnippetViewModel.
		
	^ pictureSnippetElement
]

{ #category : #'examples - view model' }
LePictureSnippetExamples >> defaultPictureSnippetViewModel [
	<gtExample>
	| pictureSnippet pictureSnippetViewModel |
	pictureSnippet := self defaultPictureSnippet.
	pictureSnippetViewModel := LePictureSnippetViewModel new
		snippetModel: pictureSnippet.
	self
		assert: pictureSnippetViewModel snippetModel
		equals: pictureSnippet.
	self
		assert: pictureSnippetViewModel snippetElementClass
		equals: LePictureSnippetElement.
	^ pictureSnippetViewModel
]

{ #category : #'examples - domain model' }
LePictureSnippetExamples >> pictureSnippetWithURL [
	<gtExample>
	| urlString pictureSnippet |
	
	urlString := 'https://domain.com/picture.jpg'.
	
	pictureSnippet := self defaultPictureSnippet.
	pictureSnippet urlString: urlString.
	
	self assert: pictureSnippet isEmpty not.
	self assert: pictureSnippet urlString equals: urlString.
	self assert: pictureSnippet contentAsString equals: urlString.

	^ pictureSnippet
]

{ #category : #'examples - domain model' }
LePictureSnippetExamples >> pictureSnippetWithURLAndCaption [
	<gtExample>
	| urlString pictureSnippet caption |
	
	urlString := 'https://domain.com/picture.jpg'.
	caption := 'Caption'.
	
	pictureSnippet := self defaultPictureSnippet.
	pictureSnippet urlString: urlString.
	pictureSnippet caption: caption.
	
	self assert: pictureSnippet isEmpty not.
	self assert: pictureSnippet urlString equals: urlString.
	self assert: pictureSnippet caption equals: caption.
	self assert: pictureSnippet contentAsString equals: urlString.

	^ pictureSnippet
]

{ #category : #'examples - domain model' }
LePictureSnippetExamples >> pictureSnippetWithURLCaptionAndPreviewHeight [
	<gtExample>
	| urlString pictureSnippet caption |
	
	urlString := 'https://domain.com/picture.jpg'.
	caption := 'Caption'.
	
	pictureSnippet := self defaultPictureSnippet.
	pictureSnippet urlString: urlString.
	pictureSnippet caption: caption.
	pictureSnippet previewHeight: 555.
	
	self assert: pictureSnippet isEmpty not.
	self assert: pictureSnippet urlString equals: urlString.
	self assert: pictureSnippet caption equals: caption.
	self assert: pictureSnippet previewHeight equals: 555.
	self assert: pictureSnippet contentAsString equals: urlString.

	pictureSnippet previewHeight: 556.
	self assert: pictureSnippet previewHeight equals: 556.

	pictureSnippet previewHeight: 555.
	self assert: pictureSnippet previewHeight equals: 555.

	^ pictureSnippet
]

{ #category : #'examples - view model' }
LePictureSnippetExamples >> pictureSnippetWithUrlViewModel [
	<gtExample>
	| pictureSnippet pictureSnippetViewModel |
	pictureSnippet := self pictureSnippetWithURL.
	pictureSnippetViewModel := LePictureSnippetViewModel new
		snippetModel: pictureSnippet.
	self
		assert: pictureSnippetViewModel snippetModel
		equals: pictureSnippet.
	self
		assert: pictureSnippetViewModel snippetElementClass
		equals: LePictureSnippetElement.
	^ pictureSnippetViewModel
]
