"
I display a {{gtClass:LeDatabase}} header that includes a title and action buttons, e.g., Spotter.

{{gtExample:LeUIExamples>>#databaseHeaderElement|previewExpanded}}


"
Class {
	#name : #LeDatabaseHeaderElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'toolbarElement'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #'private - adding / removing' }
LeDatabaseHeaderElement >> addItem: anElement [
	self toolbarElement addItem: anElement
]

{ #category : #initialization }
LeDatabaseHeaderElement >> initialize [
	super initialize.
	self initializeToolbarElement.
	self initializeToolbarItems.
	self layout: BlLinearLayout horizontal.

	self addChild: self toolbarElement as: #toolbar.
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent; 
		hInherit: self toolbarElement;
		vAnyToFitContent: self toolbarElement).
]

{ #category : #initialization }
LeDatabaseHeaderElement >> initializeLabelToolbarItem [
	| aLabel |
	aLabel := BrLabel new 
		aptitude: BrGlamorousLabelAptitude;
		text: 'Lepiter Database';
		beHugeSize;
		hMatchParent;
		vFitContent. 
	self addItem: aLabel.
]

{ #category : #initialization }
LeDatabaseHeaderElement >> initializeSpotterToolbarItem [
	| aButton |
	aButton := GtSpotterDropdownButtonStencil new
			valuable: [ self database ];
			tooltip: 'Search Lepiter Database';
			objectActOn: [ :anActOnEvent :anItem :theButton | 
				anActOnEvent beActed.
				self selectAndScrollTo: anItem ];
			asElement.
	self addItem: aButton.
]

{ #category : #initialization }
LeDatabaseHeaderElement >> initializeToolbarElement [
	toolbarElement := BrToolbar new
		aptitude: BrGlamorousToolbarAptitude new;
		padding: (BlInsets top: 5 bottom: 5)
]

{ #category : #initialization }
LeDatabaseHeaderElement >> initializeToolbarItems [
	self initializeLabelToolbarItem.
	self initializeSpotterToolbarItem.
]

{ #category : #'private - accessing' }
LeDatabaseHeaderElement >> toolbarElement [
	<return: #BrToolbar>
	^ toolbarElement
]
