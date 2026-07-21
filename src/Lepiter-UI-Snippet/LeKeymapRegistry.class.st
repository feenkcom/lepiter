Class {
	#name : #LeKeymapRegistry,
	#superclass : #BlKeymapRegistryCategory,
	#category : 'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeKeymapRegistry class >> registryLabel [
	^'Lepiter'
]

{ #category : #'accessing - defaults' }
LeKeymapRegistry >> defaultMoveSnippetUpShortcutCombination [
	^ BlKeyCombinationBuilder new alt shift arrowUp build
]

{ #category : #'accessing - defaults' }
LeKeymapRegistry >> defaultSplitSnippetShortcutCombination [
	^ BlKeyCombination builder primary return build
]

{ #category : #initialize }
LeKeymapRegistry >> initializeCombinations [
	super initializeCombinations.
	
	self 
		initializeShortcut: LeShortcutIds default moveSnippetUpShortcutId 
		with: self defaultMoveSnippetUpShortcutCombination.
		
	self 
		initializeShortcut: LeShortcutIds default splitSnippetShortcutId 
		with: self defaultSplitSnippetShortcutCombination
]
