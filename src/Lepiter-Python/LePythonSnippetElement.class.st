"
LePythonElement displays the contents of a {{gtClass:name=LePythonSnippet}} as styled text, with a floating toolbar to execute the contents, and optionally inspect the results.

Currently the global uniqueInstance of the {{gtClass:name=PBApplication}} is always used for execution.

"
Class {
	#name : #LePythonSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
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

	^ BrButton new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularSmallSize
				foreground: BrGlamorousColors textMarkupColor);
		label: 'Python not running';
		action: [ :element | 
			element phlow spawnObject: self serverStrategy applicationServer.
			self updateLanguageLabel ];
		margin: (BlInsets top: 5 right: 5);
		fitContent
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
			file source: self editor text asString.
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
	
	Beacon instance announcer weak
		when: LanguageLinkStartStopSignal
		send: #onLanguageLinkStartStop:
		to: self
]

{ #category : #'api - snippet view model' }
LePythonSnippetElement >> unsubscribeFromSnippetViewModel [
	"Is sent before a new Snippet view model is assigned to the element.
	Elements that subscribe to Snippet view model in domain model are required to implement this methods"
	
	super unsubscribeFromSnippetViewModel.
	
	Beacon instance announcer unsubscribe: self
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
	languageElement label: label
]
