Class {
	#name : #LeDailyNoteInfoElement,
	#superclass : #BlElement,
	#traits : 'TLeWithDailyNoteViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithDailyNoteViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'titleElement'
	],
	#category : 'Lepiter-UI-Page-! Views'
}

{ #category : #accessing }
LeDailyNoteInfoElement >> contentViewModel: aDailyNoteViewModel [
	self dailyNoteViewModel: aDailyNoteViewModel
]

{ #category : #initialization }
LeDailyNoteInfoElement >> initialize [
	super initialize.
	self initializeTitleElement.
	self layout: BlLinearLayout vertical.
	
	self addChild: self titleElement as: #title.
]

{ #category : #initialization }
LeDailyNoteInfoElement >> initializeTitleElement [
	titleElement := BrLabel new
		beSmallSize;
		aptitude: (BrGlamorousLabelAptitude new);
		hMatchParent;
		vFitContent
]

{ #category : #'api - daily note view model' }
LeDailyNoteInfoElement >> onDailyNoteViewModelChanged [
	"Is sent when a new daily note view model is assigned to the element"
	
	self updateDailyNoteInfo
]

{ #category : #accessing }
LeDailyNoteInfoElement >> titleElement [
	^ titleElement
]

{ #category : #updating }
LeDailyNoteInfoElement >> updateDailyNoteInfo [
	self titleElement 
		text: self dailyNoteViewModel dailyNoteModel date asString.
]
