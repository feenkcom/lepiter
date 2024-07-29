Class {
	#name : #LeExampleSnippetChange,
	#superclass : #RBRefactoryChange,
	#instVars : [
		'newValue',
		'selector',
		'snippet'
	],
	#category : #'Lepiter-Core-Refactoring'
}

{ #category : #comparing }
LeExampleSnippetChange >> = anObject [
	^ self class = anObject class
		and: [ self snippet == anObject snippet
				and: [ self selector = anObject selector and: [ self newValue = anObject newValue ] ] ]
]

{ #category : #accessing }
LeExampleSnippetChange >> changeString [
	^ 'Example snippet change to ' , selector , ' in '
		, snippet page gtDisplayString
]

{ #category : #'performing-changes' }
LeExampleSnippetChange >> executeNotifying: aBlock [
	| undo |
	undo := self copy.
	undo newValue: (snippet perform: selector).
	snippet perform: (selector , ':') asSymbol with: newValue.
	aBlock value.
	^ undo
]

{ #category : #accessing }
LeExampleSnippetChange >> gtDiffChange [
	^ GtDiffBuilder
		computeDifferencesFrom: selector asString , ': '
				, (snippet perform: selector) gtDisplayString
		to: selector asString , ': ' , newValue gtDisplayString
		using: GtCharacterGroupDiffSplitter words
]

{ #category : #comparing }
LeExampleSnippetChange >> hash [
	^ ((self class hash bitXor: self snippet hash) bitXor: self selector hash)
		bitXor: self newValue hash
]

{ #category : #accessing }
LeExampleSnippetChange >> newValue [
	^ newValue
]

{ #category : #accessing }
LeExampleSnippetChange >> newValue: anObject [
	newValue := anObject
]

{ #category : #private }
LeExampleSnippetChange >> renameChangesForClass: oldClassName to: newClassName [
]

{ #category : #accessing }
LeExampleSnippetChange >> selector [
	^ selector
]

{ #category : #accessing }
LeExampleSnippetChange >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
LeExampleSnippetChange >> snippet [
	^ snippet
]

{ #category : #accessing }
LeExampleSnippetChange >> snippet: anObject [
	snippet := anObject
]
