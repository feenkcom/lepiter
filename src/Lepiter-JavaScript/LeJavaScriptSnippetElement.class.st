"
LeJavaScriptSnippetElement displays the contents of a {{gtClass:name=LeJavaScriptSnippet}} as styled text, with a floating toolbar to execute the contents, and optionally inspect the results.

Currently the global uniqueInstance of the {{gtClass:name=JSLinkApplication}} is always used for execution.

"
Class {
	#name : #LeJavaScriptSnippetElement,
	#superclass : #LeExternalEvaluatedSnippetElement,
	#category : #'Lepiter-JavaScript-Snippet'
}

{ #category : #'api - snippet view model' }
LeJavaScriptSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self updateLanguageLabel.
	self coder
		pharoBindings: self snippetViewModel snippetBindings
]

{ #category : #'instance creation' }
LeJavaScriptSnippetElement >> serverStrategy [
	^ self coder jsLinkApplicationStrategy
]

{ #category : #private }
LeJavaScriptSnippetElement >> updateLanguageLabel [
	| serverAddress label |

	serverAddress := self serverStrategy applicationSettings serverSocketAddress.
	label := String streamContents: [ :stream |
		stream
			<< 'JS @ ';
			<< serverAddress ipOrName;
			<< ':';
			print: serverAddress port ].
	languageElement text: (label asRopedText glamorousRegularFont foreground: BrGlamorousColors textMarkupColor).
]
