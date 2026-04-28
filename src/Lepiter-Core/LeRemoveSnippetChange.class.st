Class {
	#name : #LeRemoveSnippetChange,
	#superclass : #RBRefactoryChange,
	#instVars : [
		'snippet'
	],
	#category : #'Lepiter-Core-Refactoring'
}

{ #category : #'as yet unclassified' }
LeRemoveSnippetChange >> executeNotifying: aBlock [
	| index undo |
	undo := LeAddSnippetChange new.
	undo parent: snippet parent.
	index := snippet parent children indexOf: snippet.
	(index > 0 and: [ index < undo parent childrenCount ])
		ifTrue: [ undo beforeSnippet: (undo parent children at: index + 1) ].
	undo snippet: snippet.
	snippet removeSelf.
	^ undo
]

{ #category : #'as yet unclassified' }
LeRemoveSnippetChange >> gtDiffChange [
	| oldSource newSource |
	newSource := ''.
	oldSource := snippet text asString.
	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: (GtSmaCCDiffSplitter new scannerClass: LeScanner)
]

{ #category : #accessing }
LeRemoveSnippetChange >> snippet [
	^ snippet
]

{ #category : #accessing }
LeRemoveSnippetChange >> snippet: anObject [
	snippet := anObject
]
