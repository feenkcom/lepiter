Class {
	#name : #LeShellCommandSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
	#instVars : [
		'indicator'
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
LeShellCommandSnippetElement >> initializeLanguageElement [
	indicator := super initializeLanguageElement.
	indicator text: 'Shell command'.
	^ indicator
]

{ #category : #'api - snippet view model' }
LeShellCommandSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.
	
	"bindingName"
]

{ #category : #'api - snippet view model' }
LeShellCommandSnippetElement >> subscribeToSnippetViewModel [
	^ super subscribeToSnippetViewModel
]

{ #category : #'api - snippet view model' }
LeShellCommandSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel
]
