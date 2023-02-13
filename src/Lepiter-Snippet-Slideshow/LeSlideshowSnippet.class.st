"
I represent an embedded slideshow within a Lepiter page.
"
Class {
	#name : #LeSlideshowSnippet,
	#superclass : #LeCodeSnippet,
	#instVars : [
		'codeVisible',
		'codeHeight',
		'elementHeight',
		'currentSlideIndex',
		'slides'
	],
	#category : #'Lepiter-Snippet-Slideshow-Snippet'
}

{ #category : #'instance creation' }
LeSlideshowSnippet class >> code: aString [
	^ self new code: aString
]

{ #category : #factory }
LeSlideshowSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		priority: 4;
		snippetClass: self;
		title: 'Slideshow'
]

{ #category : #factory }
LeSlideshowSnippet class >> empty [
	^ self new
]

{ #category : #'lepiter-store' }
LeSlideshowSnippet class >> leJsonV3AttributeMapping [
	^ super leJsonV3AttributeMapping
		"accessor in the snippet -> key in the json"
		add: (#elementHeight -> #elementHeight);
		add: (#codeHeight -> #codeHeight);
		add: (#codeVisible -> #codeVisible);
		add: (#slides -> #slides);
		remove: (#code -> #code);
		yourself
]

{ #category : #'lepiter-store' }
LeSlideshowSnippet class >> leJsonV3Name [
	^ 'slideshowSnippet'
]

{ #category : #'lepiter-store' }
LeSlideshowSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		"accessor in the snippet -> key in the json"
		add: (#elementHeight -> #elementHeight);
		add: (#codeHeight -> #codeHeight);
		add: (#codeVisible -> #codeVisible);
		add: (#slides -> #slides);
		remove: (#code -> #code);
		yourself
]

{ #category : #'lepiter-store' }
LeSlideshowSnippet class >> leJsonV4Name [
	^ 'slideshowSnippet'
]

{ #category : #visiting }
LeSlideshowSnippet >> acceptVisitor: aVisitor [
	^ aVisitor visitSlideshowSnippet: self
]

{ #category : #adding }
LeSlideshowSnippet >> addEmptySlide [
	self slides
		add: ( LeSlide new
			code: '';
			slideShow: self asSnippetViewModel snippetElementClass )
		afterIndex: currentSlideIndex.
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideIndex: index ].
]

{ #category : #accessing }
LeSlideshowSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeSlideshowSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeSlideshowSnippet >> changeToSlideWithIndex: anIndex [
	| slide |
	slide := self slides at: anIndex.
	currentSlideIndex := anIndex.
	^ slide code.
]

{ #category : #accessing }
LeSlideshowSnippet >> codeHeight [
	^ codeHeight
]

{ #category : #accessing }
LeSlideshowSnippet >> codeHeight: aNumber [
	(codeHeight closeTo: aNumber)
		ifTrue: [ ^ self ].

	codeHeight := aNumber rounded.
	
	self notifyAnnouncement: (LeSlideshowSnippetCodeHeightChanged new
		source: self;
		snippet: self)
]

{ #category : #accessing }
LeSlideshowSnippet >> codeVisible [
	^ codeVisible
]

{ #category : #accessing }
LeSlideshowSnippet >> codeVisible: aBoolean [
	codeVisible = aBoolean
		ifTrue: [ ^ self ].

	codeVisible := aBoolean.

	self notifyAnnouncement: (LeSlideshowSnippetCodeVisibilityChanged new
		source: self;
		snippet: self)
]

{ #category : #accessing }
LeSlideshowSnippet >> currentSlideIndex [
	^ currentSlideIndex
]

{ #category : #accessing }
LeSlideshowSnippet >> elementHeight [
	^ elementHeight
]

{ #category : #accessing }
LeSlideshowSnippet >> elementHeight: aNumber [
	(elementHeight closeTo: aNumber)
		ifTrue: [ ^ self ].

	elementHeight := aNumber rounded.
	
	self notifyAnnouncement: (LeSlideshowSnippetElementHeightChanged new
		source: self;
		snippet: self)
]

{ #category : #testing }
LeSlideshowSnippet >> hasNextSlide [
	^ self slides last slideIndex ~= currentSlideIndex.
]

{ #category : #testing }
LeSlideshowSnippet >> hasPreviousSlide [
	^ self slides first slideIndex ~= currentSlideIndex.
]

{ #category : #initialization }
LeSlideshowSnippet >> initialize [
	super initialize.

	slides := OrderedCollection new.
	currentSlideIndex := 0.
	self initializeSlides.
	self slides first isSlideSelected: true.
	self updateSlidePreviewsAptitude.
	elementHeight := 100.
	codeHeight := 50.
	codeVisible := true.
]

{ #category : #initialization }
LeSlideshowSnippet >> initializeSlides [
	(self slides size = 0)
		ifTrue: [ 
			self addEmptySlide ]
		ifFalse: [
			self slides withIndexDo: [ :slide :index | 
				slide
					slideIndex: index;
					slideShow: self asSnippetViewModel snippetElementClass ] ].
	currentSlideIndex := 1.
]

{ #category : #initialization }
LeSlideshowSnippet >> newCoder [
	^ GtPharoSnippetCoder new
]

{ #category : #accessing }
LeSlideshowSnippet >> nextSlide [
	currentSlideIndex := currentSlideIndex + 1.
	(self slides at: currentSlideIndex) isSlideSelected: true.
	self updateSlidePreviewsAptitude.
	^ self changeToSlideWithIndex: currentSlideIndex.
]

{ #category : #accessing }
LeSlideshowSnippet >> previousSlide [
	currentSlideIndex := currentSlideIndex - 1.
	(self slides at: currentSlideIndex) isSlideSelected: true.
	self updateSlidePreviewsAptitude.
	^ self changeToSlideWithIndex: currentSlideIndex.
]

{ #category : #'api - updating' }
LeSlideshowSnippet >> rearrangeSlides [
	| tempCollection |
	tempCollection := SortedCollection sortBlock: [ :a :b | a slideIndex < b slideIndex ].
	tempCollection addAll: self slides.
	self slides removeAll.
	self slides addAll: tempCollection.
]

{ #category : #accessing }
LeSlideshowSnippet >> removeSlide [
	| removedSlide |
	
	removedSlide := self slides at: currentSlideIndex.
	
	self slides remove: removedSlide.
	self slides withIndexDo: [ :slide :index | 
		slide 
			slideIndex: index ].
	(self slides isNotEmpty)
		ifTrue: [
			(removedSlide slideIndex = 1)
				ifTrue: [ ^ self slides first code ]
				ifFalse: [ 
					currentSlideIndex := currentSlideIndex - 1.
					(self slides at: currentSlideIndex) isSlideSelected: true.
					self updateSlidePreviewsAptitude.
					^ self changeToSlideWithIndex: currentSlideIndex ] ]
		ifFalse: [
			currentSlideIndex := 0.
			self addEmptySlide.
			currentSlideIndex := 1.
			(self slides at: currentSlideIndex) isSlideSelected: true.
			self updateSlidePreviewsAptitude.
			^ self changeToSlideWithIndex: currentSlideIndex ].
]

{ #category : #accessing }
LeSlideshowSnippet >> slides [
	^ slides
]

{ #category : #accessing }
LeSlideshowSnippet >> slides: aCollection [
	slides := aCollection asOrderedCollection.
	self initializeSlides.
]

{ #category : #'api - updating' }
LeSlideshowSnippet >> updateCurrentSlide [
	| slide |
	slide := self slides at: currentSlideIndex.
	slide code: self code.
	slide updateElements.
]

{ #category : #'api - updating' }
LeSlideshowSnippet >> updateSlidePreviewsAptitude [
	self slides
		do: [ :eachSlide |
			(eachSlide slideIndex = currentSlideIndex)
				ifTrue: [ eachSlide isSlideSelected: true ]
				ifFalse: [ eachSlide isSlideSelected: false ].
			eachSlide updatePreviewElementAptitude ].
]
