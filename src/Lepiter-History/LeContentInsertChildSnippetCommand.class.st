Class {
	#name : #LeContentInsertChildSnippetCommand,
	#superclass : #LeContentCommand,
	#instVars : [
		'insertPath',
		'snippetTypeName',
		'initialSnippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeContentInsertChildSnippetCommand class >> commandDescription [ 
	^ 'Insert Child Snippet'
]

{ #category : #execution }
LeContentInsertChildSnippetCommand >> basicExecute [ 
	| newSnippet |
	self assert: [ self insertPath notNil ].
	self assert: [ self snippetTypeName notNil ].
	
	newSnippet := self instantiateEmptySnippet.
	self initialSnippetState applyOn: newSnippet.
	
	insertPath 
		insertChildSnippet: newSnippet
		intoParent: self targetContent.
		
	^ self createCommandResult
		insertedSnippet: newSnippet;
		undoSpecification: (self targetContent commandBuilder
			removeChildSnippetCommandFor: newSnippet) createCommandSpecification
]

{ #category : #'execution - utils' }
LeContentInsertChildSnippetCommand >> createCommandResult [
	^ LeInsertChildSnippetCommandExecutionResult forCommand: self
]

{ #category : #converting }
LeContentInsertChildSnippetCommand >> createCommandSpecification [
	^ LeInsertChildCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetContent uid;
		commandTypeName: self className;
		insertPath: self insertPath;
		snippetTypeName: self snippetTypeName; 
		initialSnippetState: self initialSnippetState
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> createInsertAfterSiblingIndexFor: aSnippet [
	^ LeInsertSnippetAtIndexPosition new
		index: (self targetContent children indexOf: aSnippet) + 1
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> createInsertAfterSiblingUidFor: aSnippet [
	^ LeInsertSnippetAfterChildUidPosition new
		snippetUid: aSnippet uid
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> createInsertAsFirstChildPosition [
	^ LeInsertSnippetFirstChildPosition new
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> createInsertAsLastChildPosition [
	^ LeInsertSnippetLastChildPosition new
]

{ #category : #printing }
LeContentInsertChildSnippetCommand >> descriptionOn: aStream [
	aStream 
		<< 'snippetType: ';
		print: self snippetTypeName
]

{ #category : #'gt - extensions' }
LeContentInsertChildSnippetCommand >> gtViewInitialStateAttributesFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Initial State';
		priority: 10;
		object: [ self initialSnippetState ];
		view: #gtViewStateAttributesFor:
]

{ #category : #'gt - extensions' }
LeContentInsertChildSnippetCommand >> gtViewInsertPathFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Insert Path';
		priority: 20;
		object: [ self insertPath ];
		view: #gtViewPathFor:
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> initialSnippetState [
	^ initialSnippetState
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> initialSnippetState: aSnippetState [
	initialSnippetState := aSnippetState
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> initialize [
	super initialize.
	
	self insertLast.
	initialSnippetState := LeGenericSnippetState new.
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> initialize: anAttributeName with: aValue [
	initialSnippetState attributeNamed: anAttributeName setValue: aValue
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self insertPath: aCommandSpecification insertPath.
	self snippetTypeName: aCommandSpecification snippetTypeName.
	self initialSnippetState: aCommandSpecification initialSnippetState.
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertAfter: aSiblingSnippet [
	self assert: [ self targetContent children includes: aSiblingSnippet ].
	
	aSiblingSnippet uid 
		ifNil: [
			self insertPath: (self createInsertAfterSiblingIndexFor: aSiblingSnippet) asPath ]
		ifNotNil: [
			self insertPath: (self createInsertAfterSiblingUidFor: aSiblingSnippet) asPath ]
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertFirst [
	self insertPath: self createInsertAsFirstChildPosition asPath
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertLast [ 
	self insertPath: self createInsertAsLastChildPosition asPath
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> insertPath [

	^ insertPath
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> insertPath: aSnippetPath [

	insertPath := aSnippetPath
]

{ #category : #'execution - utils' }
LeContentInsertChildSnippetCommand >> instantiateEmptySnippet [
	^ (self class environment at: snippetTypeName asSymbol) empty
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> label [
	^ 'Insert Child Snippet'
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> snippetTypeName [

	^ snippetTypeName
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> snippetTypeName: aTypeName [

	snippetTypeName := aTypeName
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> uid: anUid [ 
	self assert: [ anUid notNil ].
	
	self initialize: #uid with: anUid
]
