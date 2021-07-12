Class {
	#name : 'LeGemStoneSnippetElement',
	#superclass : 'LeExternalEvaluatedSnippetElement',
	#category : 'Lepiter-Snippet-GemStone-Snippet'
}

{ #category : 'api - snippet view model' }
LeGemStoneSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self updateLanguageLabel.
	self coder
		applicationStrategy: self serverStrategy;
		pharoBindings: self snippetViewModel snippetBindings.
]

{ #category : 'accessing' }
LeGemStoneSnippetElement >> serverStrategy [

	^ serverStrategy ifNil: 
		[ serverStrategy := LeGemStoneApplicationGlobalStrategy new content: self ].
]

{ #category : 'private' }
LeGemStoneSnippetElement >> updateLanguageLabel [
	| settings label default |

	settings := self serverStrategy applicationSettings.
	default := GtGemStoneClient new.
	label := String streamContents: [ :stream |
		stream
			<< 'GemStone @ ';
			<< (settings host ifNil: [ default host ]);
			<< ':';
			print: (settings port ifNil: [ default port ]) ].
	languageLabel text: (label asRopedText glamorousRegularFont foreground: BrGlamorousColors textMarkupColor).

]
