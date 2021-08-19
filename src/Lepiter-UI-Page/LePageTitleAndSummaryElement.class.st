"
I display a {{gtClass:LePage}} title, edit date and edit email:

{{gtExample:LeUIExamples>>#pageTitleAndEditInfoElement|previewExpanded}}


"
Class {
	#name : 'LePageTitleAndSummaryElement',
	#superclass : 'BlElement',
	#traits : 'TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'titleElement',
		'dateElement',
		'emailElement',
		'dateAndEmailElement',
		'summaryElement'
	],
	#category : 'Lepiter-UI-Page-! Views'
}

{ #category : 'accessing' }
LePageTitleAndSummaryElement >> contentViewModel: aPageViewModel [
	self pageViewModel: aPageViewModel
]

{ #category : 'private - accessing' }
LePageTitleAndSummaryElement >> dateAndEmailElement [
	^ dateAndEmailElement
]

{ #category : 'private - accessing' }
LePageTitleAndSummaryElement >> dateElement [
	^ dateElement
]

{ #category : 'private - accessing' }
LePageTitleAndSummaryElement >> emailElement [
	^ emailElement
]

{ #category : 'initialization' }
LePageTitleAndSummaryElement >> initialize [
	super initialize.
	self initializeTitleElement.
"	self initializeDateAndEmailElement.
	self initializeDateElement.
	self initializeEmailElement."
	self layout: BlLinearLayout horizontal.
	
	self addChild: self titleElement as: #title.
	self addChild: self summaryElement as: #summary.
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

{ #category : 'initialization' }
LePageTitleAndSummaryElement >> initializeDateAndEmailElement [
	dateAndEmailElement := BrHorizontalPane new
		hMatchParent;
		vFitContent
]

{ #category : 'initialization' }
LePageTitleAndSummaryElement >> initializeDateElement [
	dateElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont; foreground: Color gray);
		hMatchParent;
		vFitContent
]

{ #category : 'initialization' }
LePageTitleAndSummaryElement >> initializeEmailElement [
	emailElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont; foreground: Color gray);
		hMatchParent;
		vFitContent
]

{ #category : 'initialization' }
LePageTitleAndSummaryElement >> initializeSummaryElement [
	summaryElement := BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: self theme header disabledTextColor);
		margin: (BlInsets left: 10);
		hMatchParent;
		vFitContent
]

{ #category : 'initialization' }
LePageTitleAndSummaryElement >> initializeTitleElement [
	titleElement := BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new);
		hFitContent;
		vFitContent
]

{ #category : 'private - event handling' }
LePageTitleAndSummaryElement >> onPageTitleChanged [
	self titleElement enqueueTask: (BlTaskAction new action: [ 
		self updatePageInfo ])
]

{ #category : 'api - page view model' }
LePageTitleAndSummaryElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	
	self updatePageInfo
]

{ #category : 'api - page view model' }
LePageTitleAndSummaryElement >> subscribeToPageViewModel [
	"Is sent after a new page view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPageViewModel if elements subscribe to them"
	
	self pageViewModel weak 
		when: LePageViewModelTitleChanged send: #onPageTitleChanged to: self
]

{ #category : 'initialization' }
LePageTitleAndSummaryElement >> summaryElement [
	^ summaryElement
		ifNil: [ summaryElement := BrLabel new
				beSmallSize;
				aptitude:
					(BrGlamorousLabelAptitude new
						foreground: self theme header disabledTextColor);
				margin: (BlInsets left: 10);
				hMatchParent;
				vFitContent ]
]

{ #category : 'private - accessing' }
LePageTitleAndSummaryElement >> titleElement [
	^ titleElement
]

{ #category : 'api - page view model' }
LePageTitleAndSummaryElement >> unsubscribeFromPageViewModel [
	"Is sent before a new page view model is assigned to the element.
	Elements that subscribe to page view model in domain model are required to implement this methods"
	
	self pageViewModel unsubscribe: self
]

{ #category : 'private - updating' }
LePageTitleAndSummaryElement >> updatePageInfo [
	self titleElement text: self pageViewModel pageTitle.
	self summaryElement text: ((self pageViewModel printPageSummaryLimitedTo: 43) truncateWithElipsisTo: 40).
	"self emailElement text: self pageViewModel printPageEditOrCreateEmail.
	self dateElement text: self pageViewModel printPageLatestEditTime"
]
