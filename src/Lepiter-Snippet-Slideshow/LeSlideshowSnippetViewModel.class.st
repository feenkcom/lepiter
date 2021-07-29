Class {
	#name : #LeSlideshowSnippetViewModel,
	#superclass : #LePharoSnippetViewModel,
	#instVars : [
		'displayElement'
	],
	#category : #'Lepiter-Snippet-Slideshow-Snippet'
}

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> addSlide [
	self snippetModel addEmptySlide.
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> changeToSlideWithIndex: anIndex [
	^ self snippetModel changeToSlideWithIndex: anIndex.
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> codeHeight [
	^ self snippetModel codeHeight
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> collectSlides [
	^ self snippetModel slides.
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> currentSlideIndex [
	^ self snippetModel currentSlideIndex.
]

{ #category : #accessing }
LeSlideshowSnippetViewModel >> displayElement [
	<return: #BlElement>
	^ displayElement
]

{ #category : #accessing }
LeSlideshowSnippetViewModel >> displayElement: anElement [
	displayElement := anElement
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> doItAllRequestedBy: aRequesterObject [
	"Revaluate the content of the coder and return the result"
	<return: #Object>
	^ self coderViewModel doItAllRequestedBy: aRequesterObject
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> elementHeight [
	^ self snippetModel elementHeight
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> hasNextSlide [
	^ self snippetModel hasNextSlide.
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> hasPreviousSlide [
	^ self snippetModel hasPreviousSlide.
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> hideCode [
	| wasFocused |

	wasFocused := self focused.
	self coderViewModel focused: false.
	self snippetModel codeVisible: false.
	self focused: wasFocused
]

{ #category : #initialization }
LeSlideshowSnippetViewModel >> initialize [
	super initialize.
	displayElement := nil
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> nextSlide [
	^ self snippetModel nextSlide.
]

{ #category : #'private - notifying' }
LeSlideshowSnippetViewModel >> notifyCodeVisibilityChanged [
	self announce: (LeSlideshowSnippetViewModelCodeVisibilityChanged new)
]

{ #category : #'private - notifying' }
LeSlideshowSnippetViewModel >> notifyHeightChanged [
	self announce: (LeSlideshowSnippetViewModelHeightChanged new)
]

{ #category : #'private - event handling' }
LeSlideshowSnippetViewModel >> onCodeHeightChanged [
	self notifyHeightChanged
]

{ #category : #'private - event handling' }
LeSlideshowSnippetViewModel >> onCodeVisibilityChanged [
	self notifyCodeVisibilityChanged
]

{ #category : #'private - event handling' }
LeSlideshowSnippetViewModel >> onElementHeightChanged [
	self notifyHeightChanged
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> previousSlide [
	^ self snippetModel previousSlide.
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> rearrangeSlides [
	self snippetModel rearrangeSlides.
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> removeSlide [
	^ self snippetModel removeSlide.
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> resizeElementHeightTo: aNewHeight [
	| aDelta newCodeHeight |
	
	"is positive when increasing element height"
	aDelta := aNewHeight - self elementHeight.
	
	"should decrease code height first"
	newCodeHeight := (self codeHeight - aDelta) max: 0.
	
	self snippetModel elementHeight: self elementHeight + (self codeHeight - newCodeHeight).
	self snippetModel codeHeight: newCodeHeight
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> setElementHeightTo: aNewHeight [
	self snippetModel elementHeight: aNewHeight
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> shouldShowCode [
	^ self snippetModel codeVisible
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> showCode [
	self snippetModel codeVisible: true
]

{ #category : #accessing }
LeSlideshowSnippetViewModel >> snippetElementClass [
	^ LeSlideshowSnippetElement
]

{ #category : #accessing }
LeSlideshowSnippetViewModel >> snippetView [
	<return: #LeSnippetView>
	^ super snippetView needsContentDecorationBar: false
]

{ #category : #'api - snippet model' }
LeSlideshowSnippetViewModel >> subscribeToSnippetModel [
	super subscribeToSnippetModel.
	
	self snippetModel weak when: LeSlideshowSnippetElementHeightChanged
		send: #onElementHeightChanged
		to: self.

	self snippetModel weak when: LeSlideshowSnippetCodeHeightChanged
		send: #onCodeHeightChanged
		to: self.
		
	self snippetModel weak when: LeSlideshowSnippetCodeVisibilityChanged
		send: #onCodeVisibilityChanged
		to: self
]

{ #category : #'api - snippet model' }
LeSlideshowSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.
	self snippetModel unsubscribe: self
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> updateCurrentSlide [
	self snippetModel updateCurrentSlide.
]

{ #category : #'api - snippet' }
LeSlideshowSnippetViewModel >> updateSlidePreviewsAptitude [
	self snippetModel updateSlidePreviewsAptitude.
]
