Class {
	#name : #LeKeymapRegistry,
	#superclass : #BlShortcutKeymapRegistryCategory,
	#category : 'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeKeymapRegistry class >> registryLabel [
	^'Lepiter'
]

{ #category : #defaults }
LeKeymapRegistry >> defaultDeleteNextShortcutCombination [
	^ BlKeyCombinationBuilder new delete build
]

{ #category : #defaults }
LeKeymapRegistry >> defaultDeletePreviousShortcutCombination [
	^ BlKeyCombination builder backspace build
]

{ #category : #defaults }
LeKeymapRegistry >> defaultIndentSnippetShortcutCombination [
	^ (BlKeyCombinationBuilder new primary key: BlKeyboardKey rightBracket) build
]

{ #category : #defaults }
LeKeymapRegistry >> defaultMoveSnippetDownShortcutCombination [
	^ BlKeyCombinationBuilder new alt shift arrowDown build
]

{ #category : #'accessing - defaults' }
LeKeymapRegistry >> defaultMoveSnippetUpShortcutCombination [
	^ BlKeyCombinationBuilder new alt shift arrowUp build
]

{ #category : #defaults }
LeKeymapRegistry >> defaultRenameSnippetShortcutCombination [
	^ BlKeyCombinationBuilder new primary r build
]

{ #category : #defaults }
LeKeymapRegistry >> defaultSecondaryNewLineShortcutCombination [
	^ BlKeyCombination builder secondary return build
]

{ #category : #'accessing - defaults' }
LeKeymapRegistry >> defaultSplitSnippetShortcutCombination [
	^ BlKeyCombination builder primary return build
]

{ #category : #defaults }
LeKeymapRegistry >> defaultUnindentSnippetShortcutCombination [
	^ (BlKeyCombinationBuilder new primary key: BlKeyboardKey leftBracket) build
]

{ #category : #initialization }
LeKeymapRegistry >> initializeCombinations [
	super initializeCombinations.
	
	self 
		initializeShortcut: LeShortcutIds default moveSnippetUpShortcutId 
		with: self defaultMoveSnippetUpShortcutCombination.
		
	self 
		initializeShortcut: LeShortcutIds default splitSnippetShortcutId 
		with: self defaultSplitSnippetShortcutCombination.
		
	self 
		initializeShortcut: LeShortcutIds default deleteNextShortcutId 
		with: self defaultDeleteNextShortcutCombination.
		
	self 
		initializeShortcut: LeShortcutIds default deletePreviousShortcutId 
		with: self defaultDeletePreviousShortcutCombination.
		
	self 
		initializeShortcut: LeShortcutIds default indentSnippetShortcutId 
		with: self defaultIndentSnippetShortcutCombination.
		
	self 
		initializeShortcut: LeShortcutIds default moveSnippetDownShortcutId 
		with: self defaultMoveSnippetDownShortcutCombination.
		
	self 
		initializeShortcut: LeShortcutIds default renameSnippetShortcutId 
		with: self defaultRenameSnippetShortcutCombination.
		
	self 
		initializeShortcut: LeShortcutIds default secondaryNewLineShortcutId 
		with: self defaultSecondaryNewLineShortcutCombination.
		
	self 
		initializeShortcut: LeShortcutIds default unindentSnippetShortcutId 
		with: self defaultUnindentSnippetShortcutCombination
]
