"
LeExternalEvaluatedSnippetElement is an abstract class that provides common behaviour for snippets that are evaluated in an external process.

"
Class {
	#name : 'LeExternalEvaluatedSnippetElement',
	#superclass : 'LeEvaluatedSnippetElement',
	#instVars : [
		'snippetBindings',
		'coderModel',
		'serverStrategy',
		'server',
		'serverException',
		'languageElement'
	],
	#category : 'Lepiter-UI-Snippet-! Views'
}

{ #category : 'testing' }
LeExternalEvaluatedSnippetElement class >> isAbstract [
	^ self = LeExternalEvaluatedSnippetElement
]

{ #category : 'private - execution' }
LeExternalEvaluatedSnippetElement >> executeContents [
	"Execute the receiver's contents"

	self coderViewModel doItAll
]

{ #category : 'private - execution' }
LeExternalEvaluatedSnippetElement >> executeContentsAndSpawnFrom: anElement [
	"Execute the receiver's contents and spawn the result"

	self database isDatabase ifFalse:
		[ self error: 'Unable to execute - no database ' ].
	self coderViewModel doItAndGo
]

{ #category : 'initialization' }
LeExternalEvaluatedSnippetElement >> initialize [ 
	super initialize.

	self initializeTextEditor.
	self initializeCoderToolbar.
	self initializeSpawnDownElements.

	self registerSpawnBelowHandler
]

{ #category : 'initialization' }
LeExternalEvaluatedSnippetElement >> initializeCoderToolbar [
	"Initialise the toolbar that contains the control buttons (doIt, doIt and inspect)"
	| buttonBar toolbar |

	buttonBar := BrHorizontalPane new matchParent preventMouseEvents.
	buttonBar
		vFitContent;
		hMatchParent;
		zIndex: 1000.

	buttonBar addChild: (BrButton new 
		beTinySize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons play;
		label: #Evaluate;
		action: [ :aButton | self executeContents ]) as: #executeButton.
	buttonBar addChild: (BrButton new 
		beTinySize;
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons playinspect;
		label: #Inspect;
		action: [ :aButton | self executeContentsAndSpawnFrom: aButton ]) as: #executeAndSpawnButton.

	languageElement := self initializeLanguageElement.

	toolbar := BrHorizontalPane new matchParent preventMouseEvents.
	toolbar
		vFitContent;
		hMatchParent;
		addChild: buttonBar;
		addChild: languageElement.

	coderToolbar := BrHorizontalPane new
		vFitContent;
		hMatchParent;
		alignBottomLeft;
		addChild: toolbar.

	spawnDestinationLook := GtSourceCoderSpawnDestinationAptitude new.
	coderToolbar addAptitude: spawnDestinationLook.

]

{ #category : 'initialization' }
LeExternalEvaluatedSnippetElement >> initializeLanguageElement [
	"Initialise the element that displays the language and connection details.
	This is normally a text element, but subclasses may replace it with something else, e.g. a button"

	^ BlAttributedTextElement new
		glamorousRegularSmallSize;
		text: ('<unknown>' asRopedText foreground: BrGlamorousColors textMarkupColor);
		padding: (BlInsets top: 5 left: 5 bottom: 0 right: 30);
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal fitContent. ].

]

{ #category : 'initialization' }
LeExternalEvaluatedSnippetElement >> initializeTextEditor [

	editorElement := GtSourceCoderEditorElement new 
		padding: (BlInsets top: 5 left: 5 bottom: 5 right: 0).

	editorElement editor addEventHandler: (LeEditorReachedBorderEventHandler new snippetElement: self)
]

{ #category : 'initialization' }
LeExternalEvaluatedSnippetElement >> initializeTextEditorShortcuts [
	"Initialise the receiver's text editor shortcuts"
	
	editorElement
		"Create New snippet (after the current snippet)"
		addEditorShortcut: (LeSnippetSplitSnippetShortcut new combination: (self keyboardShortcut: #SplitSnippet));
		"Delete previous character, or merge with previous snippet"
		addEditorShortcut: (LeSnippetDeletePreviousShortcut new combination: (self keyboardShortcut: #DeletePrevious));
		"Delete next character, or merge with following snippet"
		addEditorShortcut: (LeSnippetDeleteNextShortcut new combination: (self keyboardShortcut: #DeleteNext));
		"New Line in LeSnippet"
		addEditorShortcut: (BrEditorLineEndingShortcut new combination: (self keyboardShortcut: #NewLine));
		"Lose focus LeSnippet"
		addEditorShortcut: (BrEditorLoseFocusShortcut new combination: (self keyboardShortcut: #LoseFocus));
		"Indent LeSnippet"
		addEditorShortcut: (LeSnippetIndentSnippetShortcut new combination: (self keyboardShortcut: #IndentSnippet));
		"Unindent LeSnippet"
		addEditorShortcut: (LeSnippetUnindentSnippetShortcut new combination: (self keyboardShortcut: #UnindentSnippet));
		"Move snippet up"
		addEditorShortcut: (LeSnippetMoveSnippetUpShortcut new combination: (self keyboardShortcut: #MoveSnippetUp));
		"Alt-Shift-Down -> Move snippet down"
		addEditorShortcut: (LeSnippetMoveSnippetDownShortcut new combination: (self keyboardShortcut: #MoveSnippetDown));
		"Primary-R -> Rename"
		addEditorShortcut: (LeSnippetRenameSnippetShortcut new combination: (self keyboardShortcut: #RenameSnippet)).
]

{ #category : 'initialization' }
LeExternalEvaluatedSnippetElement >> registerSpawnBelowHandler [
	self
		when: GtPhlowObjectToSpawn
		do: [ :aSpawnEvent |
			(aSpawnEvent spawnDestination isSpawnBelow and:
			[ (aSpawnEvent properties includesKey: #spawnContainer) not ]) ifTrue: [ 
				aSpawnEvent consumed: true. 
				self fireEvent: (GtPhlowObjectToSpawn new 
					previousSpawnEvent: aSpawnEvent;
					tool: aSpawnEvent tool; 
					sourceElement: aSpawnEvent currentTarget;
					spawnDestination: aSpawnEvent spawnDestination;
					in: [ :anNewEvent | 
						anNewEvent propertyAt: #spawnContainer put: self ];
					yourself) ] ].
]
