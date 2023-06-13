Class {
	#name : #LeHtmlCarouselWriter,
	#superclass : #Object,
	#instVars : [
		'html',
		'sequencer',
		'carouselId',
		'resources'
	],
	#category : #'Lepiter-HTML-Writers'
}

{ #category : #accessing }
LeHtmlCarouselWriter >> html [
	^ html
]

{ #category : #accessing }
LeHtmlCarouselWriter >> html: anObject [
	html := anObject
]

{ #category : #accessing }
LeHtmlCarouselWriter >> resources [
	^ resources
]

{ #category : #accessing }
LeHtmlCarouselWriter >> resources: anObject [
	resources := anObject
]

{ #category : #accessing }
LeHtmlCarouselWriter >> sequencer [
	^ sequencer
]

{ #category : #accessing }
LeHtmlCarouselWriter >> sequencer: anObject [
	sequencer := anObject
]

{ #category : #'api - writing' }
LeHtmlCarouselWriter >> write [
	carouselId := sequencer nextId.

	html 
		tag: #div
		attributes: { 
			#id. carouselId. 
			#class. 'carousel slide'.
			'data-bs-theme'. 'dark' } 
		do: [
			html 
				tag: #div
				class: 'carousel-indicators'
				do: [ 
					self writeIndicators.
				].
			html
				tag: #div
				class: 'carousel-inner'
				do: [ 
					self writeSlides
				].
			self writePreviousButton.
			self writeNextButton.
		]
]

{ #category : #'private - writing' }
LeHtmlCarouselWriter >> writeIndicator: resource index: index [ 
	| attributes |
	attributes := OrderedCollection withAll: { 
		#type. #button. 
		'data-bs-target'. '#', carouselId.
		'data-bs-slide-to'. index - 1. }.
		
	index = 1 ifTrue: [ 
		attributes add: #class; add: 'active'.
		attributes add: 'aria-current'; add: 'true' ].
			
	attributes addAll: {
		'aria-label'. 'Slide {1}' format: { index } }.
	
	html 
		tag: #button
		attributes: attributes
]

{ #category : #'private - writing' }
LeHtmlCarouselWriter >> writeIndicators [

	resources withIndexDo: [ :resource :index | 
		self writeIndicator: resource index: index ]
]

{ #category : #'private - writing' }
LeHtmlCarouselWriter >> writeNextButton [

	html
		tag: #button
		attributes: {
			#class. 'carousel-control-next'.
			#type. #button.
			'data-bs-target'. '#', carouselId.
			'data-bs-slide'. 'next' }
		do: [
			html
				tag: #span
				attributes: {
					#class. 'carousel-control-next-icon'.
					'aria-hidden'. 'true' }.
			html
				tag: #span
				class: 'visually-hidden'
				with: 'Next'.
		]

]

{ #category : #'private - writing' }
LeHtmlCarouselWriter >> writePreviousButton [

	html
		tag: #button
		attributes: {
			#class. 'carousel-control-prev'.
			#type. #button.
			'data-bs-target'. '#', carouselId.
			'data-bs-slide'. 'prev' }
		do: [
			html
				tag: #span
				attributes: {
					#class. 'carousel-control-prev-icon'.
					'aria-hidden'. 'true' }.
			html
				tag: #span
				class: 'visually-hidden'
				with: 'Previous'.
		]

]

{ #category : #'private - writing' }
LeHtmlCarouselWriter >> writeSlide: resource index: index [ 

	html
		tag: #div
		class: 'carousel-item', (index = 1 ifTrue: [ ' active' ] ifFalse: [ '' ])
		do: [
			html 
				tag: #img
				attributes: { 
					'src'. resource pathName. 
					'class'. 'd-block w-100'.
					'alt'. 'Slide {1}' format: { index } }
		]
]

{ #category : #'private - writing' }
LeHtmlCarouselWriter >> writeSlides [

	resources withIndexDo: [ :resource :index | 
		self writeSlide: resource index: index ]
]
