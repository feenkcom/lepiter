Class {
	#name : #LeHomeAddDatabaseElement,
	#superclass : #LeHomeBasicElement,
	#instVars : [
		'buttonElement'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #'private - actions' }
LeHomeAddDatabaseElement >> addNewDatabaseInDirectory: aDirectory [
	| aDatabase aFileLocator |
	aFileLocator := aDirectory gtWithClosestFileLocatorParent.
	aDatabase := LeLocalStoreLoad current loadAndMonitorFrom: aFileLocator.
	
	self database addDB: aDatabase.
	
	LeDatabasesRegistry defaultLogicalDatabase properties 
		addRegisteredDirectory: aFileLocator.
]

{ #category : #'private - accessing' }
LeHomeAddDatabaseElement >> buttonElement [
	<return: #BrButton>
	^ buttonElement
]

{ #category : #initialization }
LeHomeAddDatabaseElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'private - accessing' }
LeHomeAddDatabaseElement >> dialogInitialFolder [
	| aParentDirectory |
	
	self database databasesToDisplayDo: [ :eachDatabase | 
		eachDatabase localStoreRootDirectory ifNotNil: [ :aDirectory |
			aDirectory exists ifTrue: [ 
				aParentDirectory := aDirectory parent ] ] ].
	
	^ aParentDirectory ifNil: [ FileLocator documents ]
]

{ #category : #initialization }
LeHomeAddDatabaseElement >> initialize [
	super initialize.
	self initializeButtonElement.
	
	self addChildFirst: self buttonElement as: #list.
	
	self addAptitude: (BrLayoutResizerAptitude new
		anyToFitContent: self buttonElement)
]

{ #category : #initialization }
LeHomeAddDatabaseElement >> initializeButtonElement [
	| aDropdownLook |
	buttonElement := BrButton new
		aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
		icon: BrGlamorousVectorIcons add;
		label: 'New Database';
		disable.
		
	aDropdownLook := BrGlamorousWithExplicitDropdownAptitude
			handle: [
				BrButton new
					icon: BrGlamorousIcons add;
					label: 'New Database';
					aptitude: 	BrGlamorousButtonWithIconAndLabelAptitude 
						- BrGlamorousButtonExteriorAptitude ]
			content: [
				BrFileSelector new
					folder: self dialogInitialFolder;
					fileFilterBlock: [ :aFile | aFile isDirectory ];
					okAction: [ :aDirectory :aButton | 
						aDirectory isDirectory
							ifTrue: [
								buttonElement dispatchEvent: (BrDropdownHideWish new anchor: buttonElement).
								self addNewDatabaseInDirectory: aDirectory ] ];
					buttonLabel: 'Add database';
					exact: self extent;
					addAptitude: BrGlamorousPopoverResizableAptitude new;
					padding: (BlInsets all: 20);
					matchParent ].
		
	buttonElement addAptitude: aDropdownLook
]

{ #category : #'private - hooks' }
LeHomeAddDatabaseElement >> onContentUIModelChanged [
	super onContentUIModelChanged.
	self updateElement
]

{ #category : #'private - updating' }
LeHomeAddDatabaseElement >> updateElement [
	self buttonElement enabled: self database isLogicalDatabase.
]
