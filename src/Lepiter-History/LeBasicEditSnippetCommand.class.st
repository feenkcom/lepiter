Class {
	#name : #LeBasicEditSnippetCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'snippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #'execution - utils' }
LeBasicEditSnippetCommand >> createCommandResult [
	^ LeEditSnippetCommandExecutionResult forCommand: self
]

{ #category : #converting }
LeBasicEditSnippetCommand >> createCommandSpecification [
	^ LeEditSnippetCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetSnippetUid;
		snippetState: self snippetState
]

{ #category : #'execution - utils' }
LeBasicEditSnippetCommand >> createUndoCommandSpecification [
	| undoCommand |
	undoCommand := self targetContent commandBuilder editSnippetCommand
		snippetState: self extractCurrentSnippetState.
		
	^ undoCommand createCommandSpecification
]

{ #category : #execution }
LeBasicEditSnippetCommand >> execute [
	^ self withUndoExecute: [ 
		self snippetState applyOn: self targetSnippet ]
	
]

{ #category : #'execution - utils' }
LeBasicEditSnippetCommand >> extractCurrentSnippetState [
	^ LeGenericSnippetState fromSnippet: self targetSnippet
]

{ #category : #'gt - extensions' }
LeBasicEditSnippetCommand >> gtViewLiveDiffFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Current State Diff';
		items: [ self snippetState attributeNames
			collect: [ :anAttribute |
				{ 
					anAttribute . 
					self snippetState valueForAttributeNamed: anAttribute.
					self targetContent perform: anAttribute } ] ];
		column: 'Attribute' text: [ :array | array first ];
		column: 'New Value' text: [ :array | array second ];
		column: 'Previous Value' text: [ :array | array third ]
]

{ #category : #'gt - extensions' }
LeBasicEditSnippetCommand >> gtViewNewStateAttributesFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'New State';
		object: [ snippetState ];
		view: #gtViewStateAttributesFor:
]

{ #category : #initialization }
LeBasicEditSnippetCommand >> initialize [ 
	super initialize.
	
	snippetState := LeGenericSnippetState new.
]

{ #category : #accessing }
LeBasicEditSnippetCommand >> snippetState [

	^ snippetState
]

{ #category : #accessing }
LeBasicEditSnippetCommand >> snippetState: aSnippetState [

	snippetState := aSnippetState
]
