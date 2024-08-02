Class {
	#name : #LeSnippetChange,
	#superclass : #RBRefactoryChange,
	#instVars : [
		'snippet',
		'newSource'
	],
	#category : #'Lepiter-Core-Refactoring'
}

{ #category : #comparing }
LeSnippetChange >> = anObject [
	^ self class = anObject class
		and: [ self snippet == anObject snippet and: [ self newSource = anObject newSource ] ]
]

{ #category : #accessing }
LeSnippetChange >> changeString [
	^ 'Snippet change in ' , snippet page gtDisplayString
]

{ #category : #'performing-changes' }
LeSnippetChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.
	undo newSource: snippet string.
	snippet updateString: newSource.
	aBlock value.
	^ undo
]

{ #category : #accessing }
LeSnippetChange >> gtDiffChange [
	^ GtDiffBuilder
		computeDifferencesFrom: snippet string
		to: newSource
		using: GtCharacterGroupDiffSplitter words
]

{ #category : #accessing }
LeSnippetChange >> gtDiffViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Diff';
		object: [ self gtDiffChange ];
		view: #gtTextView:
]

{ #category : #comparing }
LeSnippetChange >> hash [
	^ self snippet hash bitXor: self newSource hash
]

{ #category : #accessing }
LeSnippetChange >> newSource [
	^ newSource
]

{ #category : #accessing }
LeSnippetChange >> newSource: anObject [
	newSource := anObject
]

{ #category : #private }
LeSnippetChange >> renameChangesForClass: oldClassName to: newClassName [
]

{ #category : #accessing }
LeSnippetChange >> snippet [
	^ snippet
]

{ #category : #accessing }
LeSnippetChange >> snippet: anObject [
	snippet := anObject
]
