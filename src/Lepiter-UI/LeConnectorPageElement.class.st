Class {
	#name : #LeConnectorPageElement,
	#superclass : #BlElement,
	#traits : 'TGtPhlowToolDetailAdjustable + TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TGtPhlowToolDetailAdjustable classTrait + TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'contentElement'
	],
	#category : #'Lepiter-UI-Connector'
}

{ #category : #'private - event handling' }
LeConnectorPageElement >> actOnDetailedVolume [
]

{ #category : #'private - event handling' }
LeConnectorPageElement >> actOnNormalVolume [
]

{ #category : #accessing }
LeConnectorPageElement >> contentElement [
	^ contentElement
]

{ #category : #initialization }
LeConnectorPageElement >> initialize [
	super initialize.
	self layout: BlLinearLayout horizontal.
	
	self addAptitude: (GtPhlowToolDetailAptitude new
		normal: [ :aStyle | aStyle do: [ self actOnNormalVolume ] ];
		detailed: [ :aStyle | aStyle do: [ self actOnDetailedVolume ] ]).
		
	self initializeContentElement.
	self addChild: self contentElement as: #content.
]

{ #category : #initialization }
LeConnectorPageElement >> initializeContentElement [
	contentElement := LePageToolContentTreeElement new 
		withTitleAndButtons;
		beInSingleCompositionLayer;
		matchParent
]

{ #category : #'api - page view model' }
LeConnectorPageElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	
	self updateContent
]

{ #category : #updating }
LeConnectorPageElement >> updateContent [
	self contentElement pageViewModel: self pageViewModel
]
