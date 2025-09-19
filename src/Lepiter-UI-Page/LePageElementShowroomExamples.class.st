Class {
	#name : #LePageElementShowroomExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Page-Examples'
}

{ #category : #'examples - showroom' }
LePageElementShowroomExamples >> allElements [
	<gtExample>
	<return: #BlScrollableElement>
	^ (BrHorizontalFlow new
		hMatchParent;
		vFitContent;
		addChildren: {self
					createExampleCard: self pageTitleAndEditInfoElement fitContent
					named: 'Title and edit info'
					class: LePageTitleAndSummaryElement.
				self
					createExampleCard: self pageEditableTitleElement
					named: 'Editable title'
					class: LePageEditableTitleElement.
				self
					createExampleCard: (self pageCardElement exact: 150 @ 200)
					named: 'Page card'
					class: LePageCardElement}) asScrollableElement
]

{ #category : #private }
LePageElementShowroomExamples >> createExampleCard: anExampleElement named: anExampleName class: anElementClass [
	^ BrVerticalPane new
		fitContent;
		cellSpacing: 7;
		padding: (BlInsets left: 10 right: 10);
		addChildren: {
			BrButton new
				aptitude: BrGlamorousLinkButtonWithLabelAptitude ;
				label: anExampleName;
				action: [ :aButton | aButton phlow spawnTool: (GtClassCoderTool forClass: anElementClass) ].
			BrVerticalPane new
				fitContent;
				addAptitude: BrShadowAptitude;
				background: Color white;
				padding: (BlInsets all: 5);
				addChild: anExampleElement }
]

{ #category : #'instance creation' }
LePageElementShowroomExamples >> createTime [
	^ LeTime new time: (DateAndTime year: 2021 month: 3 day: 1 hour: 8 minute: 10 second: 54)
]

{ #category : #'instance creation' }
LePageElementShowroomExamples >> editTime [
	^ LeTime new time: (DateAndTime year: 2021 month: 3 day: 4 hour: 16 minute: 18 second: 31)
]

{ #category : #'examples - showroom' }
LePageElementShowroomExamples >> pageCardElement [
	<gtExample>
	<return: #LePageCardElement>
	| aPageCardElement |
	aPageCardElement := LePageCardElement new
			pageViewModel: self pageWithTitleViewModel.

	^ aPageCardElement
]

{ #category : #'examples - showroom' }
LePageElementShowroomExamples >> pageEditableTitleElement [
	<gtExample>
	<return: #LePageEditableTitleElement>
	| anEditableTitleElement |
	anEditableTitleElement := LePageEditableTitleElement new
			pageViewModel: self pageWithTitleViewModel.

	^ anEditableTitleElement
]

{ #category : #'examples - showroom' }
LePageElementShowroomExamples >> pageTitleAndEditInfoElement [
	<gtExample>
	<return: #LePageTitleAndSummaryElement>
	| aTitleAndEditInfoElement |
	aTitleAndEditInfoElement := LePageTitleAndSummaryElement new
			pageViewModel: self pageWithTitleViewModel.

	^ aTitleAndEditInfoElement
]

{ #category : #'instance creation' }
LePageElementShowroomExamples >> pageWithTitle [
	<gtExample>
	<return: #LePage>
	| aPage |
	aPage := LePage named: 'Page with a title'.
	aPage
		createTime: self createTime;
		editTime: self editTime;
		createEmail: (LeEmail address: 'bob@example.com');
		editEmail: (LeEmail address: 'alice@example.com').

	^ aPage
]

{ #category : #'instance creation' }
LePageElementShowroomExamples >> pageWithTitleViewModel [
	<gtExample>
	<return: #LePageViewModel>
	| aPage aPageViewModel |
	aPage := self pageWithTitle.
	aPageViewModel := aPage asContentUIModel.
	^ aPageViewModel
]
