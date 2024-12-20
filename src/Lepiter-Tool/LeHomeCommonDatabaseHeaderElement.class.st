Class {
	#name : #LeHomeCommonDatabaseHeaderElement,
	#superclass : #LeHomeBasicElement,
	#instVars : [
		'toolbarElement'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #initialization }
LeHomeCommonDatabaseHeaderElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
LeHomeCommonDatabaseHeaderElement >> initialize [
	super initialize.
	self initializeToolbarElement.
]

{ #category : #initialization }
LeHomeCommonDatabaseHeaderElement >> initializeToolbarElement [
	toolbarElement := BrToolbar new 
		aptitude: (BrGlamorousToolbarAptitude new spacing: 0).
]

{ #category : #'private - testing' }
LeHomeCommonDatabaseHeaderElement >> isForDatabaseWithName [
	^ self database isLogicalDatabase not
]

{ #category : #'private - instance creation' }
LeHomeCommonDatabaseHeaderElement >> newAddNewPageButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		beTinySize;
		label: 'Add new page';
		icon: BrGlamorousVectorIcons add;
		action: [ :aButton | self onAddNewPageFrom: aButton ];
		margin: (BlInsets left: 10)
]

{ #category : #'private - event handling' }
LeHomeCommonDatabaseHeaderElement >> onAddNewPageFrom: aButton [
	| aNewPage |
	aNewPage := self database pageBuilder
			uniqueTitle;
			add.
	BlSpace new
		title: aNewPage tabLabel;
		icon: LeIcons lepiterPage;
		inPager: [ aNewPage asLepiterPagePhlowTool asElementDo: [ :e | e ] ] asStencil;
		withSceneDriller;
		showFrom: aButton
]

{ #category : #'private - accessing' }
LeHomeCommonDatabaseHeaderElement >> toolbarElement [
	<return: #BrToolbar>
	^ toolbarElement
]
