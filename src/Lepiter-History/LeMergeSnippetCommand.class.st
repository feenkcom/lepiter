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

	self addSubcommand: (self targetSnippet commandBuilder 
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
	self executeSubcommands
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
LeMergeSnippetCommand >> sourceSnippet: aSnippet [
	sourceSnippet := aSnippet
]
