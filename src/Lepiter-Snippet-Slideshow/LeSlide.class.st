Class {
	#name : #LeSlide,
	#superclass : #LeContent,
	#instVars : [
		'coderUIModel',
		'code',
		'shouldPerformActionEveryTime',
		'onAddedToSceneGraphAction',
		'cachedElement',
		'slideIndex',
		'slideShow',
		'isSlideSelected',
		'previewElement'
	],
	#category : #'Lepiter-Snippet-Slideshow-Slide'
}

{ #category : #'lepiter-store' }
LeSlide class >> leJsonV3AttributeMapping [
	^ super leJsonV3AttributeMapping
		"accessor in the snippet -> key in the json"
		add: (#code -> #code);
		add: (#slideIndex -> #slideIndex);
		add: (#isSlideSelected -> #isSlideSelected);
		remove: (#children -> #children);
		yourself
]

{ #category : #'lepiter-store' }
LeSlide class >> leJsonV3Name [
	^ 'slide'
]

{ #category : #'lepiter-store' }
LeSlide class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		"accessor in the snippet -> key in the json"
		add: (#code -> #code);
		add: (#slideIndex -> #slideIndex);
		add: (#isSlideSelected -> #isSlideSelected);
		remove: (#children -> #children);
		yourself
]

{ #category : #'lepiter-store' }
LeSlide class >> leJsonV4Name [
	^ 'slide'
]

{ #category : #accessing }
LeSlide >> asCachedElement [
	"Answer the receiver's cached element.
	Must be called from the UI process."

	^ cachedElement
]

{ #category : #accessing }
LeSlide >> asPreviewElement [
	"Answer the receiver's preview element.
	Must be called from the UI process."

	^ previewElement
]

{ #category : #accessing }
LeSlide >> cachedElement [
	^ cachedElement
]

{ #category : #accessing }
LeSlide >> cachedElement: anObject [
	cachedElement := anObject
]

{ #category : #accessing }
LeSlide >> code [
	^ code.
]

{ #category : #accessing }
LeSlide >> code: aString [
	code := aString.
	self updateCoderUIModel.
]

{ #category : #accessing }
LeSlide >> coder [
	^ coderUIModel coder.
]

{ #category : #accessing }
LeSlide >> coderUIModel [
	^ coderUIModel.
]

{ #category : #initialization }
LeSlide >> generateElements [
	"Generate the receiver's element and preview"
	| element formElement |

	element := self runSnippetCode.
	formElement := element asSpartaForm asElement asPannableElement.
	slideShow enqueueTask: (BlTaskAction new action: [
		cachedElement
			removeChildren;
			slideElement: element.
		(self shouldPerformActionEveryTime)
			ifTrue: [
				cachedElement
					when: BlElementAddedToSceneGraphEvent
					do: [:anEvent |
						anEvent consumed: true.
						self performActionOn: element]]
			ifFalse: [
				cachedElement
					when: BlElementAddedToSceneGraphEvent
					doOnce: [:anEvent |
						anEvent consumed: true.
						self performActionOn: element]].
		previewElement
			removeChildren;
			addChild: formElement ]).
]

{ #category : #initialization }
LeSlide >> initialize [
	super initialize.
	code := ''.
	self updateCoderUIModel.
	shouldPerformActionEveryTime := true.
	cachedElement := LeSlideElement new
		withGlamorousPreview;
		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ];
		slide: self;
		yourself.
	previewElement := BlLazyElement new
		withGlamorousPreview;
		neverUpdate; "I will be updated by the cached element"
		constraintsDo: [ :c | c vertical exact: 100. c horizontal exact: 150 ];
		background: Color white;
		viewModel: (BrInteractiveModel new
			withHover;
			yourself);
		margin: (BlInsets all: 10);
		yourself.
	self isSlideSelected: false.
	self updatePreviewElementAptitude.
]

{ #category : #accessing }
LeSlide >> isSlideSelected [
	^ isSlideSelected.
]

{ #category : #accessing }
LeSlide >> isSlideSelected: aBoolean [
	isSlideSelected := aBoolean.
]

{ #category : #'export - json' }
LeSlide >> jsonV1StringContent [
	"Answer the receiver in Roam export format.
	Code snippets are converted to fenced code blocks with smalltalk language."
	
	^ String streamContents: [ :stream |
		stream 
			<< '```smalltalk'; cr;
			<< code; cr;
			<< '```' ]
]

{ #category : #'lepiter-store' }
LeSlide >> leJsonV3Name [
	^ 'slide'
]

{ #category : #testing }
LeSlide >> needsUpdate [ 
	^ cachedElement needsUpdate
]

{ #category : #'private - event handling' }
LeSlide >> onAddedToSceneGraphAction [
	^ onAddedToSceneGraphAction ifNil: [^[:anElement | ]].
]

{ #category : #'private - event handling' }
LeSlide >> onEveryAddToSceneGraphDo: aBlock [
	shouldPerformActionEveryTime := true.
	onAddedToSceneGraphAction := aBlock.
]

{ #category : #'private - event handling' }
LeSlide >> onFirstAddToSceneGraphDo: aBlock [
	shouldPerformActionEveryTime := false.
	onAddedToSceneGraphAction := aBlock.
]

{ #category : #'private - event handling' }
LeSlide >> performActionOn: element [
	self onAddedToSceneGraphAction cull: element.
]

{ #category : #accessing }
LeSlide >> previewElement [
	previewElement hasChildren ifFalse: [ previewElement schedulePreview ].
	^ previewElement
]

{ #category : #accessing }
LeSlide >> previewElement: anObject [
	previewElement := anObject
]

{ #category : #'async processing' }
LeSlide >> queueAsyncUpdate: aSpace [
	"Submit a task to cache the receiver's elements"
	| aCommand aTelemetry |
	
	aTelemetry := aSpace
		ifNil: [ BlNullTelemetry uniqueInstance ]
		ifNotNil: [ aSpace telemetry ].
	
	cachedElement needsUpdate
		ifFalse: [ ^ self ].

	aCommand := GtSlideCommand new slide: self.

	BlUseAsyncFeatures
		ifEnabledDo: [
			aTelemetry
				timeSync: [ 'Schedule slide {1} update command in UI pool' format: { self class name } ]
				during: [ aCommand asBlTktLoggingCommand scheduleInUIPool ]  ] 
		otherwise: [
			aTelemetry
				timeSync: [ 'Execute slide {1} update command directly' format: { self class name } ]
				during: [ aCommand execute ] ]
]

{ #category : #private }
LeSlide >> runSnippetCode [
	| result |
	(self code isEmpty)
		ifTrue: [result := BlElement new]
		ifFalse: [
			[[ result := self coder doItAll value]
			on: Error
				do: [ :anException | result := anException asDebuggableElement ]]
			on: GtCoderEvaluationUnhandledError
				do: [ :anException | result := anException exception asDebuggableElement]].
	^ result.
]

{ #category : #accessing }
LeSlide >> shouldPerformActionEveryTime [
	^ shouldPerformActionEveryTime.
]

{ #category : #accessing }
LeSlide >> slideIndex [
	^ slideIndex
]

{ #category : #accessing }
LeSlide >> slideIndex: anObject [
	slideIndex := anObject
]

{ #category : #accessing }
LeSlide >> slideShow [
	^ slideShow
]

{ #category : #accessing }
LeSlide >> slideShow: anObject [
	slideShow := anObject
]

{ #category : #updating }
LeSlide >> updateCoderUIModel [
	| aSnippetCoder |
	
	aSnippetCoder := GtPharoSnippetCoder new.
	aSnippetCoder sourceCodeSynchronously: (GtCoderExplicitSourceCode new source: self code).
	aSnippetCoder completionStrategy: GtSnippetCompletionStrategy new.
	"self initializeCoderAddOns: aSnippetCoder."

	coderUIModel := aSnippetCoder asCoderUIModel.
]

{ #category : #'api - updating' }
LeSlide >> updateElements [
	| element formElement |
	element := self runSnippetCode.
	formElement := element asSpartaForm asElement asPannableElement.
	cachedElement
		removeChildren;
		slideElement: element.
	previewElement
		removeChildren;
		addChild: formElement.
]

{ #category : #updating }
LeSlide >> updatePreviewElementAptitude [
	isSlideSelected
		ifTrue: [
			previewElement
				aptitude: (BrShadowAptitude new color: (Color r: 0.27 g: 0.67 b: 0.99 alpha: 0.7)) + (BrInteractiveCommonAptitude new 
					default: [ :aWidget |
						aWidget
							border: (BlBorder paint: Color transparent)];
					hovered: [ :aWidget |
						aWidget 
							border: (BlBorder paint: (Color r: 0.27 g: 0.67 b: 0.99) width: 1)])]
		ifFalse: [
			previewElement
				aptitude: (BrShadowAptitude new) + (BrInteractiveCommonAptitude new 
					default: [ :aWidget |
						aWidget
							border: (BlBorder paint: Color transparent)];
					hovered: [ :aWidget |
						aWidget 
							border: (BlBorder paint: (Color r: 0.27 g: 0.67 b: 0.99) width: 1)])].
]
