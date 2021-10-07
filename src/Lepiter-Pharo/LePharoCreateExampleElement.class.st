Class {
	#name : #LePharoCreateExampleElement,
	#superclass : #BlElement,
	#instVars : [
		'snippet',
		'className',
		'selectorName',
		'packageName',
		'saveButton',
		'packageEditor'
	],
	#category : #'Lepiter-Pharo-Snippet'
}

{ #category : #initialization }
LePharoCreateExampleElement >> buildElement [
	| classEditor |
	self
		layout: (BlGridLayout new columnCount: 2);
		constraintsDo:
				[ :c | 
					c horizontal fitContent.
					c vertical fitContent ];
		padding: (BlInsets all: 10).
	self addChild: (self createLabel: 'Class:').
	classEditor := self createEditableLabel: [ :aWish | self className: aWish text asString ].
	(GtCompletionController on: classEditor strategy: GtClassesCompletionStrategy new) install.
	self addChild: classEditor.
	self addChild: (self createLabel: 'Selector:').
	self addChild: (self createEditableLabel: [ :aWish | self selectorName: aWish text asString ]).
	self addChild: (self createLabel: 'Package:').
	packageEditor := self createEditableLabel: [ :aWish | self packageName: aWish text asString ].
	(GtCompletionController on: packageEditor strategy: GtPackagesCompletionStrategy new) install.
	self addChild: packageEditor.
	saveButton := (BrButton new)
		icon: BrGlamorousVectorIcons accept;
		beSmallSize;
		aptitude: BrGlamorousButtonWithIconAptitude new;
		label: 'Save';
		action: [ self convertToExample ];
		constraintsDo: [ :c | c grid horizontal span: 2 ].
	self addChild: saveButton.
	self validateCanSave
]

{ #category : #accessing }
LePharoCreateExampleElement >> className: aString [
	className := aString.
	self updatePackageName.
	self validateCanSave
]

{ #category : #private }
LePharoCreateExampleElement >> close [
	self fireEvent: BrDropdownHideWish new
]

{ #category : #private }
LePharoCreateExampleElement >> convertToExample [
	self createClass.
	self createExample.
	self close
]

{ #category : #private }
LePharoCreateExampleElement >> createClass [
	| change |
	self selectedClass notNil ifTrue: [ ^ self ].
	change := GtRBAddClassWithSlotsChange
		definition:
			'Object subclass: #' , className , '
				slots: {}
				classVariables: {}
				package: ''' , packageName , ''''.
	GtPharoCodeModifier current performRefactoryChange: change
]

{ #category : #initialization }
LePharoCreateExampleElement >> createEditableLabel: aBlock [
	^ (BrEditableLabel new)
		aptitude:
				((BrGlamorousEditableLabelAptitude new)
						glamorousCodeFont;
						defaultForeground: Color black;
						fontSize: 10);
		margin:
				(BlInsets
						top: 3
						left: 0
						bottom: 3
						right: 5);
		text: '';
		when: BrEditorAcceptWish do: aBlock
]

{ #category : #private }
LePharoCreateExampleElement >> createExample [
	| class |
	class := self selectedClass.
	snippet
		convertToExample: selectorName
		in: class
		classified: (class instanceSide package name = packageName ifTrue: [ #examples ] ifFalse: [ '*' , packageName ])
]

{ #category : #initialization }
LePharoCreateExampleElement >> createLabel: aString [
	^ (BrLabel new)
		aptitude:
				((BrGlamorousLabelAptitude new glamorousRegularFontAndSize)
						foreground: Color gray;
						fontSize: 12);
		text: aString;
		focusability: BlFocusability none;
		margin: (BlInsets top: 5 right: 2);
		constraintsDo: [ :c | c grid horizontal alignLeft ]
]

{ #category : #initialization }
LePharoCreateExampleElement >> initialize [
	super initialize.
	className := ''.
	selectorName := ''.
	packageName := ''.
	self buildElement
]

{ #category : #validating }
LePharoCreateExampleElement >> isValidClassName [
	| isMeta name |
	name := className.
	isMeta := name endsWith: ' class'.
	isMeta ifTrue: [ name := name allButLast: 6 ].
	^ (RBScanner isVariable: name) and: [ name first isUppercase ]
]

{ #category : #validating }
LePharoCreateExampleElement >> isValidPackage [
	^ packageName notEmpty
]

{ #category : #validating }
LePharoCreateExampleElement >> isValidSelector [
	^ (RBScanner isSelector: selectorName) and: [ selectorName asSymbol isUnary ]
]

{ #category : #accessing }
LePharoCreateExampleElement >> packageName: aString [
	packageName := aString.
	self validateCanSave
]

{ #category : #private }
LePharoCreateExampleElement >> selectedClass [
	| name isMeta |
	name := className.
	isMeta := name endsWith: ' class'.
	isMeta ifTrue: [ name := name allButLast: 6 ].
	^ Smalltalk globals at: name asSymbol ifPresent: [ :cls | isMeta ifTrue: [ cls class ] ifFalse: [ cls ] ]
]

{ #category : #accessing }
LePharoCreateExampleElement >> selectorName: aString [
	selectorName := aString.
	self validateCanSave
]

{ #category : #accessing }
LePharoCreateExampleElement >> snippet [
	^ snippet
]

{ #category : #accessing }
LePharoCreateExampleElement >> snippet: aLePharoSnippet [
	snippet := aLePharoSnippet
]

{ #category : #private }
LePharoCreateExampleElement >> updatePackageName [
	self selectedClass
		ifNotNil:
			[ :cls | 
			packageEditor text asString isEmpty
				ifTrue:
					[ packageName := cls instanceSide package name.
					packageEditor text: packageName asRopedText ] ]
]

{ #category : #validating }
LePharoCreateExampleElement >> validateCanSave [
	saveButton enabled: (self isValidClassName and: [ self isValidSelector and: [ self isValidPackage ] ])
]
