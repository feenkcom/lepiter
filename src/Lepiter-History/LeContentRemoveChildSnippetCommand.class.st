Class {
	#name : #LeContentRemoveChildSnippetCommand,
	#superclass : #LeContentCommand,
	#instVars : [
		'childSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeContentRemoveChildSnippetCommand class >> commandDescription [ 
	^ 'Remove Child Snippet'
]

{ #category : #accessing }
LeContentRemoveChildSnippetCommand >> childSnippet [

	^ childSnippet
]

{ #category : #accessing }
LeContentRemoveChildSnippetCommand >> childSnippet: anObject [

	childSnippet := anObject
]

{ #category : #'execution - utils' }
LeContentRemoveChildSnippetCommand >> computeChildPosition [
	| indexOfChild beforeSnippet |
	indexOfChild := self targetContent children indexOf: self childSnippet.
	self assert: [ indexOfChild > 0 ].
	
	indexOfChild = 1 
		ifTrue: [ ^ LeInsertSnippetFirstChildPosition new ].
	
	beforeSnippet := self targetContent children at: indexOfChild - 1.
	^ LeInsertSnippetAfterChildUidPosition new
		snippetUid: beforeSnippet uid
	
]

{ #category : #converting }
LeContentRemoveChildSnippetCommand >> createCommandSpecification [
	^ LeRemoveChildSnippetCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetContent uid;
		commandTypeName: self className;
		childUid: self childSnippet uid
]

{ #category : #'execution - utils' }
LeContentRemoveChildSnippetCommand >> createUndoCommandSpecification [
	| undoCommand |
	undoCommand := self targetContent commandBuilder insertChildSnippetCommand
		snippetTypeName: self targetContent className;
		insertPosition: self computeChildPosition; 
		initialSnippetState: self extractChildState.
		
	^ undoCommand createCommandSpecification
]

{ #category : #printing }
LeContentRemoveChildSnippetCommand >> descriptionOn: aStream [
	aStream 
		<< 'childSnippet: ';
		print: self childSnippet uid
]

{ #category : #execution }
LeContentRemoveChildSnippetCommand >> execute [ 
	^ self withUndoExecute: [ 
		self targetContent removeSnippet: self childSnippet ]
]

{ #category : #'execution - utils' }
LeContentRemoveChildSnippetCommand >> extractChildState [
	^ LeGenericSnippetState fromSnippet: self childSnippet
]

{ #category : #initialization }
LeContentRemoveChildSnippetCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self childSnippet: (aBuilder 
		locateContentWithUid: aCommandSpecification childUid)
]
