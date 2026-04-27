Class {
	#name : #LeAddSnippetChange,
	#superclass : #RBRefactoryChange,
	#instVars : [
		'snippet',
		'beforeSnippet',
		'parent'
	],
	#category : #'Lepiter-Core-Refactoring'
}

{ #category : #'instance creation' }
LeAddSnippetChange class >> code: aString in: aParent [
	^ self new
		parent: aParent;
		snippet: (LePharoSnippet new code: aString)
]

{ #category : #'instance creation' }
LeAddSnippetChange class >> code: aString in: aParent before: aSnippet [
	^ (self code: aString in: aParent) beforeSnippet: aSnippet
]

{ #category : #'instance creation' }
LeAddSnippetChange class >> text: aString in: aParent [
	^ self new
		parent: aParent;
		snippet: (LeTextSnippet new string: aString)
]

{ #category : #'instance creation' }
LeAddSnippetChange class >> text: aString in: aParent before: aSnippet [
	^ (self text: aString in: aParent) beforeSnippet: aSnippet
]

{ #category : #accessing }
LeAddSnippetChange >> beforeSnippet [
	^ beforeSnippet
]

{ #category : #accessing }
LeAddSnippetChange >> beforeSnippet: anObject [
	beforeSnippet := anObject
]

{ #category : #private }
LeAddSnippetChange >> executeNotifying: aBlock [
	self beforeSnippet
		ifNil: [ self parent addSnippet: self snippet ]
		ifNotNil: [ :before | self parent addSnippet: self snippet before: before ].
	^ LeRemoveSnippetChange new snippet: self snippet
]

{ #category : #accessing }
LeAddSnippetChange >> gtDiffChange [
	| oldSource newSource |
	oldSource := ''.
	newSource := snippet text asString.
	^ GtDiffBuilder
		computeDifferencesFrom: oldSource
		to: newSource
		using: (GtSmaCCDiffSplitter new scannerClass: LeScanner)
]

{ #category : #accessing }
LeAddSnippetChange >> parent [
	^ parent
]

{ #category : #accessing }
LeAddSnippetChange >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
LeAddSnippetChange >> snippet [
	^ snippet
]

{ #category : #accessing }
LeAddSnippetChange >> snippet: anObject [
	snippet := anObject
]
