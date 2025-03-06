Class {
	#name : #LeHomeDatabaseHeaderElement,
	#superclass : #LeHomeCommonDatabaseHeaderElement,
	#instVars : [
		'editableTitleElement',
		'removeButtonElement',
		'importButtonElement',
		'exportButtonElement'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #'private - accessing' }
LeHomeDatabaseHeaderElement >> databaseName [
	<return: #String>
	
	self 
		assert: [ self database isDatabase ] 
		description: [ 'Only databases know their names' ].

	self 
		assert: [ self database isLogicalDatabase not ] 
		description: [ 'Only real databases know their names' ].
	
	^ self database databaseName ifNil: [ 'undefined database name' ]
]

{ #category : #'private - accessing' }
LeHomeDatabaseHeaderElement >> editableTitleElement [
	<return: #BrEditableLabel>
	^ editableTitleElement
]

{ #category : #'private - accessing' }
LeHomeDatabaseHeaderElement >> exportButtonElement [
	^ exportButtonElement
]

{ #category : #'private - accessing' }
LeHomeDatabaseHeaderElement >> importButtonElement [
	^ importButtonElement
]

{ #category : #initialization }
LeHomeDatabaseHeaderElement >> initialize [
	super initialize.
	self initializeEditableTitleElement.
	self initializeButtons.
	
	self addChild: self toolbarElement as: #toolbar.
	self toolbarElement 
		addItem: self editableTitleElement;
		addItem: self newAddNewPageButton;
		addItem: self removeButtonElement;
		addItem: self importButtonElement;
		addItem: self exportButtonElement.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent; 
		hInherit: self toolbarElement;
		vAnyToFitContent: self toolbarElement).
]

{ #category : #initialization }
LeHomeDatabaseHeaderElement >> initializeButtons [
	self initializeRemoveButton.
	self initializeImportButton.
	self initializeExportButton.
]

{ #category : #initialization }
LeHomeDatabaseHeaderElement >> initializeEditableTitleElement [
	editableTitleElement := BrEditableLabel new
		aptitude: (BrGlamorousEditableLabelAptitude new 
			glamorousRegularFontAndSize);
		when: BrEditorAcceptWish do: [ :aWish | 
			self onDatabaseNameAcceptWish: aWish ];
		when: BrEditorCancelWish do: [ :aWish | 
			self onDatabaseNameCancelWish: aWish ]
]

{ #category : #initialization }
LeHomeDatabaseHeaderElement >> initializeExportButton [
	exportButtonElement := self newExportButton.
]

{ #category : #initialization }
LeHomeDatabaseHeaderElement >> initializeImportButton [
	importButtonElement := self newImportButton.
]

{ #category : #initialization }
LeHomeDatabaseHeaderElement >> initializeRemoveButton [
	removeButtonElement := self newRemoveButtonElement
		visibility: BlVisibility gone.
]

{ #category : #initialization }
LeHomeDatabaseHeaderElement >> newExportButton [
	"Answer a dropdown button for exporting a new database"
	^ LeWorldDatabaseExportBadge new
		tooltip: 'Export database to disk';
		contentExtent: 600 @ 450
]

{ #category : #initialization }
LeHomeDatabaseHeaderElement >> newImportButton [
	"Answer a dropdown button for importing a new database in the receiver"
	^ LeWorldDatabaseImportBadge new
		tooltip: 'Import database from disk';
		contentExtent: 600 @ 450
]

{ #category : #initialization }
LeHomeDatabaseHeaderElement >> newRemoveButtonElement [
	| removeButton |
	removeButton := BrButton new.
	removeButton
		aptitude: BrGlamorousButtonWithIconAptitude
			+ (BrGlamorousWithExplicitDropdownAptitude
					handle: [ BrButton new
						icon: BrGlamorousIcons empty;
						aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude ]
					content: (LeHomeRemoveDatabaseDropdownContentStencil new
						databaseElement: self; 
						anchor: removeButton));
		beTinySize;
		margin: (BlInsets left: 3);
		label: 'Remove database';
		icon: BrGlamorousVectorIcons remove.
	^ removeButton
]

{ #category : #'private - hooks' }
LeHomeDatabaseHeaderElement >> onContentUIModelChanged [
	super onContentUIModelChanged.
	self updateElement.
]

{ #category : #'private - event handling' }
LeHomeDatabaseHeaderElement >> onDatabaseNameAcceptWish: aWish [
	| aNewName |
	aNewName := aWish text asString ifEmpty: [ nil ].
	self database databaseName: aNewName.
	aNewName ifNil: [ aWish currentTarget text: self databaseName ].
	aWish currentTarget loseFocus.
]

{ #category : #'private - event handling' }
LeHomeDatabaseHeaderElement >> onDatabaseNameCancelWish: aWish [
	aWish currentTarget loseFocus.
]

{ #category : #'private - accessing' }
LeHomeDatabaseHeaderElement >> removeButtonElement [
	^ removeButtonElement
]

{ #category : #'private - actions' }
LeHomeDatabaseHeaderElement >> removeDatabase [
	self database removeFromParentDatabaseUpdatingProperties.
]

{ #category : #'private - updating' }
LeHomeDatabaseHeaderElement >> updateElement [
	self editableTitleElement text: self databaseName.
	self updateToolbarButtons.
]

{ #category : #'private - updating' }
LeHomeDatabaseHeaderElement >> updateRemoveButtonElement [
	(self database hasParentDatabase and: [ self database isPrimary not ])
		ifTrue: [ self removeButtonElement visibility: BlVisibility visible ]
		ifFalse: [ self removeButtonElement visibility: BlVisibility gone ].
]

{ #category : #'private - updating' }
LeHomeDatabaseHeaderElement >> updateToolbarButtons [
	self updateRemoveButtonElement.
	self exportButtonElement database: self database.
	self importButtonElement database: self database.
]
