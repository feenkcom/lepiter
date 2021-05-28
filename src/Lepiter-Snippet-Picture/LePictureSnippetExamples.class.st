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
