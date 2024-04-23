Class {
	#name : #LeShellCommandSnippetElement,
	#superclass : #LeSnippetElement,
	#instVars : [
		'contentElement',
		'form'
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
LeShellCommandSnippetElement >> initialize [
	| formElement indicatorElement |
	super initialize.
	
	form := LeShellCommandPane new.
	form
		acceptAction: [ self go ];
		inspectAction: [ :model :element | element phlow spawnObject: self go ].
		
	formElement := form asElement margin: (BlInsets all: 10).
	formElement
		constraintsDo: [ :c | 
			c frame horizontal alignLeft.
			c frame vertical alignTop ].
	formElement hMatchParent.
		
	indicatorElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularSmallSize
		foreground: BrGlamorousColors textMarkupColor);
		margin: (BlInsets top: 5 right: 5);
		text: 'Shell command'.
	indicatorElement constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop ].
		
	contentElement := BrFrame new
		hMatchParent;
		vFitContent;
		addChildren: { formElement. indicatorElement }.
]

{ #category : #'api - snippet view model' }
LeShellCommandSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	
	form
		command: self snippetViewModel snippetModel command;
		argumentStrings: self snippetViewModel snippetModel arguments;
		bindingName: self snippetViewModel snippetModel bindingName
]

{ #category : #accessing }
LeShellCommandSnippetElement >> snippetContent [
	^ contentElement
]

{ #category : #accessing }
LeShellCommandSnippetElement >> snippetToolbar [
	^ nil
]
