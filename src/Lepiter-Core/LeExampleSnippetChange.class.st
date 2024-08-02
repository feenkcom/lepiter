Class {
	#name : #LeExampleSnippetChange,
	#superclass : #RBRefactoryChange,
	#instVars : [
		'snippet',
		'updates'
	],
	#category : #'Lepiter-Core-Refactoring'
}

{ #category : #comparing }
LeExampleSnippetChange >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	(self class = anObject class and: [ self snippet == anObject snippet ])
		ifFalse: [ ^ false ].
	updates size = anObject updates size ifFalse: [ ^ false ].
	anObject updates
		keysAndValuesDo: [ :key :value | (updates at: key ifAbsent: [ ^ false ]) = value ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
LeExampleSnippetChange >> change: aSymbol to: anObject [
	updates at: aSymbol put: anObject
]

{ #category : #accessing }
LeExampleSnippetChange >> changeString [
	^ 'Example snippet change in ' , snippet page gtDisplayString
]

{ #category : #'performing-changes' }
LeExampleSnippetChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.
	updates
		keysAndValuesDo: [ :key :value | 
			undo change: key to: (snippet perform: key).
			snippet perform: (key , ':') asSymbol with: value ].
	aBlock value.
	^ undo
]

{ #category : #accessing }
LeExampleSnippetChange >> gtDiffChange [
	^ GtDiffBuilder
		computeDifferencesFrom: snippet asAnnotationString
		to: (snippet asAnnotationStringWithChanges: updates)
		using: GtCharacterGroupDiffSplitter words
]

{ #category : #accessing }
LeExampleSnippetChange >> gtDiffViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Diff';
		object: [ self gtDiffChange ];
		view: #gtTextView:
]

{ #category : #accessing }
LeExampleSnippetChange >> hasChanges [
	^ updates notEmpty
]

{ #category : #comparing }
LeExampleSnippetChange >> hash [
	^ (self class hash bitXor: self snippet hash) bitXor: updates hash
]

{ #category : #accessing }
LeExampleSnippetChange >> initialize [
	super initialize.
	updates := Dictionary new
]

{ #category : #accessing }
LeExampleSnippetChange >> postCopy [
	super postCopy.
	updates := updates copy
]

{ #category : #private }
LeExampleSnippetChange >> renameChangesForClass: oldClassName to: newClassName [
]

{ #category : #accessing }
LeExampleSnippetChange >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExampleSnippetChange >> snippet: anObject [
	snippet := anObject
]

{ #category : #accessing }
LeExampleSnippetChange >> updates [
	^ updates
]

{ #category : #accessing }
LeExampleSnippetChange >> updates: anObject [
	updates := anObject
]
