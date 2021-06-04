"
I display a ${class:LePage}$ title, edit date and edit email:

${example:LeUIExamples>>#pageTitleAndEditInfoElement|previewExpanded}$

"
Class {
	#name : #LePageTitleAndEditInfoElement,
	#superclass : #BlElement,
	#traits : 'TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'titleElement',
		'dateElement',
		'emailElement',
		'dateAndEmailElement'
	],
	#category : #'Lepiter-UI-Page-! Views'
}

{ #category : #accessing }
LePageTitleAndEditInfoElement >> contentViewModel: aPageViewModel [
	self pageViewModel: aPageViewModel
]

{ #category : #'private - accessing' }
LePageTitleAndEditInfoElement >> dateAndEmailElement [
	^ dateAndEmailElement
]

{ #category : #'private - accessing' }
LePageTitleAndEditInfoElement >> dateElement [
	^ dateElement
]

{ #category : #'private - accessing' }
LePageTitleAndEditInfoElement >> emailElement [
	^ emailElement
]

{ #category : #initialization }
LePageTitleAndEditInfoElement >> initialize [
	super initialize.
	self initializeTitleElement.
"	self initializeDateAndEmailElement.
	self initializeDateElement.
	self initializeEmailElement."
	self layout: BlLinearLayout vertical.
	
	self addChild: self titleElement as: #title.
"	self addChild: self dateAndEmailElement as: #dateAndEmail.
	self dateAndEmailElement addChild: self dateElement as: #date.
	self dateAndEmailElement addChild: self emailElement as: #email.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent; 
		hInherit: self titleElement;
		vAnyToFitContent: self titleElement;
		hInherit: self dateAndEmailElement;
		vAnyToFitContent: self dateAndEmailElement;
		hInherit: self dateElement;
		vAnyToFitContent: self dateElement;
		hInherit: self emailElement;
		vAnyToFitContent: self emailElement)."

]

{ #category : #initialization }
LePageTitleAndEditInfoElement >> initializeDateAndEmailElement [
	dateAndEmailElement := BrHorizontalPane new
		hMatchParent;
		vFitContent
]

{ #category : #initialization }
LePageTitleAndEditInfoElement >> initializeDateElement [
	dateElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont; foreground: Color gray);
		hMatchParent;
		vFitContent
]

{ #category : #initialization }
LePageTitleAndEditInfoElement >> initializeEmailElement [
	emailElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont; foreground: Color gray);
		hMatchParent;
		vFitContent
]

{ #category : #initialization }
LePageTitleAndEditInfoElement >> initializeTitleElement [
	titleElement := BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new);
		hMatchParent;
		vFitContent
]

{ #category : #'private - event handling' }
LePageTitleAndEditInfoElement >> onPageTitleChanged [
	self titleElement enqueueTask: (BlTaskAction new action: [ 
		self updatePageInfo ])
]

{ #category : #'api - page view model' }
LePageTitleAndEditInfoElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	
	self updatePageInfo
]

{ #category : #'api - page view model' }
LePageTitleAndEditInfoElement >> subscribeToPageViewModel [
	"Is sent after a new page view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPageViewModel if elements subscribe to them"
	
	self pageViewModel weak 
		when: LePageViewModelTitleChanged send: #onPageTitleChanged to: self
]

{ #category : #'private - accessing' }
LePageTitleAndEditInfoElement >> titleElement [
	^ titleElement
]

{ #category : #'api - page view model' }
LePageTitleAndEditInfoElement >> unsubscribeFromPageViewModel [
	"Is sent before a new page view model is assigned to the element.
	Elements that subscribe to page view model in domain model are required to implement this methods"
	
	self pageViewModel unsubscribe: self
]

{ #category : #'private - updating' }
LePageTitleAndEditInfoElement >> updatePageInfo [
	self titleElement text: self pageViewModel pageTitle.
	"self emailElement text: self pageViewModel printPageEditOrCreateEmail.
	self dateElement text: self pageViewModel printPageLatestEditTime"
]
