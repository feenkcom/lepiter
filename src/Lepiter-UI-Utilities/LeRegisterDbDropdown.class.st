"
LeRegisterDbDropdown provides a UI for adding a lepiter DB to the default logical database.

This is used by the FileReference inspector to make it easy to add concrete databases to the default logical database.

"
Class {
	#name : #LeRegisterDbDropdown,
	#superclass : #BlElement,
	#instVars : [
		'directory',
		'dropdownElement',
		'currentDropdownContent',
		'textEditor'
	],
	#category : #'Lepiter-UI-Utilities-FileReference'
}

{ #category : #'instance creation' }
LeRegisterDbDropdown class >> directory: aFileReference [

	^ self new initializeWith: aFileReference
]

{ #category : #testing }
LeRegisterDbDropdown class >> isUnregisteredLepiterDb: aFileReference [
	"Answer a boolean indicating whether the supplied file reference is a lepiter Db directory"
	| properties |

	"Go from cheaper to more expensive tests to bail out as quickly as possible"
	aFileReference isDirectory ifFalse: [ ^ false ].
	properties := aFileReference / LepiterCoreDefaults databasePropertiesBasename.
	properties exists ifFalse: [ ^ false ].

	^ (LeDatabasesRegistry defaultLogicalDatabase hasDatabaseAt: aFileReference) not

]

{ #category : #private }
LeRegisterDbDropdown >> dropdownContent [

	^ currentDropdownContent ifNil: [ currentDropdownContent := self newDropdownContent ].
]

{ #category : #initialization }
LeRegisterDbDropdown >> initialize [ 

	super initialize.
	self layout: BlFrameLayout new.
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal fitContent ].
	 
	self addInteractiveModelState: BrLayoutHorizontalResizerModel fitContent.
	self addInteractiveModelState: BrLayoutVerticalResizerModel fitContent.
	
	self initializeDropdownElement.
	
	self addChild: dropdownElement as: #dropdown.
	
	self addAptitude: (BrLayoutResizerAptitude new
		anyToFitContent: self).

]

{ #category : #initialization }
LeRegisterDbDropdown >> initializeDropdownElement [

	dropdownElement := self newButton
		label: self tooltip;
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
			handle: [ self newDropdownButton ]
			content: [ self reusedDropdownContent ])
]

{ #category : #initialization }
LeRegisterDbDropdown >> initializeWith: aFileReference [

	directory := aFileReference
]

{ #category : #private }
LeRegisterDbDropdown >> newButton [

	^ BrButton new
		background: Color white;
		icon: self statusIcon;
		aptitude: BrGlamorousButtonWithIconAptitude 
			- BrGlamorousButtonExteriorAptitude
]

{ #category : #private }
LeRegisterDbDropdown >> newDropdownButton [
	^ BrButton new
		icon: self statusIcon;
		label: self tooltip;
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2
				- BrGlamorousButtonExteriorAptitude
]

{ #category : #private }
LeRegisterDbDropdown >> newDropdownContent [
	| container pane buttonPane |

	container := BrFrame new
		exact: 400@150.
	pane := BrVerticalPane new matchParent.
	pane addChild: (textEditor := BrEditor new
		aptitude: (BrGlamorousEditorAptitude new fontSize: 14);
		text: self statusText;
		matchParent).
	buttonPane := BrHorizontalPane new fitContent alignCenterRight.
	buttonPane addChild: (BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		label: 'Register';
		constraintsDo: [ :c |
			c flow horizontal alignRight ];
		action: [ self registerDb ]).
	pane addChild: buttonPane.
	container addChild: pane.
	^ container
]

{ #category : #private }
LeRegisterDbDropdown >> registerDb [
	"Register the database at directory"

	"Check that the button hasn't been pressed twice"
	(self class isUnregisteredLepiterDb: directory) ifFalse: [ ^ self ].

	LeDatabasesRegistry defaultLogicalDatabase 
		addDB: (LeLocalStoreLoad current loadAndMonitorFrom: directory);
		saveProperties.
	textEditor text: self statusText.
]

{ #category : #private }
LeRegisterDbDropdown >> reusedDropdownContent [
	| dropdown |

	dropdown := self dropdownContent.
	textEditor text: self statusText.
	^ dropdown removeFromParent
]

{ #category : #private }
LeRegisterDbDropdown >> statusIcon [
	"Answer the icon to display in the receiver's button"

	^ LeIcons lepiterIcon
]

{ #category : #private }
LeRegisterDbDropdown >> statusText [
	| properties dbName text infoString |

	properties := LeLocalStore current localRoot: directory.
	dbName := properties propertyAt: #databaseName ifAbsent: [ '<none>' ].
	text := (self class isUnregisteredLepiterDb: directory) ifTrue:
		[ 'Register this Lepiter database?' ]
	ifFalse:
		[ 'This database is already registered:' ].
	text := text asRopedText glamorousRegularFont.
	infoString := String streamContents: [ :stream |
		stream 
			cr; cr;
			<< 'Name:       ';
				<< dbName; cr;
			<< 'Directory:  ';
				<< directory asAbsolute fullName; cr;
			<< 'Page count: ';
				print: (directory childrenMatching: '*', properties storage dbFileExtension) size ].
	^ text, infoString asRopedText glamorousCodeFont.

]

{ #category : #private }
LeRegisterDbDropdown >> tooltip [

	^ 'Register Lepiter DB'
]
