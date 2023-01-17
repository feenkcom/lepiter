"
I display a {{gtClass:BrToolbar}} that I extend with {{gtMethod:LeToolbarElement>>#addFixedSeparator|label=fixed}} separators: {{gtExample:LeUIExamples>>#toolbarWithTwoButtonsAndFixedSeparator|previewExpanded|previewHeight=150}}


"
Class {
	#name : #LeToolbarElement,
	#superclass : #LeElement,
	#instVars : [
		'toolbarElement'
	],
	#category : #'Lepiter-UI-! Content Elements'
}

{ #category : #'api - adding / removing' }
LeToolbarElement >> addFixedSeparator [
	self addItem: self newFixedSeparator
]

{ #category : #'api - adding / removing' }
LeToolbarElement >> addItem: anElement [
	self toolbarElement addItem: anElement
]

{ #category : #'api - adding / removing' }
LeToolbarElement >> addItems: aCollection [
	self toolbarElement addItem: aCollection
]

{ #category : #initialization }
LeToolbarElement >> initialize [
	super initialize.
	self initializeToolbarElement.
	self layout: BlFrameLayout new.
	
	self addChild: self toolbarElement as: #toolbar.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self toolbarElement;
		vAnyToFitContent: self toolbarElement).
]

{ #category : #initialization }
LeToolbarElement >> initializeToolbarElement [
	toolbarElement := BrToolbar new
		aptitude: BrGlamorousToolbarAptitude new;
		alignCenterLeft;
		fitContent.
]

{ #category : #'private - instance creation' }
LeToolbarElement >> newFixedSeparator [
	^ BrLabel new
		aptitude: BrLabelAptitude;
		text: '';
		hExact: 21;
		vFitContent
]

{ #category : #'api - adding / removing' }
LeToolbarElement >> removeAllItems [
	self toolbarElement numberOfItems timesRepeat: [ 
		self toolbarElement removeItemAt: 1 ]
]

{ #category : #'private - accessing' }
LeToolbarElement >> toolbarElement [
	<return: #BrToolbar>
	^ toolbarElement
]
