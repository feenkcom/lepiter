"
LePythonElement displays the contents of a {{gtClass:name=LePythonSnippet}} as styled text, with a floating toolbar to execute the contents, and optionally inspect the results.

Currently the global uniqueInstance of the {{gtClass:name=PBApplication}} is always used for execution.

"
Class {
	#name : #LePythonSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
	#category : #'Lepiter-Python-Snippet'
}

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

{ #category : #private }
LePythonSnippetElement >> updateLanguageLabel [
	| serverAddress label |

	serverAddress := self serverStrategy applicationSettings pythonSocketAddress.
	label := String streamContents: [ :stream |
		stream
			<< 'Python @ ';
			<< serverAddress ipOrName;
			<< ':';
			print: serverAddress port ].
	languageElement text: (label asRopedText glamorousRegularFont foreground: BrGlamorousColors textMarkupColor).

]
