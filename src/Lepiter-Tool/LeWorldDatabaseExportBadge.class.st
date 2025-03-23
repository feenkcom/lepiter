Class {
	#name : #LeWorldDatabaseExportBadge,
	#superclass : #BrButton,
	#instVars : [
		'database',
		'contentExtent'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #accessing }
LeWorldDatabaseExportBadge >> contentExtent [
	^ contentExtent
]

{ #category : #accessing }
LeWorldDatabaseExportBadge >> contentExtent: aPoint [
	self 
		assert: [ aPoint isNotNil ]
		description: [ 'Extent must be non-nil' ].
	contentExtent := aPoint
]

{ #category : #'building widgets' }
LeWorldDatabaseExportBadge >> createDropdownContentWithAnchor: anAnchorElement [
	| containerGroup |
	containerGroup := BrTabGroup new.
	containerGroup aptitude: BrGlamorousTabGroupAptitude new.
	
	containerGroup 
		addTab: (self createRoamExportTabWithAnchor: anAnchorElement).
	
	^ containerGroup
]

{ #category : #'building widgets' }
LeWorldDatabaseExportBadge >> createDropdownExpandedHandleButton [
	^ BrButton new
		icon: BrGlamorousIcons savetodisk;
		label: self tooltip;
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2
				- BrGlamorousButtonExteriorAptitude
]

{ #category : #'building widgets' }
LeWorldDatabaseExportBadge >> createExportRoamJsonElementWithAnchor: anAnchorElement [ 
	^ BrFileSelectOrCreate new
		folder: FileLocator home;
		fileFilterBlock: [ :file | file extension asLowercase = 'json' ];
			okAction: [ :file :button | 
				anAnchorElement dispatchEvent: (BrDropdownHideWish new anchor: anAnchorElement).
				self exportToFile: file.
				self informExportToFile: file ];
		buttonLabel: 'Export';
		exact: self contentExtent;
		padding: (BlInsets all: 20)
]

{ #category : #'building widgets' }
LeWorldDatabaseExportBadge >> createRoamExportTabWithAnchor: anAnchorElement [
	^ BrTab new
		aptitude: BrGlamorousTabAptitude new;
		label: 'Roam';
		stencil: [ 
			self createExportRoamJsonElementWithAnchor: anAnchorElement ]
]

{ #category : #accessing }
LeWorldDatabaseExportBadge >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #private }
LeWorldDatabaseExportBadge >> exportToFile: aFile [
	database
		ifNil: [ ^ self ].
	
	aFile ensureDelete.
	database
		toRoamJsonFile: aFile
]

{ #category : #private }
LeWorldDatabaseExportBadge >> informExportToFile: aFile [
	| informMessage |
	informMessage := 'Export to file {1} finished successfully.' 
		format: { aFile basename }.
	self inform: informMessage
]

{ #category : #initialize }
LeWorldDatabaseExportBadge >> initialize [
	super initialize.
	
	self
		icon: BrGlamorousIcons savetodisk;
		aptitude: BrGlamorousButtonWithIconAptitude.
	self addAptitude: (BrGlamorousWithExplicitDropdownAptitude
		handle: [ self createDropdownExpandedHandleButton ]
		content: [ self createDropdownContentWithAnchor: self ]).
		
	self aptitude - BrGlamorousButtonExteriorAptitude.
]

{ #category : #accessing }
LeWorldDatabaseExportBadge >> tooltip [
	^ self label
]

{ #category : #accessing }
LeWorldDatabaseExportBadge >> tooltip: anObject [
	self label: anObject
]
