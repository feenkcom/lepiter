Class {
	#name : #LeShellCommandSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
	#instVars : [
		'indicator',
		'bindingEditor'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #accessing }
LeShellCommandSnippetElement >> go [
	| command arguments result bindingName sharedBindings binding |
	
	command := form command.
	arguments := form argumentStrings.
	bindingName := form bindingName.

	self snippetViewModel snippetModel 
		command: command;
		arguments: arguments;
		bindingName: bindingName.

	sharedBindings := self snippetViewModel snippetBindings.
	
	result := form executeUsingBindings: sharedBindings asDictionary.
	
	binding := sharedBindings bindingOf: bindingName asSymbol.
	binding value: result.

	^ result
]

{ #category : #initialization }
LeShellCommandSnippetElement >> initializeCoderToolbar [
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
		when: BrTextEditorModifiedEvent do: [ :event | self onBindingEditorModified: event ] .
	coderToolbar addChild: bindingEditor
]

{ #category : #initialization }
LeShellCommandSnippetElement >> initializeLanguageElement [
	indicator := super initializeLanguageElement.
	indicator text: 'Shell command'.
	^ indicator
]

{ #category : #initialization }
LeShellCommandSnippetElement >> onBindingEditorModified: event [
	| newBindingName |
	newBindingName := event text asString.
	self snippet bindingName: newBindingName.
	self coder bindingName: newBindingName.
	event consumed: true
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
	^ super subscribeToSnippetViewModel
]

{ #category : #'api - snippet view model' }
LeShellCommandSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel
]

{ #category : #'private - updating' }
LeShellCommandSnippetElement >> updateBindingElement [
	bindingEditor
		text: (self snippetViewModel bindingName ifNil: [ String new ]) asRopedText
]
