"
I display a {{gtClass:LePage}} title:

{{gtExample:LePageCardElementExamples>>#pageCardElement|previewExpanded}}


"
Class {
	#name : #LePageCardElement,
	#superclass : #BlElement,
	#traits : 'TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'headerElement',
		'containerElement',
		'previewElement'
	],
	#category : #'Lepiter-UI-Page-! Views'
}

{ #category : #'private - accessing' }
LePageCardElement >> containerElement [
	<return: #BrButton>
	^ containerElement
]

{ #category : #'private - accessing' }
LePageCardElement >> headerElement [
	<return: #BrLabel>
	^ headerElement
]

{ #category : #initialization }
LePageCardElement >> initialize [
	super initialize.
	self initializeContainerElement.
	self initializePreviewElement.
	self layout: BlLinearLayout vertical.

	self containerElement addChild: self previewElement as: #preview.
	
	self addChild: self containerElement as: #card.
	self addAptitude: (BrLayoutResizerAptitude new
		inherit: self containerElement;
		inherit: self previewElement)
]

{ #category : #initialization }
LePageCardElement >> initializeContainerElement [
	containerElement := BrButton new
			layout: BlLinearLayout vertical;
			aptitude: BrGlamorousButtonExteriorAptitude new
					+ BrGlamorousButtonWithLabelTooltipAptitude2 new;
			padding: (BlInsets all: 1);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			action: [ self phlow spawnTool: self pageViewModel asPhlowTool ]
]

{ #category : #initialization }
LePageCardElement >> initializePreviewElement [
	previewElement := BrVerticalPane new
		beInSingleCompositionLayer;
		padding: (BlInsets all: 5);
		preventMeAndChildrenMouseEvents
]

{ #category : #'api - page view model' }
LePageCardElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	| summaryElement titleElement summaryText |

	self updateCard.

	titleElement := (BrEditor new
		aptitude: (BrGlamorousEditorAptitude new glamorousRegularFont bold fontSize: 16);
		text: self pageViewModel pageTitle;
		hMatchParent;
		vFitContent).
	
	summaryText := (String
		streamContents: [ :aStream |
			"self page allChildrenDepthFirstDo: [ :eachChild | aStream nextPutAll: eachChild content ]" ]
		limitedTo: 300) asRopedText.
	
	summaryElement := (BrEditor new
		aptitude: (BrGlamorousEditorAptitude new glamorousRegularFont);
		text: summaryText;
		"styler: LeBlockStyler new;"
		matchParent).
	
	self previewElement removeChildren.
	self previewElement
		addChild: titleElement;
		addChild: summaryElement;
		addChild: (BrLabel new
			padding: (BlInsets left: 2 right: 2);
			aptitude: (BrGlamorousLabelAptitude new fontSize: 10; foreground: Color gray);
			text: ('{1}' format: { self pageViewModel pageEditOrCreateEmail ifNil: [ '' ] }));
		addChild: (BrLabel new
			padding: (BlInsets left: 2 right: 2);
			aptitude: (BrGlamorousLabelAptitude new fontSize: 10; foreground: Color gray);
			text: ('{1}' format: { self pageViewModel pageLatestEditTime ifNil: [ '' ] ifNotNil: [ :aLeTime | aLeTime asDate asString ] })).
]

{ #category : #'private - accessing' }
LePageCardElement >> previewElement [
	<return: #LePageToolContentTreeElement>
	^ previewElement
]

{ #category : #'private - accessing' }
LePageCardElement >> spaceGap [
	^ 10
]

{ #category : #'private - updating' }
LePageCardElement >> updateCard [
	self containerElement label: self pageViewModel pageTitle
]
