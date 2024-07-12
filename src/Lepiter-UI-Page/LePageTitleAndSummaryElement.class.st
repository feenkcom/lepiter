"
I display a {{gtClass:LePage}} title, edit date and edit email:

{{gtExample:LeUIExamples>>#pageTitleAndEditInfoElement|previewExpanded}}


"
Class {
	#name : #LePageTitleAndSummaryElement,
	#superclass : #BlElement,
	#traits : 'TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'titleElement',
		'dateElement',
		'emailElement',
		'dateAndEmailElement',
		'summaryElement'
	],
	#category : #'Lepiter-UI-Page-! Views'
}

{ #category : #accessing }
LePageTitleAndSummaryElement >> contentViewModel: aPageViewModel [
	self pageViewModel: aPageViewModel
]

{ #category : #'private - accessing' }
LePageTitleAndSummaryElement >> dateAndEmailElement [
	^ dateAndEmailElement
]

{ #category : #'private - accessing' }
LePageTitleAndSummaryElement >> dateElement [
	^ dateElement
]

{ #category : #'private - accessing' }
LePageTitleAndSummaryElement >> emailElement [
	^ emailElement
]

{ #category : #initialization }
LePageTitleAndSummaryElement >> initialize [
	super initialize.
	self initializeTitleElement.
	self layout: BlLinearLayout horizontal.
	self addChild: self titleElement as: #title.
	self addChild: self summaryElement as: #summary.
	self initializeListeners
]

{ #category : #initialization }
LePageTitleAndSummaryElement >> initializeDateAndEmailElement [
	dateAndEmailElement := BrHorizontalPane new
		hMatchParent;
		vFitContent
]

{ #category : #initialization }
LePageTitleAndSummaryElement >> initializeDateElement [
	dateElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont; foreground: Color gray);
		hMatchParent;
		vFitContent
]

{ #category : #initialization }
LePageTitleAndSummaryElement >> initializeEmailElement [
	emailElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont; foreground: Color gray);
		hMatchParent;
		vFitContent
]

{ #category : #initialization }
LePageTitleAndSummaryElement >> initializeListeners [
	self
		when: BlClickEvent
		do: [ :anEvent | 
			anEvent modifiers isPrimaryModifier
				ifTrue: [ | aTool aSpace |
					aTool := self pageViewModel asPhlowTool.
					aSpace := BlSpace new.
					aSpace title: self gtDisplayString.
					aSpace icon: aTool icon.
					aSpace extent: 1200 @ 600.
					aSpace root background: Color transparent.
					aSpace
						addChild: (GtPager
								createOn: (GtPagerWrapperElement new
										tool: aTool;
										embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null))) maximized.
					aSpace withHalos.
					self showSpace: aSpace ] ].
	self
		when: BlMouseEnterEvent
		do: [ :anEvent | 
			anEvent consumed: true.
			anEvent modifiers isPrimaryModifier
				ifTrue: [ anEvent target mouseCursor: BlCopyCursor new ]
				ifFalse: [ anEvent target mouseCursor: nil ].
			anEvent target requestFocus ]
]

{ #category : #initialization }
LePageTitleAndSummaryElement >> initializeSummaryElement [
	summaryElement := BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new foreground: self theme header disabledTextColor);
		margin: (BlInsets left: 10);
		hMatchParent;
		vFitContent
]

{ #category : #initialization }
LePageTitleAndSummaryElement >> initializeTitleElement [
	titleElement := BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new);
		hFitContent;
		vFitContent
]

{ #category : #'private - event handling' }
LePageTitleAndSummaryElement >> onPageTitleChanged [
	self titleElement enqueueTask: (BlTaskAction new action: [ 
		self updatePageInfo ])
]

{ #category : #'api - page view model' }
LePageTitleAndSummaryElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	
	self updatePageInfo
]

{ #category : #'api - page view model' }
LePageTitleAndSummaryElement >> subscribeToPageViewModel [
	"Is sent after a new page view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPageViewModel if elements subscribe to them"
	
	self pageViewModel weak 
		when: LePageViewModelTitleChanged send: #onPageTitleChanged to: self
]

{ #category : #initialization }
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

{ #category : #'private - accessing' }
LePageTitleAndSummaryElement >> titleElement [
	^ titleElement
]

{ #category : #'api - page view model' }
LePageTitleAndSummaryElement >> unsubscribeFromPageViewModel [
	"Is sent before a new page view model is assigned to the element.
	Elements that subscribe to page view model in domain model are required to implement this methods"
	
	self pageViewModel unsubscribe: self
]

{ #category : #'private - updating' }
LePageTitleAndSummaryElement >> updatePageInfo [
	self titleElement text: self pageViewModel pageTitle.
	self summaryElement text: ((self pageViewModel printPageSummaryLimitedTo: 43) truncateWithElipsisTo: 40).
	"self emailElement text: self pageViewModel printPageEditOrCreateEmail.
	self dateElement text: self pageViewModel printPageLatestEditTime"
]
