Class {
	#name : #LeJupyterRawNotebook,
	#superclass : #LeJupyterRawEntity,
	#instVars : [
		'name'
	],
	#category : #'Lepiter-Translator-JupyterNotebook'
}

{ #category : #'instance creation' }
LeJupyterRawNotebook class >> fromIpynbFile: aFileReference [
	| rawData |
	rawData := STONJSON fromString: aFileReference contents.
	^ self new
		name: aFileReference basenameWithoutExtension;
		rawData: rawData.
]

{ #category : #importing }
LeJupyterRawNotebook >> createLepiterPage [
	| page |
	page := LePage named: self name.
	self rawCells do: [ :aCell | page addSnippet: aCell createLepiterSnippet ].

	^ page
]

{ #category : #utils }
LeJupyterRawNotebook >> createLepiterPageWithUuids [
	| page |
	page := self createLepiterPage.
	page children do: [ :aSnippet |
		aSnippet uid: UUID new ].
	^ page
]

{ #category : #'gt-extensions' }
LeJupyterRawNotebook >> gtViewLepiterPageFor: aView [
	<gtView>
	^ aView forward 
		title: 'Lepiter page';
		priority: 20;
		object: [ self createLepiterPageWithUuids ];
		view: #gtLiveFor:
]

{ #category : #'gt-extensions' }
LeJupyterRawNotebook >> gtViewRawCellsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Cells';
		priority: 10;
		items: [ self rawCells ];
		column: 'Type' text: #type width: 100;
		column: 'Source' text: #sourceString
]

{ #category : #accessing }
LeJupyterRawNotebook >> name [
	^ name
]

{ #category : #accessing }
LeJupyterRawNotebook >> name: anObject [
	name := anObject
]

{ #category : #printing }
LeJupyterRawNotebook >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self name;
		nextPutAll: ')'
]

{ #category : #accessing }
LeJupyterRawNotebook >> rawCells [
	^ (self rawData at: 'cells') collect: [ :aCellData |
		LeJupyterRawNotebookCell new
			rawData: aCellData ]
]
