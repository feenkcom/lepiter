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
	serverAddress := self serverStrategy applicationSettings serverSocketAddress.
	label := String
			streamContents: [ :stream | 
				stream
					<< 'Python @ ';
					<< serverAddress ipOrName;
					<< ':';
					print: serverAddress port ].
	languageElement
		text: (label asRopedText glamorousRegularFont
				foreground: BrGlamorousColors textMarkupColor)
]
