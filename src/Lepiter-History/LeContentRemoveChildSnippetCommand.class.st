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

{ #category : #execution }
LeContentRemoveChildSnippetCommand >> basicExecute [ 
	^ self withUndoExecute: [ 
		self targetContent removeSnippet: self childSnippet ]
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
LeContentRemoveChildSnippetCommand >> computeChildPathFor: aChildSnippet inParent: aParentSnippet forRoot: aRootContent [
	| insertPath currentParent |
	
	insertPath := LeInsertSnippetPath new.
	
	"The insert position of the child is relative to its parent snippet."
	insertPath insertPosition: (self
		computeChildPositionFor: aChildSnippet
		inParent: aParentSnippet).
	
	"We also need the full path from the root content."
	currentParent := aParentSnippet.
	[ currentParent uid = aRootContent uid ] whileFalse: [ 
		insertPath insertParent: currentParent.
		currentParent := currentParent parent  ].
	
	^ insertPath
	
]

{ #category : #'execution - utils' }
LeContentRemoveChildSnippetCommand >> computeChildPositionFor: aChildSnippet inParent: aParentSnippet [
	| indexOfChild beforeSnippet |
	
	indexOfChild := aParentSnippet children indexOf: aChildSnippet.
	self assert: [ indexOfChild > 0 ].
	
	indexOfChild = 1 
		ifTrue: [ ^ LeInsertSnippetFirstChildPosition new ].
	
	beforeSnippet := aParentSnippet children at: indexOfChild - 1.
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
LeContentRemoveChildSnippetCommand >> createInsertChildSnippetCommandFor: aChildSnippet inParent: aParentSnippet forRoot: aRootContent [
	^ aRootContent commandBuilder insertChildSnippetCommand
		snippetTypeName: aChildSnippet className;
		insertPath: (self 
			computeChildPathFor: aChildSnippet 
			inParent: aParentSnippet
			forRoot: aRootContent); 
		initialSnippetState: (self extractSnippetStateFor: aChildSnippet)
]

{ #category : #'execution - utils' }
LeContentRemoveChildSnippetCommand >> createInsertChildStructureCommandFor: aChildSnippet inParent: aParentSnippet forRoot: aRootContent [
	
	aChildSnippet hasChildren ifFalse: [
		^ self 
			createInsertChildSnippetCommandFor: aChildSnippet
			inParent: aParentSnippet
			forRoot: aRootContent ].
	
	^ self 
		createInsertChildStructureCompositeCommandFor: aChildSnippet 
		inParent: aParentSnippet 
		forRoot: aRootContent
	
]

{ #category : #'execution - utils' }
LeContentRemoveChildSnippetCommand >> createInsertChildStructureCompositeCommandFor: aChildSnippet inParent: aParentSnippet forRoot: aRootContent [
	| addSnippetCommand addChildrenCommand |
	
	addSnippetCommand := aRootContent commandBuilder compositeCommand
		label: 'Insert snippet ', aChildSnippet uid printString.
	addSnippetCommand addSubcommand: (self 
		createInsertChildSnippetCommandFor: aChildSnippet
		inParent: aParentSnippet
		forRoot: aRootContent).
	
	addChildrenCommand := aRootContent commandBuilder compositeCommand
			label: 'Insert children for snippet ', aChildSnippet uid printString.
	aChildSnippet childrenDo: [ :anotherChildSnippet | 
		addChildrenCommand addSubcommand: (self 
			createInsertChildStructureCommandFor: anotherChildSnippet
			inParent: anotherChildSnippet parent
			forRoot: aRootContent) ].
	addSnippetCommand addSubcommand: addChildrenCommand.
	
	^ addSnippetCommand
	
]

{ #category : #'execution - utils' }
LeContentRemoveChildSnippetCommand >> createUndoCommand [
	^ self 
		createInsertChildStructureCommandFor: self childSnippet 
		inParent: self targetContent 
		forRoot: self targetContent 
]

{ #category : #'execution - utils' }
LeContentRemoveChildSnippetCommand >> createUndoCommandSpecification [
	^ self createUndoCommand createCommandSpecification
]

{ #category : #printing }
LeContentRemoveChildSnippetCommand >> descriptionOn: aStream [
	aStream 
		<< 'childSnippet: ';
		print: self childSnippet uid
]

{ #category : #'execution - utils' }
LeContentRemoveChildSnippetCommand >> extractSnippetStateFor: aSnippet [
	^ LeGenericSnippetState fromSnippet: aSnippet
]

{ #category : #initialization }
LeContentRemoveChildSnippetCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self childSnippet: (aBuilder 
		locateContentWithUid: aCommandSpecification childUid)
]
