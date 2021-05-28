Class {
	#name : #LeHomeRemoveDatabaseDropdownContentStencil,
	#superclass : #BrStencil,
	#instVars : [
		'anchor',
		'icon',
		'label',
		'action',
		'databaseElement'
	],
	#category : #'Lepiter-Tool-Stencils'
}

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> action [
	^ action
]

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> action: anObject [
	action := anObject
]

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> anchor [
	^ anchor
]

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> anchor: anObject [
	anchor := anObject
]

{ #category : #'api - instantiation' }
LeHomeRemoveDatabaseDropdownContentStencil >> create [
	^ BrVerticalPane new
		hFitContent;
		alignCenterLeft;
		vFitContent;
		addChild: self newDescriptionElement;
		addChild: self newConfirmationButton.
]

{ #category : #'private - accessing' }
LeHomeRemoveDatabaseDropdownContentStencil >> database [
	^ self databaseElement 
		ifNotNil: [ :anElement | anElement database ] 
		ifNil: [ LeDatabase null ]
]

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> databaseElement [
	^ databaseElement
]

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> databaseElement: anElement [
	databaseElement := anElement
]

{ #category : #'private - accessing' }
LeHomeRemoveDatabaseDropdownContentStencil >> databaseName [
	^ self databaseElement databaseName
]

{ #category : #'private - actions' }
LeHomeRemoveDatabaseDropdownContentStencil >> hideDropdown [
	self anchor ifNotNil: [ :theAnchor | 
		theAnchor dispatchEvent: (BrDropdownHideWish new anchor: theAnchor) ]
]

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> icon [
	^ icon
]

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> icon: anObject [
	icon := anObject
]

{ #category : #initialization }
LeHomeRemoveDatabaseDropdownContentStencil >> initialize [
	super initialize.
	action := [ :aConfirmationButton | self removeDatabase ].
	icon := BrGlamorousVectorIcons remove.
	label := 'Remove Database'.
]

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> label [
	^ label
]

{ #category : #accessing }
LeHomeRemoveDatabaseDropdownContentStencil >> label: anObject [
	label := anObject
]

{ #category : #'private - accessing' }
LeHomeRemoveDatabaseDropdownContentStencil >> localStoreRootDirectory [
	^ self database isDatabase 
		ifTrue: [ self database localStoreRootDirectory ]
		ifFalse: [ nil ]
]

{ #category : #'private - instance creation' }
LeHomeRemoveDatabaseDropdownContentStencil >> newConfirmationButton [
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

{ #category : #'private - instance creation' }
LeHomeRemoveDatabaseDropdownContentStencil >> newDescriptionElement [
	^ self localStoreRootDirectory
		ifNil: [ self newNoStorageDescriptionElement ]
		ifNotNil: [ self newStorageDescriptionElement ]
]

{ #category : #'private - instance creation' }
LeHomeRemoveDatabaseDropdownContentStencil >> newNoStorageDescriptionElement [
	| aDescription aFile |
	aDescription := 'Remove database <1s>?' expandMacrosWith: self databaseName.
	aFile := self localStoreRootDirectory.
	^ BrLabel new
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		text: aDescription
]

{ #category : #'private - instance creation' }
LeHomeRemoveDatabaseDropdownContentStencil >> newStorageDescriptionElement [
	| aQuestion aPageCount anExplanation |
	aQuestion := 'Remove database <1s>?' expandMacrosWith: self databaseName.
	aPageCount := self database pageCount.
	anExplanation := aPageCount isZero
		ifTrue: [ 'The database is empty.' ]
		ifFalse: [ 'The database has <1s> <2s>.' expandMacrosWith: aPageCount asString with: ('page' asPluralBasedOn: aPageCount) ].
	^ BrVerticalPane new
		fitContent;
		margin: (BlInsets all: 10);
		addChild: (BrLabel new
			margin: (BlInsets bottom: 3);
			aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
			text: aQuestion);
		addChild: (BrLabel new
			aptitude: (BrGlamorousLabelAptitude new glamorousRegularFont; foreground: BrGlamorousColors disabledButtonTextColor);
			text: anExplanation)
]

{ #category : #'private - actions' }
LeHomeRemoveDatabaseDropdownContentStencil >> removeDatabase [
	self databaseElement ifNotNil: [ :anElement | anElement removeDatabase ]
]
