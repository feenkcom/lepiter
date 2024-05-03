Class {
	#name : #LeShellCommandSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
	#instVars : [
		'indicator',
		'bindingEditor'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #initialization }
LeShellCommandSnippetElement >> initializeCoderToolbar [
	| label shellToolbar |
	super initializeCoderToolbar.

	shellToolbar := BrToolbar new
		aptitude: (BrGlamorousToolbarAptitude new spacing: 4);
		padding: (BlInsets left: -4).

	label := BrLabel new
			beTinySize;
			margin: (BlInsets left: 0 right: 1);
			text: 'Binding:' asRopedText;
			constraintsDo: [ :c | c linear vertical alignCenter ];
			aptitude: BrGlamorousLabelAptitude new.
	shellToolbar addChild: label.
	
	bindingEditor := BrEditor new
			vFitContent;
			hFitContentLimited;
			constraintsDo: [ :c | 
				c linear vertical alignCenter.
				c minWidth: 100 ];
			aptitude: BrGlamorousEditableLabelAptitude new glamorousCodeTinySize;
			addAptitude: BrGlamorousCodeEditorAptitude new.
	bindingEditor editor 
		text: '' asRopedText;
		when: BrTextEditorModifiedEvent do: [ :event | self onBindingEditorModified: event ].
	shellToolbar addChild: bindingEditor.

	coderToolbar addChild: shellToolbar
]

{ #category : #initialization }
LeShellCommandSnippetElement >> initializeLanguageElement [
	indicator := super initializeLanguageElement.
	indicator text: 'Shell command'.
	^ indicator
]

{ #category : #'private - updating' }
LeShellCommandSnippetElement >> onBindingEditorModified: event [
	| newBindingName |
	newBindingName := event text asString.
	self snippet bindingName: newBindingName.
	self coder bindingName: newBindingName.
	event consumed: true
]

{ #category : #'private - updating' }
LeShellCommandSnippetElement >> onShellSourceCoderStarted: announement [
	self enqueueTask: (BlTaskAction new action: [ indicator text: 'Shell command (running)' ])
]

{ #category : #'private - updating' }
LeShellCommandSnippetElement >> onShellSourceCoderStopped: announement [
	self enqueueTask: (BlTaskAction new action: [ indicator text: 'Shell command' ])
]

{ #category : #'api - snippet view model' }
LeShellCommandSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	
	self coder
		pharoBindings: self snippetViewModel snippetBindings;
		bindingName: self snippetViewModel bindingName.
		
	self updateBindingElement
]

{ #category : #'api - snippet view model' }
LeShellCommandSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	
	self coder announcer
		when: GtShellScriptStarted send: #onShellSourceCoderStarted: to: self;
		when: GtShellScriptStopped send: #onShellSourceCoderStopped: to: self
]

{ #category : #'api - snippet view model' }
LeShellCommandSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.
	
	self coder announcer unsubscribe: self
]

{ #category : #'private - updating' }
LeShellCommandSnippetElement >> updateBindingElement [
	bindingEditor
		text: (self snippetViewModel bindingName ifNil: [ String new ]) asRopedText
]
