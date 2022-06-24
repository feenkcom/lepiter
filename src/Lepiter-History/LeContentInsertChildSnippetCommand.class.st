Class {
	#name : #LeContentInsertChildSnippetCommand,
	#superclass : #LeContentCommand,
	#instVars : [
		'insertPosition',
		'snippetTypeName',
		'initialSnippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeContentInsertChildSnippetCommand class >> commandDescription [ 
	^ 'Insert Child Snippet'
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
		insertPosition: self insertPosition;
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

{ #category : #execution }
LeContentInsertChildSnippetCommand >> execute [ 
	| newSnipet |
	self assert: [ self insertPosition notNil ].
	self assert: [ self snippetTypeName notNil ].
	
	newSnipet := self instantiateEmptySnippet.
	self initialSnippetState applyOn: newSnipet.
	
	insertPosition 
		insertChildSnippet: newSnipet
		intoParent: self targetContent.
		
	^ self createCommandResult
		insertedSnippet: newSnipet;
		undoSpecification: (self targetContent commandBuilder
			removeChildSnippetCommandFor: newSnipet) createCommandSpecification
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
	
	self insertPosition: aCommandSpecification insertPosition.
	self snippetTypeName: aCommandSpecification snippetTypeName.
	self initialSnippetState: aCommandSpecification initialSnippetState.
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertAfter: aSiblingSnippet [
	self assert: [ self targetContent children includes: aSiblingSnippet ].
	
	aSiblingSnippet uid 
		ifNil: [
			self insertPosition: (self createInsertAfterSiblingIndexFor: aSiblingSnippet) ]
		ifNotNil: [
			self insertPosition: (self createInsertAfterSiblingUidFor: aSiblingSnippet) ]
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertFirst [
	self insertPosition: self createInsertAsFirstChildPosition
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertLast [ 
	self insertPosition: self createInsertAsLastChildPosition
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> insertPosition [

	^ insertPosition
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> insertPosition: anObject [

	insertPosition := anObject
]

{ #category : #'execution - utils' }
LeContentInsertChildSnippetCommand >> instantiateEmptySnippet [
	^ (self class environment at: snippetTypeName asSymbol) empty
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
