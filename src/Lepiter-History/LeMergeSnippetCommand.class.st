Class {
	#name : #LeMergeSnippetCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'sourceSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #private }
LeMergeSnippetCommand class >> merge: aSnippet with: anotherSnippet [
	^ (self forSnippet: aSnippet)
		mergeContentOf: anotherSnippet
]

{ #category : #initialization }
LeMergeSnippetCommand >> addDeleteSnippetCommandFor: aSourceSnippet [ 

	self addSubcommand: (aSourceSnippet parent commandBuilder 
		removeChildSnippetCommandFor: aSourceSnippet)
]

{ #category : #initialization }
LeMergeSnippetCommand >> addEditContentCommandFor: aSourceSnippet [ 
	
	self addSubcommand: (self targetSnippet commandBuilder mergeSnippetContentCommand
		sourceSnippet: aSourceSnippet)
]

{ #category : #initialization }
LeMergeSnippetCommand >> addMoveChildrenCommandFor: aSourceSnippet [ 
	
	self addSubcommand: (self targetContent commandBuilder 
		transferChildrenCommandFrom: aSourceSnippet)
]

{ #category : #execution }
LeMergeSnippetCommand >> basicExecute [ 
	^ self withUndoExecute: [ 
		self executeSubcommands ]
]

{ #category : #'execution - utils' }
LeMergeSnippetCommand >> createCommandSpecification [
	^ LeGenericCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetContent uid;
		commandTypeName: self className;
		attributeAt: #sourceSnippetUid put: self sourceSnippet uid;
		yourself
]

{ #category : #'execution - utils' }
LeMergeSnippetCommand >> createUndoCommandSpecification [
	| specification | 
	specification := LeCompositeCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetContent uid;
		commandTypeName: self className;
		label: 'Undo Merge'.
	
	self subcommands do: [ :aSubcommand |
		 specification 
		 	addSubcommandSpecification: aSubcommand createUndoCommandSpecification ].
	
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
