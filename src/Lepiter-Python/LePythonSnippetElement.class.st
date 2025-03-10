"
LePythonElement displays the contents of a {{gtClass:name=LePythonSnippet}} as styled text, with a floating toolbar to execute the contents, and optionally inspect the results.

Currently the global uniqueInstance of the {{gtClass:name=PBApplication}} is always used for execution.

"
Class {
	#name : #LePythonSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
	#instVars : [
		'dropdownHandleButton'
	],
	#category : #'Lepiter-Python-Snippet'
}

{ #category : #accessing }
LePythonSnippetElement >> coderEditorElementClass [
	^ LeLSPSourceCoderEditorElement
]

{ #category : #initialization }
LePythonSnippetElement >> initializeLanguageElement [
	"Initialise the element that displays the language and connection details.
	This is normally a text element, but subclasses may replace it with something else, e.g. a button"

	| aptitude |
	aptitude := BrGlamorousWithExplicitDropdownAptitude
		handle: [
			dropdownHandleButton := BrButton new
				aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonWithLabelAptitude;
				label: languageElement label;
				beSmallSize ]
		content: [ | buttonBar details contents|
			buttonBar := BrHorizontalPane new
				hMatchParent;
				vFitContent;
				layout: (BlLinearLayout horizontal cellSpacing: 5);
				margin: (BlInsets all: 5);
				addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons shutdown;
					label: 'Start/stop PythonBridge';
					action: [ :element | self serverStrategy applicationServer toggleStartStop ]);
				addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons refresh;
					label: 'Restart PythonBridge';
					action: [ :element | self serverStrategy applicationServer restart ]);
				addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons edit;
					label: 'Open LSP editor';
					action: [ :element | | model |
						model := GtLSPPythonModel onDirectory: self serverStrategy applicationServer settings workingDirectory.
						self phlow spawnObject: model.
						element fireEvent: BrDropdownHideWish new ]);
				addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousVectorIcons inspect;
					label: 'Inspect PythonBridge';
					action: [ :element | 
						self phlow spawnObject: self serverStrategy applicationServer.
						element fireEvent: BrDropdownHideWish new ]);
				yourself.
			details := (self serverStrategy applicationServer gtDetailsFor: GtPhlowEmptyView new) asElement.
			contents := BrVerticalPane new
				addChild: details;
				addChild: buttonBar;
				fitContent.
			contents size: 600@300.
			contents ].
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude + aptitude - BrGlamorousButtonExteriorAptitude;
		label: 'Python not running';
		beSmallSize;
		yourself
]

{ #category : #accessing }
LePythonSnippetElement >> initializeTextEditor [
	super initializeTextEditor.
	editorElement editor
		when: BrTextEditorInsertedEvent
			do: [ :event | self updateLspSourceFrom: event ];
		when: BrTextEditorDeletedEvent
			do: [ :event | self updateLspSourceFrom: event ];
		when: BlInfiniteDataSourceChanged
			do: [ :event | self updateLspSourceFrom: event ].
	editorElement
		addEditorShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination primaryR;
				action: [ GtLSPRenameRefactoringController new
						editor: editorElement;
						lspFile: (self userData at: #lspFile);
						execute ])
]

{ #category : #accessing }
LePythonSnippetElement >> onAddedToSceneGraph [
	self userData
		at: #lspFile
		ifAbsentPut: [ | element snippetModel file |
			element := self
					allParentsDetect: [ :each | each class = LePageToolElement ]
					ifFound: [ :each | each ]
					ifNone: [ self ].
			snippetModel := element userData
					at: #lspSnippetModel
					ifAbsentPut: [ GtLSPPythonSnippetModel local ].
			file := snippetModel createSnippet.
			file source: self coder currentSourceString.
			file open.
			editorElement addAptitude: (GtLSPEditorAptitude new lspFile: file).
			file ].
	^ super onAddedToSceneGraph
]

{ #category : #accessing }
LePythonSnippetElement >> onLanguageLinkStartStop: anAnnouncement [
	self inUIProcessDo: [ self updateLanguageLabel]
]

{ #category : #'api - snippet view model' }
LePythonSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self updateLanguageLabel.
	self coder
		pharoBindings: self snippetViewModel snippetBindings.
]

{ #category : #accessing }
LePythonSnippetElement >> serverStrategy [
	^ self coder pythonApplicationStrategy
]

{ #category : #'api - snippet view model' }
LePythonSnippetElement >> subscribeToSnippetViewModel [
	"Is sent after a new Snippet view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromSnippetViewModel if elements subscribe to them"
	
	super subscribeToSnippetViewModel.
	
	LanguageLinkApplication announcer weak
		when: LanguageLinkStartStopAnnouncement
		send: #onLanguageLinkStartStop:
		to: self
]

{ #category : #'api - snippet view model' }
LePythonSnippetElement >> unsubscribeFromSnippetViewModel [
	"Is sent before a new Snippet view model is assigned to the element.
	Elements that subscribe to Snippet view model in domain model are required to implement this methods"
	
	super unsubscribeFromSnippetViewModel.
	
	LanguageLinkApplication announcer unsubscribe: self
]

{ #category : #private }
LePythonSnippetElement >> updateLanguageLabel [
	| serverAddress label |
	label := PBApplication isRunning
			ifTrue: [ 
				serverAddress := self serverStrategy applicationServer settings serverSocketAddress.
				'Python @ ' , serverAddress printAddress ]
			ifFalse: [ 
				'Python not running' ].
	languageElement label: label.
	dropdownHandleButton ifNotNil: [ dropdownHandleButton label: label ].
	^ label
]

{ #category : #accessing }
LePythonSnippetElement >> updateLspSourceFrom: event [
	(self userData at: #lspFile ifAbsent: [ ^ self ])
		source: event source text asString
]
