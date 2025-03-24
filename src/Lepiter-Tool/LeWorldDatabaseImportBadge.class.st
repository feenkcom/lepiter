Class {
	#name : #LeWorldDatabaseImportBadge,
	#superclass : #BrButton,
	#instVars : [
		'database',
		'contentExtent'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #accessing }
LeWorldDatabaseImportBadge >> contentExtent [
	^ contentExtent
]

{ #category : #accessing }
LeWorldDatabaseImportBadge >> contentExtent: aPoint [
	self 
		assert: [ aPoint isNotNil ]
		description: [ 'Extent must be non-nil' ].
	contentExtent := aPoint
]

{ #category : #'building widgets' }
LeWorldDatabaseImportBadge >> createDropdownContentWithAnchor: anAnchorElement [
	| containerGroup |
	containerGroup := BrTabGroup new.
	containerGroup aptitude: BrGlamorousTabGroupAptitude new.
	
	containerGroup 
		addTab: (self createRoamImportTabWithAnchor: anAnchorElement);
		addTab: (self createJupyterNotebookImportTabWithAnchor: anAnchorElement).
	
	^ containerGroup
]

{ #category : #'building widgets' }
LeWorldDatabaseImportBadge >> createDropdownExpandedHandleButton [
	^ BrButton new
		icon: BrGlamorousIcons loadfromdisk;
		label: self tooltip;
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2
				- BrGlamorousButtonExteriorAptitude
]

{ #category : #'building widgets' }
LeWorldDatabaseImportBadge >> createDropdownHiddenHandleButton [
	^ BrButton new
		icon: BrGlamorousIcons loadfromdisk;
		label: self tooltip;
		aptitude: BrGlamorousButtonWithIconAptitude
]

{ #category : #'building widgets' }
LeWorldDatabaseImportBadge >> createImportRoamJsonElementWithAnchor: anAnchorElement [
	^ BrFileSelector new
		folder: FileLocator home;
		fileFilterBlock: [ :file | file extension asLowercase = 'json' ];
		okAction: [ :file :button | 
			file isFile
				ifTrue: [
					anAnchorElement dispatchEvent: (BrDropdownHideWish new 
						anchor: anAnchorElement).
					self importRoamJsonFile: file ] ];
		buttonLabel: 'Import';
		exact: self contentExtent;
		padding: (BlInsets all: 20)
]

{ #category : #'building widgets' }
LeWorldDatabaseImportBadge >> createJupyterNotebookImportElementWithAnchor: anAnchorElement [
	^ BrFileSelector new
		folder: FileLocator home;
		fileFilterBlock: [ :file | file extension asLowercase = 'ipynb' ];
		okAction: [ :file :button | 
			file isFile
				ifTrue: [
					anAnchorElement dispatchEvent: (BrDropdownHideWish new 
						anchor: anAnchorElement).
					self importJupyterNotebookFromFile: file ] ];
		buttonLabel: 'Import';
		exact: self contentExtent;
		padding: (BlInsets all: 20)
]

{ #category : #'building widgets' }
LeWorldDatabaseImportBadge >> createJupyterNotebookImportTabWithAnchor: anAnchorElement [
	^ BrTab new
		aptitude: BrGlamorousTabAptitude new;
		label: 'Jupyter Notebook';
		stencil: [
			self createJupyterNotebookImportElementWithAnchor: anAnchorElement ]
]

{ #category : #'building widgets' }
LeWorldDatabaseImportBadge >> createRoamImportTabWithAnchor: anAnchorElement [
	^ BrTab new
		aptitude: BrGlamorousTabAptitude new;
		label: 'Roam';
		stencil: [ 
			self createImportRoamJsonElementWithAnchor: anAnchorElement ]
]

{ #category : #accessing }
LeWorldDatabaseImportBadge >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #importing }
LeWorldDatabaseImportBadge >> importJupyterNotebookFromFile: aFileReference [
	| importer importedPage |
	importer := LeJupyterNotebookImporter new.
	importedPage := importer createLepiterPageForNotebookAt: aFileReference.
	database addPage: importedPage.
	
	self informImportFromFile: aFileReference.
]

{ #category : #importing }
LeWorldDatabaseImportBadge >> importRoamJsonFile: aFileReference [
	LeDatabaseMerge 
		merge: (LeDatabase fromRoamJsonFile: aFileReference)
		into: database.
	
	self informImportFromFile: aFileReference.
]

{ #category : #importing }
LeWorldDatabaseImportBadge >> informImportFromFile: aFile [
	| informMessage |
	informMessage := 'Import from file {1} finished successfully.' 
		format: { aFile basename }.
	self inform: informMessage
]

{ #category : #initialize }
LeWorldDatabaseImportBadge >> initialize [ 
	super initialize.
	
	self
		icon: BrGlamorousIcons loadfromdisk;
		aptitude: BrGlamorousButtonWithIconAptitude.
	self addAptitude: (BrGlamorousWithExplicitDropdownAptitude
		handle: [ self createDropdownExpandedHandleButton ]
		content: [self createDropdownContentWithAnchor: self ]).
		
	self aptitude - BrGlamorousButtonExteriorAptitude.
]

{ #category : #'api - tooltip' }
LeWorldDatabaseImportBadge >> tooltip [
	^ self label
]

{ #category : #'api - tooltip' }
LeWorldDatabaseImportBadge >> tooltip: aString [
	self label: aString
]
