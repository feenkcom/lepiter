Class {
	#name : #LeBasicEditSnippetCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'snippetState',
		'viewState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeBasicEditSnippetCommand >> basicExecute [
	^ self withUndoExecute: [ 
		self snippetState applyOn: self targetSnippet ]
]

{ #category : #'gt - extensions' }
LeBasicEditSnippetCommand >> colorForAttributeChange: anArray [
	^ anArray second = anArray third 
		ifTrue: [ Color green muchDarker ]
		ifFalse: [ Color red muchDarker ]
]

{ #category : #converting }
LeBasicEditSnippetCommand >> createCommandSpecification [
	^ LeEditSnippetCommandSpecification new
		contentUid: self targetSnippetUid;
		commandTypeName: self className;
		snippetState: self snippetState;
		viewState: self viewState
]

{ #category : #'execution - utils' }
LeBasicEditSnippetCommand >> createUndoCommand [
	^ self targetSnippet commandBuilder
		undoSnippetStateCommandBasedOnState: self snippetState
]

{ #category : #'execution - utils' }
LeBasicEditSnippetCommand >> createUndoCommandSpecification [
	^ self createUndoCommand createCommandSpecification
]

{ #category : #'gt - extensions' }
LeBasicEditSnippetCommand >> gtViewLiveDiffFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Current state diff';
		items: [ self snippetState attributes
			collect: [ :anAttribute |
				{ 
					anAttribute . 
					anAttribute attributeValue.
					anAttribute extractValueFromSnippet: self targetContent } ] ];
		column: 'Attribute' text: [ :array | 
			array first attributeName asRopedText
				foreground: (self colorForAttributeChange: array) ];
		column: 'New Value' text: [ :array | array second ];
		column: 'Previous Value' text: [ :array | array third ]
]

{ #category : #'gt - extensions' }
LeBasicEditSnippetCommand >> gtViewNewStateAttributesFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'New state';
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
	
	self snippetState: aCommandSpecification snippetState.
	self viewState: aCommandSpecification viewState.
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

{ #category : #'updating - view model' }
LeBasicEditSnippetCommand >> updateSnippetsViewModelFor: aSnippetsViewModel withResult: aCommandResult [		
	| snippetUIModel |		
	snippetUIModel := aSnippetsViewModel findSnippetViewModel: self targetContent.
	snippetUIModel focused: true.
	
	self viewState ifNotNil: [ :aViewState |
		aViewState updateSnippetViewModelFor: snippetUIModel ].
]

{ #category : #accessing }
LeBasicEditSnippetCommand >> viewState [
	^ viewState
]

{ #category : #accessing }
LeBasicEditSnippetCommand >> viewState: aSnippetViewState [
	viewState := aSnippetViewState
]
