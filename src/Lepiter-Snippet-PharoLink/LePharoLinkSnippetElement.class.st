"
LePythonElement displays the contents of a {{gtClass:name=LePharoLinkSnippet}} as styled text, with a floating toolbar to execute the contents, and optionally inspect the results.

Currently the global uniqueInstance of the {{gtClass:name=PharoLinkApplication}} is always used for execution.

"
Class {
	#name : #LePharoLinkSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
	#category : #'Lepiter-Snippet-PharoLink-Snippet'
}

{ #category : #'api - snippet view model' }
LePharoLinkSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self updateLanguageLabel.
	self coder pharoBindings: self snippetViewModel snippetBindings
]

{ #category : #accessing }
LePharoLinkSnippetElement >> serverStrategy [
	^ self coder applicationStrategy
]

{ #category : #private }
LePharoLinkSnippetElement >> updateLanguageLabel [
	| serverAddress label |

	serverAddress := self serverStrategy applicationSettings serverSocketAddress.
	label := String streamContents: [ :stream |
		stream
			<< 'Pharo @ ';
			<< serverAddress ipOrName;
			<< ':';
			print: serverAddress port ].
	languageElement text: (label asRopedText glamorousRegularFont foreground: BrGlamorousColors textMarkupColor).

]
