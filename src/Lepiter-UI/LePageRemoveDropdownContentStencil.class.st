"
I build a dropdown that confirms a page removal.
I am used by the page remove action in {{gtMethod:LePage>>#gtRemoveActionFor:}}. 
## Example
{{gtExample:LeUIExamples>>#pageToolContentElement_TitleAndAllActionButtons|previewExpanded|codeExpanded=false}}

"
Class {
	#name : #LePageRemoveDropdownContentStencil,
	#superclass : #BrStencil,
	#instVars : [
		'anchor',
		'icon',
		'label',
		'action',
		'page'
	],
	#category : #'Lepiter-UI-Support - Page Toolbar'
}

{ #category : #accessing }
LePageRemoveDropdownContentStencil >> action [
	^ action
]

{ #category : #accessing }
LePageRemoveDropdownContentStencil >> action: anObject [
	action := anObject
]

{ #category : #accessing }
LePageRemoveDropdownContentStencil >> anchor [
	^ anchor
]

{ #category : #accessing }
LePageRemoveDropdownContentStencil >> anchor: anObject [
	anchor := anObject
]

{ #category : #'api - instantiation' }
LePageRemoveDropdownContentStencil >> create [
	^ BrVerticalPane new
		hFitContent;
		alignCenterLeft;
		vFitContent;
		addChild: self newDescriptionElement;
		addChild: self newConfirmationButton.
]

{ #category : #'private - actions' }
LePageRemoveDropdownContentStencil >> hideDropdown [
	self anchor ifNotNil: [ :theAnchor | 
		theAnchor dispatchEvent: (BrDropdownHideWish new anchor: theAnchor) ]
]

{ #category : #accessing }
LePageRemoveDropdownContentStencil >> icon [
	^ icon
]

{ #category : #accessing }
LePageRemoveDropdownContentStencil >> icon: anObject [
	icon := anObject
]

{ #category : #initialization }
LePageRemoveDropdownContentStencil >> initialize [
	super initialize.
	action := [ :aConfirmationButton | self removePage ].
	icon := BrGlamorousVectorIcons remove.
	label := 'Remove Page'.
]

{ #category : #accessing }
LePageRemoveDropdownContentStencil >> label [
	^ label
]

{ #category : #accessing }
LePageRemoveDropdownContentStencil >> label: anObject [
	label := anObject
]

{ #category : #'private - instance creation' }
LePageRemoveDropdownContentStencil >> newConfirmationButton [
	^ BrButton new
		id: LePageConfirmationActionId;
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
LePageRemoveDropdownContentStencil >> newDescriptionElement [
	^ self page hasIncomingLinks
		ifTrue: [ self newLinkedPageDescriptionElement ]
		ifFalse: [ self newNotLinkedPageDescriptionElement ]
]

{ #category : #'private - instance creation' }
LePageRemoveDropdownContentStencil >> newLinkedPageDescriptionElement [
	| aContainer |
	aContainer := BrHorizontalPane new
		margin: (BlInsets all: 10);
		alignCenterRight;
		fitContent.
	aContainer addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		margin: (BlInsets right: 5);
		text: self page title, ' ').
	aContainer addChild: (BrButton new
		aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new;
		label: 'is linked';
		action: [ :theButton | 
			self spawnPageLinksFrom: theButton ]).
	aContainer addChild: (BrLabel new
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		text: '. Remove anyway?').
	^ aContainer
]

{ #category : #'private - instance creation' }
LePageRemoveDropdownContentStencil >> newNotLinkedPageDescriptionElement [
	| aDescription |
	aDescription := 'Remove page <1s>?' expandMacrosWith: self page title.
	^ BrLabel new
		margin: (BlInsets all: 10);
		aptitude: BrGlamorousLabelAptitude new glamorousRegularFont;
		text: aDescription
]

{ #category : #'private - accessing' }
LePageRemoveDropdownContentStencil >> page [
	^ page
]

{ #category : #'private - building' }
LePageRemoveDropdownContentStencil >> page: aPage [
	page := aPage
]

{ #category : #'private - actions' }
LePageRemoveDropdownContentStencil >> removePage [
	page removeSelf
]

{ #category : #'private - actions' }
LePageRemoveDropdownContentStencil >> spawnPageLinksFrom: aButton [
	| theReferences aTool |
	theReferences := LeIncomingExplicitPageLinksGroup forPage: self page.
	aTool := theReferences asLepiterIncomingReferencesPhlowTool.
	self anchor ifNotNil: [ :theAnchor | theAnchor phlow spawnTool: aTool ]
]
