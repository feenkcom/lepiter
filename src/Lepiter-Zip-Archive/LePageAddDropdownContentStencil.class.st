Class {
	#name : #LePageAddDropdownContentStencil,
	#superclass : #BrStencil,
	#instVars : [
		'anchor',
		'icon',
		'label',
		'action',
		'page'
	],
	#category : #'Lepiter-Zip-Archive-Support - Page Toolbar'
}

{ #category : #accessing }
LePageAddDropdownContentStencil >> action [
	^ action
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> action: anObject [
	action := anObject
]

{ #category : #actions }
LePageAddDropdownContentStencil >> addPage [
	^ LePageZipArchiveImporter
		importPage: self page 
		inDatabase: LeDatabasesRegistry new defaultLogicalDatabase primaryDB
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> anchor [
	^ anchor
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> anchor: anObject [
	anchor := anObject
]

{ #category : #'api - instantiation' }
LePageAddDropdownContentStencil >> create [
	^ BrVerticalPane new
		hFitContent;
		alignCenterLeft;
		vFitContent;
		addChild: self newDescriptionElement;
		addChild: self newConfirmationButton.
]

{ #category : #private }
LePageAddDropdownContentStencil >> hideDropdown [
	self anchor ifNotNil: [ :theAnchor | 
		theAnchor dispatchEvent: (BrDropdownHideWish new anchor: theAnchor) ]
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> icon [
	^ icon
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> icon: anObject [
	icon := anObject
]

{ #category : #initalization }
LePageAddDropdownContentStencil >> initialize [
	super initialize.
	action := [ :aConfirmationButton |
		"the confirmationButton is already hidden at this point"
		self anchor phlow spawnObject: self addPage ].
	icon := BrGlamorousVectorIcons add.
	label := 'Add page'.
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> label [
	^ label
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> label: anObject [
	label := anObject
]

{ #category : #private }
LePageAddDropdownContentStencil >> newConfirmationButton [
	^ BrButton new
		icon: self icon;
		beSmallSize;
		requestFocus;
		aptitude: BrGlamorousButtonWithIconAptitude new;
		label: self label;
		margin:
			(BlInsets
				top: 0
				left: 10
				bottom: 10
				right: 0);
		action: [ :theButton | 
			self hideDropdown.
			self action cull: theButton ]
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> newDescriptionElement [
	| aDescription |
	aDescription := 'Add/import/copy independent page "<1s>" into default primary database?' expandMacrosWith: self page title.
	^ BrLabel new
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		text: aDescription
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> page [
	^ page
]

{ #category : #accessing }
LePageAddDropdownContentStencil >> page: anObject [
	page := anObject
]
