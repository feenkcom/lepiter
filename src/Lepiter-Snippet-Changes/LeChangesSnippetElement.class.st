Class {
	#name : #LeChangesSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'toolbarContainer',
		'changesContainer',
		'fileNameEditor',
		'inspectChangesButton',
		'createChangesFileButton',
		'updater',
		'lastSelection'
	],
	#category : #'Lepiter-Snippet-Changes-Snippet'
}

{ #category : #initialization }
LeChangesSnippetElement >> createChangesFileButton [
	| aButton |

	aButton := BrButton new.
	aButton
		icon: BrGlamorousVectorIcons accept;
		label: 'Create changes file';
		aptitude: BrGlamorousButtonWithIconAptitude;
		action: [
			self snippetViewModel shouldCreateChangesFile
					ifTrue: [
						self snippetViewModel changes ombuFile writeStreamDo: [ :s | s ].
						self
							importFromFile: self snippetViewModel changes ombuFile
							type: #move ] ].

	^ aButton
]

{ #category : #initialization }
LeChangesSnippetElement >> createChangesFilePicker [
	| aButton |
	aButton := BrButton new.
	aButton
		icon: BrGlamorousIcons loadfromdisk;
		label: 'Select .ombu file';
		aptitude: BrGlamorousButtonWithIconAptitude;
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
				handle: [ BrButton new
						icon: BrGlamorousIcons folder;
						aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude2
								- BrGlamorousButtonExteriorAptitude ]
				content: [ | stencil |
					stencil := LeImportFileSelector new.
					stencil
						folder: self lastSelection;
						okAction: [ :file :button | 
							file isFile
								ifTrue: [ aButton dispatchEvent: (BrDropdownHideWish new anchor: aButton).
									self lastSelection: file parent.
									self importFromFile: file type: stencil currentType ] ];
						buttonLabel: 'Import';
						exact: self extent;
						padding: (BlInsets all: 20) ]).

	^ aButton
]

{ #category : #initialization }
LeChangesSnippetElement >> createInspectChangesButton [
	| aButton |

	aButton := BrButton new.
	aButton
		icon: BrGlamorousVectorIcons inspect;
		label: 'Inspect changes';
		aptitude: BrGlamorousButtonWithIconAptitude;
		action: [
			self snippetViewModel hasChanges
				ifTrue: [ self phlow spawnObject: self snippetViewModel changes ] ].
				
	^ aButton
]

{ #category : #'private - updating' }
LeChangesSnippetElement >> importFromFile: aFile type: importType [ 
	"If required, copy or move the file to the receiver's database, and then update the URL to point to it"
	| attachedFile |

	attachedFile := self database = LeDatabase null
		ifTrue: [ aFile asAbsolute fullName ]
		ifFalse: [ importType = #copy ifTrue:
			[ self database addAttachmentByCopy: aFile ]
		ifFalse: [ importType = #move ifTrue:
			[ self database addAttachmentByMove: aFile ]
		ifFalse: [ importType = #inplace ifTrue:
			[ aFile asAbsolute fullName ]
		ifFalse: [ self error: 'Unknown import type' ] ] ] ].

	self snippetViewModel fileName: attachedFile
]

{ #category : #initialization }
LeChangesSnippetElement >> initialize [
	super initialize.
	
	changesContainer := BlElement new
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		layout: BlLinearLayout vertical;
		padding: (BlInsets top: 5 left: 7 bottom: 5 right: 5);
		yourself.	
	
	fileNameEditor := GtTextualCoderEditorElement new
		hMatchParent;
		vFitContent;
		constraintsDo: [ :c | c minWidth: 50 ];
		aptitude: BrGlamorousRegularEditorAptitude + BrGlamorousEditorSpacingAptitude;
		padding: (BlInsets top: 3 left: 3 bottom: 4 right: 3).
	fileNameEditor editor addEventHandler: (LeEditorReachedBorderEventHandler new snippetElement: self).

	inspectChangesButton := self createInspectChangesButton.
	createChangesFileButton := self createChangesFileButton.

	toolbarContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		cellSpacing: 4;
		padding: (BlInsets top: 0 left: 3 bottom: 2 right: 3);
		addChildren: { 
			BrLabel new
				margin: (BlInsets top: 1);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
				text: '.ombu file:'.
			fileNameEditor.
			self createChangesFilePicker.
			createChangesFileButton.
			inspectChangesButton }.

	updater := BrElementUpdater new 
		postponedDuration: 100 milliSeconds;
		element: self selector: #updateChangesPreview.
]

{ #category : #accessing }
LeChangesSnippetElement >> lastSelection [
	^ lastSelection ifNil: [ Smalltalk imageDirectory ]
]

{ #category : #accessing }
LeChangesSnippetElement >> lastSelection: anObject [
	lastSelection := anObject
]

{ #category : #'private - event handling' }
LeChangesSnippetElement >> onChangesChanged [
	updater requestUpdate
]

{ #category : #'api - snippet view model' }
LeChangesSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	
	self updateChangesPreview
]

{ #category : #'api - snippet view model' }
LeChangesSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"

	(aBoolean and: [ self snippetViewModel fileNameCoderViewModel focused not ])
		ifTrue: [ self requestFocus ].

	aBoolean
		ifFalse: [ self loseFocus ]
]

{ #category : #'private - updating' }
LeChangesSnippetElement >> showChangesNotFoundMessage [
	| aNotFoundMessage aContainer |

	aNotFoundMessage := self snippetViewModel hasChanges
		ifTrue: [ 'Changes file {1} does not yet exist' format: { self snippetViewModel changes ombuFile fullName } ]
		ifFalse: [ 'Changes file is not specified' ].
	
	aContainer := BrVerticalPane new
		hMatchParent;
		vExact: self snippetViewModel previewHeight;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		alignCenter;
		background: self theme default backdropColor;
		addChild: (BrLabel new
			aptitude: (BrGlamorousLabelAptitude new light foreground: Color veryDarkGray);
			text: aNotFoundMessage).
			
	self snippetViewModel shouldCreateChangesFile
		ifTrue: [ aContainer addChild: (
			self createChangesFileButton
				margin: (BlInsets top: 5);
				aptitude: BrGlamorousButtonWithIconAndLabelAptitude;
				icon: BrGlamorousVectorIcons add) ].
	
	changesContainer addChild: aContainer as: #changes
]

{ #category : #'api - view' }
LeChangesSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ changesContainer
]

{ #category : #'api - view' }
LeChangesSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ toolbarContainer
]

{ #category : #'api - snippet view model' }
LeChangesSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	
	self snippetViewModel weak
		when: LeChangesSnippetViewModelChangesChanged
		send: #onChangesChanged
		to: self
]

{ #category : #'private - updating' }
LeChangesSnippetElement >> updateChangesPreview [
	fileNameEditor textualCoderViewModel: self snippetViewModel fileNameCoderViewModel.
	
	changesContainer removeChildNamed: #changes.
	
	inspectChangesButton enabled: self snippetViewModel hasChanges.
	self snippetViewModel shouldCreateChangesFile
		ifTrue: [ createChangesFileButton visibility: BlVisibility visible ]
		ifFalse: [ createChangesFileButton visibility: BlVisibility gone ].

	self snippetViewModel hasChangesFile ifTrue: [
		| aChangesElement |
	
		aChangesElement := GtResizablePreviewStencil new
			result: self snippetViewModel changes;
			showSelector: #gtPreviewFor:;
			height: self snippetViewModel previewHeight;
			asElement.

		changesContainer addChild: aChangesElement as: #changes.
		^ self ].
	
	self showChangesNotFoundMessage
]
