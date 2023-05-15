Class {
	#name : #LeIncomingPageLinkCardElement,
	#superclass : #BlElement,
	#traits : 'TLeWithIncomingPageLinkCardViewModel + TLeSnippetElement + TBrLayoutResizable',
	#classTraits : 'TLeWithIncomingPageLinkCardViewModel classTrait + TLeSnippetElement classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'previewContainer'
	],
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #'api - accessing' }
LeIncomingPageLinkCardElement >> action [
	^ self viewModel action
]

{ #category : #'api - accessing' }
LeIncomingPageLinkCardElement >> action: aValuable [
	"An action can be a block with two optional parameters:
	 - a UI element to which this button model is attached
	 - this button model
	[ :aButtonElement :aButtonModel :anEvent |  ].

	Button action must not be nil"

	self viewModel action: aValuable
]

{ #category : #initialization }
LeIncomingPageLinkCardElement >> createPreviewContainer [
	^ BlZoomableElement new zoomLevel: 0.75
]

{ #category : #initialization }
LeIncomingPageLinkCardElement >> initialize [
	super initialize.
	
	self
		layout: BlLinearLayout vertical;
		hMatchParent;
		vFitContent;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		padding: (BlInsets all: 7);
		background: Color white;
		preventChildrenMouseEvents.
	
	previewContainer := self createPreviewContainer.
	self addChild: previewContainer.
	
	self addViewModel: BrButtonModel new.

	self addAptitude: (BrLazyStyleCommonAptitude new
		default: [ :s | s border: BlBorder empty ];
		hovered: [ :s | s border: (BlBorder paint: BrGlamorousColors hoveredButtonBorderColor width: 1) ]).
	self addAptitude: BrShadowAptitude new.
	
	self addAptitude: (BrLayoutResizerAptitude new
		inherit: [ previewContainer ])
]

{ #category : #'api - incoming page link card view model' }
LeIncomingPageLinkCardElement >> onIncomingPageLinkCardViewModelChanged [
	"Is sent when a new incomingPageLinkCard view model is assigned to the element"
	
	previewContainer removeChildren.
	previewContainer addChild: self incomingPageLinkCardViewModel asIncomingLinkPreviewElement
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinkCardElement >> snippetViewModel [
	"Return a not-null Snippet view model assigned to the receiver element"

	^ self incomingPageLinkCardViewModel
]

{ #category : #'api - snippet view model' }
LeIncomingPageLinkCardElement >> snippetViewModel: aSnippetViewModel [
	"Set a not-null Snippet view model assigned to the receiver element"
	
	self incomingPageLinkCardViewModel: aSnippetViewModel
]
