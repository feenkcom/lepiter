Class {
	#name : #LeShellScriptSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
	#instVars : [
		'indicator',
		'bindingEditor'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #'gt-extensions' }
LeShellScriptSnippetElement >> gtHelpActionFor: composite [
	<gtAction>
	^ composite button
		label: 'Help';
		priority: 30;
		tooltip: 'Show documentation';
		action: [ :aButton | 
			aButton phlow 
				spawnObject: (LeDatabase gtBook pageNamed: 'Shell snippet') ]
]

{ #category : #'gt - extensions' }
LeShellScriptSnippetElement >> gtHelpViewFor: composite [
	<gtView>
	^ composite forward
		title: 'Help';
		priority: 3;
		tooltip: 'Show documentation';
		object: [ LeDatabase gtBook pageNamed: 'Shell snippet' ];
		yourself
]

{ #category : #initialization }
LeShellScriptSnippetElement >> initializeCoderToolbar [
	| label |
	super initializeCoderToolbar.
	label := BrLabel new
			beTinySize;
			margin: (BlInsets left: 0 right: 1);
			text: 'Binding:' asRopedText;
			constraintsDo: [ :c | c linear vertical alignCenter ];
			aptitude: BrGlamorousLabelAptitude new.
	coderToolbar addChild: label.
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
	coderToolbar addChild: bindingEditor.
]

{ #category : #initialization }
LeShellScriptSnippetElement >> initializeLanguageElement [
	indicator := super initializeLanguageElement.
	indicator text: 'Shell script'.
	^ indicator
]

{ #category : #'private - updating' }
LeShellScriptSnippetElement >> onBindingEditorModified: event [
	| newBindingName |
	newBindingName := event text asString.
	self snippet bindingName: newBindingName.
	self coder bindingName: newBindingName.
	event consumed: true
]

{ #category : #'private - updating' }
LeShellScriptSnippetElement >> onShellSourceCoderStarted: announement [
	self enqueueTask: (BlTaskAction new action: [ indicator text: 'Shell script (running)' ])
]

{ #category : #'private - updating' }
LeShellScriptSnippetElement >> onShellSourceCoderStopped: announement [
	self enqueueTask: (BlTaskAction new action: [ indicator text: 'Shell script' ])
]

{ #category : #'api - snippet view model' }
LeShellScriptSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	
	self coder
		pharoBindings: self snippetViewModel snippetBindings;
		bindingName: self snippetViewModel bindingName.
		
	self updateBindingElement
]

{ #category : #'api - snippet view model' }
LeShellScriptSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.
	
	self coder announcer weak
		when: GtShellScriptStarted send: #onShellSourceCoderStarted: to: self;
		when: GtShellScriptStopped send: #onShellSourceCoderStopped: to: self
]

{ #category : #'api - snippet view model' }
LeShellScriptSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.
	
	self coder announcer unsubscribe: self
]

{ #category : #'private - updating' }
LeShellScriptSnippetElement >> updateBindingElement [
	bindingEditor
		text: (self snippetViewModel bindingName ifNil: [ String new ]) asRopedText
]
