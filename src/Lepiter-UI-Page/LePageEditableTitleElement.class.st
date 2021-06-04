"
I display a {{gtClass:LePage}} title:

{{gtExample:LeUIExamples>>#pageEditableTitleElement_TitledPage|previewExpanded}}


"
Class {
	#name : #LePageEditableTitleElement,
	#superclass : #BlElement,
	#traits : 'TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'titleElement'
	],
	#category : #'Lepiter-UI-Page-! Views'
}

{ #category : #initialization }
LePageEditableTitleElement >> createTitleElement [
	^ BrEditableLabel new
		aptitude: (BrGlamorousEditableLabelAptitude new
			defaultBackground: Color transparent; 
			glamorousRegularFont);
		margin: (BlInsets top: 5 left: 0 bottom: 5 right: 0);
		padding: (BlInsets top: 5 left: 10 bottom: 5 right: 15);
		hFitContentLimited;
		vFitContent;
		when: BrEditorAcceptWish do: [ :aWish | 
			self onAcceptTitleWish: aWish ]
]

{ #category : #initialization }
LePageEditableTitleElement >> initialize [
	super initialize.

	self layout: BlLinearLayout horizontal.
	
	"we can not add elements without widget models to toolbar. To be fixed"
	self addViewModel: BrWidgetModel new.

	self 
		hFitContentLimited;
		vFitContent.

	titleElement := self createTitleElement.
	self addChild: titleElement as: #title.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hFitContentLimitedToFitContentLimited: self titleElement;
		vAnyToFitContent: self titleElement).
]

{ #category : #'private - event handling' }
LePageEditableTitleElement >> onAcceptTitleWish: aWish [
	"Is sent by the editable title when users `accept` a new page title"

	self pageViewModel pageTitle: aWish text asString.
	self updatePageTitle
]

{ #category : #'private - event handling' }
LePageEditableTitleElement >> onPageTitleChanged [
	self titleElement enqueueTask: (BlTaskAction new action: [ self updatePageTitle ])
]

{ #category : #'api - page view model' }
LePageEditableTitleElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	
	self updatePageTitle
]

{ #category : #'api - page view model' }
LePageEditableTitleElement >> subscribeToPageViewModel [
	"Is sent after a new page view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPageViewModel if elements subscribe to them"
	
	self pageViewModel weak when: LePageViewModelTitleChanged send: #onPageTitleChanged to: self
]

{ #category : #'private - accessing' }
LePageEditableTitleElement >> titleElement [
	^ titleElement
]

{ #category : #'api - page view model' }
LePageEditableTitleElement >> unsubscribeFromPageViewModel [
	"Is sent before a new page view model is assigned to the element.
	Elements that subscribe to page view model in domain model are required to implement this methods"
	
	self pageViewModel unsubscribe: self
]

{ #category : #'private - updating' }
LePageEditableTitleElement >> updatePageTitle [
	| page |
	"I must be called from a UI process."
	
	page := self pageViewModel pageModel.
	page isUnnamedPage 
		ifTrue: [ 
			self titleElement aptitude
				defaultForeground: Color lightGray;
				fontSize: 14 ]
		ifFalse: [ 
			self titleElement aptitude
				defaultForeground: Color black;
				fontSize: 25; 
				bold ].
	
	self titleElement text: self pageViewModel pageTitle.
]
