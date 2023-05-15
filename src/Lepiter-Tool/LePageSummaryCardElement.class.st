"
I display a {{gtClass:LePage}} title


"
Class {
	#name : #LePageSummaryCardElement,
	#superclass : #BlElement,
	#traits : 'TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'titleElement',
		'summaryElement',
		'buttonModel',
		'emailElement',
		'dateElement'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #'api - accessing' }
LePageSummaryCardElement >> action [
	^ self buttonModel action
]

{ #category : #'api - accessing' }
LePageSummaryCardElement >> action: aValuable [
	"An action can be a block with two optional parameters:
	 - a UI element to which this button model is attached
	 - this button model
	[ :aButtonElement :aButtonModel :anEvent |  ].

	Button action must not be nil"

	self buttonModel action: aValuable
]

{ #category : #'private - accessing' }
LePageSummaryCardElement >> buttonModel [
	<return: #BrButtonModel>
	^ buttonModel
]

{ #category : #'private - accessing' }
LePageSummaryCardElement >> dateElement [
	<return: #BrLabel>
	^ dateElement
]

{ #category : #'private - accessing' }
LePageSummaryCardElement >> emailElement [
	<return: #BrLabel>

	^ emailElement
]

{ #category : #initialization }
LePageSummaryCardElement >> initialize [
	super initialize.
	
	self layout: BlLinearLayout vertical.
	
	self addViewModel: (buttonModel := BrButtonModel new).

	self initializeTitleElement.
	self initializeSummaryElement.
	self initializeEmailElement.
	self initializeDateElement.
	
	self addChild: self titleElement as: #title.
	self addChild: self summaryElement as: #summary.
	"self addChild: self emailElement as: #email.
	self addChild: self dateElement as: #date."
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit: self titleElement;
		vAnyToFitContent: self titleElement;
		inherit: self summaryElement";
		hInherit: self emailElement;
		vAnyToFitContent: self emailElement;
		hInherit: self dateElement;
		vAnyToFitContent: self dateElement").
	
	self exact: 150@200.
	self addAptitude: BrGlamorousButtonExteriorAptitude + (BrShadowAptitude new beLarge).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	self padding: (BlInsets all: 7).
	self preventChildrenMouseEvents.
]

{ #category : #initialization }
LePageSummaryCardElement >> initializeDateElement [
	dateElement := BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		text: ''
]

{ #category : #initialization }
LePageSummaryCardElement >> initializeEmailElement [
	emailElement := BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		text: ''
]

{ #category : #initialization }
LePageSummaryCardElement >> initializeSummaryElement [
	summaryElement := BrEditor new
		aptitude: (BrGlamorousEditorAptitude new 
			glamorousRegularFont; 
			fontSize: 9);
		matchParent;
		beReadOnlyWithoutSelection
]

{ #category : #initialization }
LePageSummaryCardElement >> initializeTitleElement [
	titleElement := BrEditor new
		aptitude: (BrGlamorousEditorAptitude new 
			glamorousRegularFont;
			bold;
			fontSize: 12);
		hMatchParent;
		vFitContent;
		beReadOnlyWithoutSelection.
]

{ #category : #'private - announcement handling' }
LePageSummaryCardElement >> onPageTitleChanged [
	self titleElement enqueueTask: (BlTaskAction new action: [ self updatePageTitleElement ])
]

{ #category : #'api - page view model' }
LePageSummaryCardElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	
	self updatePageTitleElement.
	self updatePageSummaryElement.
"	self updatePageEmailElement.
	self updatePageDateElement"
]

{ #category : #'api - page view model' }
LePageSummaryCardElement >> subscribeToPageViewModel [
	"Is sent after a new page view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPageViewModel if elements subscribe to them"
	
	self pageViewModel weak when: LePageViewModelTitleChanged send: #onPageTitleChanged to: self
]

{ #category : #'private - accessing' }
LePageSummaryCardElement >> summaryElement [
	<return: #BrEditor>
	^ summaryElement
]

{ #category : #'private - accessing' }
LePageSummaryCardElement >> titleElement [
	<return: #BrEditor>

	^ titleElement
]

{ #category : #'api - page view model' }
LePageSummaryCardElement >> unsubscribeFromPageViewModel [
	"Is sent before a new page view model is assigned to the element.
	Elements that subscribe to page view model in domain model are required to implement this methods"
	
	self pageViewModel unsubscribe: self
]

{ #category : #'private - updating' }
LePageSummaryCardElement >> updatePageDateElement [
	self dateElement text: self pageViewModel printPageLatestEditTime
]

{ #category : #'private - updating' }
LePageSummaryCardElement >> updatePageEmailElement [
	self emailElement text: self pageViewModel printPageEditOrCreateEmail
]

{ #category : #'private - updating' }
LePageSummaryCardElement >> updatePageSummaryElement [
	self summaryElement text: self pageViewModel printPageSummary
]

{ #category : #'private - updating' }
LePageSummaryCardElement >> updatePageTitleElement [
	self titleElement text: self pageViewModel pageTitle
]
