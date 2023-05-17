Class {
	#name : #LeJupyterRawNotebookCell,
	#superclass : #LeJupyterRawEntity,
	#category : #'Lepiter-Translator-JupyterNotebook'
}

{ #category : #importing }
LeJupyterRawNotebookCell >> createCodeSnippet [
	^ LePythonSnippet code: self sourceString
]

{ #category : #importing }
LeJupyterRawNotebookCell >> createLepiterSnippet [
	self type = 'markdown' 
		ifTrue: [ ^ self createTextSnippet ].
	self type = 'code' 
		ifTrue: [ ^ self createCodeSnippet ].
	^ self createUnknownSnippet.
]

{ #category : #importing }
LeJupyterRawNotebookCell >> createTextSnippet [
	^ LeTextSnippet string: self sourceString
]

{ #category : #accessing }
LeJupyterRawNotebookCell >> gtViewLepiterSnippetFor: aView [
	<gtView>
	^ aView forward 
		title: 'Lepiter snippet';
		priority: 20;
		object: [ self createLepiterSnippet ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeJupyterRawNotebookCell >> gtViewOutputsFor: aView [
	<gtView>
	^ aView list
		title: 'Outputs';
		priority: 18;
		items: [ self outputs ]
]

{ #category : #accessing }
LeJupyterRawNotebookCell >> gtViewSourceFor: aView [
	<gtView>
	^ aView text
		title: 'Source';
		priority: 10;
		text: [ self sourceString]
]

{ #category : #accessing }
LeJupyterRawNotebookCell >> outputs [
	^ self rawData at: 'outputs'
]

{ #category : #accessing }
LeJupyterRawNotebookCell >> sourceString [
	| source |
	source := self rawData at: 'source'.
	source isArray ifTrue: [ 
		^ String streamContents: [ :aStream | 
			source asStringOn: aStream delimiter: '' ] ].
	^ source
]

{ #category : #accessing }
LeJupyterRawNotebookCell >> type [
	^ self rawData at: 'cell_type'
]
