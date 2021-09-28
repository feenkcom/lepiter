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
		'languageElement',
		'contentElement'
	],
	#category : 'Lepiter-UI-Snippet-! Views'
}

{ #category : 'testing' }
LeExternalEvaluatedSnippetElement class >> isAbstract [
	^ self = LeExternalEvaluatedSnippetElement
]

{ #category : 'initialization' }
LeExternalEvaluatedSnippetElement >> initialize [ 
	super initialize.

	self initializeTextEditor.
	self initializeCoderToolbar.
	self initializeSpawnDownElements.
	
	languageElement := self initializeLanguageElement.
	languageElement constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop ].
	
	contentElement := BrFrame new
		hMatchParent;
		vFitContent;
		addChildren: { editorElement. languageElement}.

	self registerSpawnBelowHandler
]

{ #category : 'initialization' }
LeExternalEvaluatedSnippetElement >> initializeLanguageElement [
	"Initialise the element that displays the language and connection details.
	This is normally a text element, but subclasses may replace it with something else, e.g. a button"

	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularSmallSize
		foreground: BrGlamorousColors textMarkupColor);
		margin: (BlInsets top: 5 right: 5);
		text: '<unknown>'
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

{ #category : 'accessing' }
LeExternalEvaluatedSnippetElement >> snippetContent [
	^ contentElement
]
