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

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> appendSnippetState: aSnippetState [
	initialSnippetState hasAttributes
		ifFalse: [ 
			"In case the current state is empty we use the give one"
			initialSnippetState := aSnippetState.
			^ self].
	
	initialSnippetState appendState: aSnippetState.
]

{ #category : #execution }
LeContentInsertChildSnippetCommand >> basicExecute [ 
	| newSnippet |
	
	self assert: [ self insertPath notNil ].
	self assert: [ self snippetTypeName notNil ].
	
	newSnippet := self instantiateEmptySnippet.
	self initialSnippetState applyOn: newSnippet.
	
	"Make sure we have create/edit metadata in all cases
	(even in the case when the page being edited is not inside a database)".
	newSnippet
		ensureCreateTimeAndEmailUsingDatabase:  self targetContent database.
	
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

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> createInsertBeforeSiblingUidFor: aSnippet [
	^ LeInsertSnippetBeforeChildUidPosition new
		snippetUid: aSnippet uid
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
		title: 'Initial state';
		priority: 10;
		object: [ self initialSnippetState ];
		view: #gtViewStateAttributesFor:
]

{ #category : #'gt - extensions' }
LeContentInsertChildSnippetCommand >> gtViewInsertPathFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Insert path';
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
			self insertPath: (self 
				createInsertAfterSiblingIndexFor: aSiblingSnippet) asPath ]
		ifNotNil: [
			self insertPath: (self 
				createInsertAfterSiblingUidFor: aSiblingSnippet) asPath ]
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertBefore: aSiblingSnippet [
	self assert: [ self targetContent children includes: aSiblingSnippet ].
	self assert: [ aSiblingSnippet uid notNil ].
	
	self insertPath: (self 
		createInsertBeforeSiblingUidFor: aSiblingSnippet) asPath 
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
LeContentInsertChildSnippetCommand >> newSnippetUid [
	^ (initialSnippetState attributeNamed: #uid) attributeValue
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> snippetTypeName [

	^ snippetTypeName
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> snippetTypeName: aTypeName [

	snippetTypeName := aTypeName
]

{ #category : #'updating - view model' }
LeContentInsertChildSnippetCommand >> updateSnippetsViewModelFor: aSnippetsViewModel withResult: aCommandResult [
	| newSnippetUIModel |		
	newSnippetUIModel := aSnippetsViewModel
		findOrCreateSnippetViewModel: aCommandResult insertedSnippet.
	newSnippetUIModel focusAfterCreation.
	
	aSnippetsViewModel scrollToViewModel: newSnippetUIModel
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> useSnippetUid: anUid [ 
	self assert: [ anUid notNil ].
	
	self initialize: #uid with: anUid
]
