Class {
	#name : #LeContentInsertChildSnippetTreeCommand,
	#superclass : #LeContentInsertChildSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeContentInsertChildSnippetTreeCommand >> basicExecute [
	| result |
	
	result := super basicExecute.
	self executeSubcommandsWithResult: result.
	^ result.
]

{ #category : #execution }
LeContentInsertChildSnippetTreeCommand >> executeSubcommandsWithResult: aResult [

	^ self subcommands collect: [ :aSubcommand | 
		aSubcommand targetContent: aResult insertedSnippet.
		aSubcommand execute ]
]

{ #category : #initialization }
LeContentInsertChildSnippetTreeCommand >> forSnippet: aSourceSnippet [

	self snippetTypeName: aSourceSnippet class name.
	self initialSnippetState appendState: aSourceSnippet extractUpdatableState.

	aSourceSnippet children do: [ :childSnippet |
		self addSubcommand: (aSourceSnippet commandBuilder  insertChildSnippetTreeCommand forSnippet: childSnippet) ].
]
