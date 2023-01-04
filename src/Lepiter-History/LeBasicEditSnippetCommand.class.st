Class {
	#name : #LeBasicEditSnippetCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'snippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeBasicEditSnippetCommand >> basicExecute [
	^ self withUndoExecute: [ 
		self snippetState applyOn: self targetSnippet ]
]

{ #category : #converting }
LeBasicEditSnippetCommand >> createCommandSpecification [
	^ LeEditSnippetCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetSnippetUid;
		commandTypeName: self className;
		snippetState: self snippetState
]

{ #category : #'execution - utils' }
LeBasicEditSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder editSnippetCommand
		snippetState: self extractCurrentSnippetState
]

{ #category : #'execution - utils' }
LeBasicEditSnippetCommand >> createUndoCommandSpecification [
	^ self createUndoCommand createCommandSpecification
]

{ #category : #'execution - utils' }
LeBasicEditSnippetCommand >> extractCurrentSnippetState [
	^ LeGenericSnippetState 
		fromSnippet: self targetSnippet 
		basedOn: self snippetState
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

{ #category : #initialization }
LeBasicEditSnippetCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self snippetState: aCommandSpecification snippetState
]

{ #category : #accessing }
LeBasicEditSnippetCommand >> label [
	^ 'Edit Snippet'
]

{ #category : #accessing }
LeBasicEditSnippetCommand >> snippetState [

	^ snippetState
]

{ #category : #accessing }
LeBasicEditSnippetCommand >> snippetState: aSnippetState [

	snippetState := aSnippetState
]
