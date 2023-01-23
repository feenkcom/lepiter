Class {
	#name : #LeMergeSnippetCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'sourceSnippet',
		'deleteSnippetCommand'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #'instance creation' }
LeMergeSnippetCommand class >> merge: aSnippet with: anotherSnippet [
	^ (self forSnippet: aSnippet)
		mergeContentOf: anotherSnippet
]

{ #category : #initialization }
LeMergeSnippetCommand >> addDeleteSnippetCommandFor: aSourceSnippet [ 
	deleteSnippetCommand := aSourceSnippet parent commandBuilder 
		removeChildSnippetCommandFor: aSourceSnippet.
	
	self addSubcommand: deleteSnippetCommand
]

{ #category : #initialization }
LeMergeSnippetCommand >> addEditContentCommandFor: aSourceSnippet [ 
	
	self addSubcommand: (self targetSnippet commandBuilder appendSnippetContentCommand
		sourceSnippet: aSourceSnippet)
]

{ #category : #initialization }
LeMergeSnippetCommand >> addMoveChildrenCommandFor: aSourceSnippet [ 
	
	self addSubcommand: (self targetContent 
		commandBuilder transferChildrenFromSnippetCommand
			sourceSnippetUid: aSourceSnippet uid)
]

{ #category : #execution }
LeMergeSnippetCommand >> basicExecute [ 
	^ self withUndoExecute: [ 
		self executeSubcommands ]
]

{ #category : #'execution - utils' }
LeMergeSnippetCommand >> createCommandSpecification [
	^ LeGenericCommandSpecification new 
		contentUid: self targetContent uid;
		commandTypeName: self className;
		attributeAt: #sourceSnippetUid put: self sourceSnippet uid;
		yourself
]

{ #category : #'execution - utils' }
LeMergeSnippetCommand >> createUndoCommandSpecification [
	| specification | 
	
	specification := LeContentCompositeCommandSpecification new 
		contentUid: self targetContent uid;
		commandTypeName: LeContentCompositeCommand name;
		label: 'Undo Merge'.
	
	specification 
		addSubcommandSpecification: deleteSnippetCommand 
			createUndoAsLeafCommand createCommandSpecification.
	
	(self subcommands copyWithout: deleteSnippetCommand) reversed 
		do: [ :aSubcommand |
			 specification 
		 		addSubcommandSpecification: aSubcommand 
		 			createUndoCommandSpecification ].
	
	^ specification
]

{ #category : #'gt - extensions' }
LeMergeSnippetCommand >> gtViewSubcommandsFor: aView [ 
	<gtView>
	
	^ aView list 
		title: 'Subcommands';
		items: [ self subcommands ]
]

{ #category : #initialization }
LeMergeSnippetCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self mergeContentOf: (aBuilder 
		locateContentWithUid: (aCommandSpecification 
			attributeAt: #sourceSnippetUid))
]

{ #category : #accessing }
LeMergeSnippetCommand >> label [
	^ 'Merge Snippet'
]

{ #category : #initialization }
LeMergeSnippetCommand >> mergeContentOf: aSourceSnippet [
	self assert: [ subcommands isEmpty ].
	self assert: [ aSourceSnippet class = self targetSnippet class ].
	
	self sourceSnippet: aSourceSnippet.
	
	self addEditContentCommandFor: aSourceSnippet.
	aSourceSnippet hasChildren 
		ifTrue: [ self addMoveChildrenCommandFor: aSourceSnippet ].
	self addDeleteSnippetCommandFor: aSourceSnippet.
]

{ #category : #accessing }
LeMergeSnippetCommand >> sourceSnippet [
	^ sourceSnippet
]

{ #category : #accessing }
LeMergeSnippetCommand >> sourceSnippet: aSnippet [
	sourceSnippet := aSnippet
]

{ #category : #'updating - view model' }
LeMergeSnippetCommand >> updateSnippetsViewModelFor: aSnippetsViewModel withResult: aCommandResult [
	| newSnippetUIModel |		
	newSnippetUIModel := aSnippetsViewModel
		findOrCreateSnippetViewModel: self targetSnippet.
	newSnippetUIModel 
		focused: true;
		moveCursorAt: self sourceSnippet text size.
	
	aSnippetsViewModel scrollToViewModel: newSnippetUIModel
]
