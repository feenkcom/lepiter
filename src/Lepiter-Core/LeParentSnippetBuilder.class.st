Class {
	#name : #LeParentSnippetBuilder,
	#superclass : #LeSnippetBuilder,
	#instVars : [
		'database',
		'parent'
	],
	#category : 'Lepiter-Core-Builders'
}

{ #category : #'api - building' }
LeParentSnippetBuilder >> add [
	<return: #LeTextSnippet>
	^ self buildDo: [ :aNewBlock | self parent addSnippet: aNewBlock ]
]

{ #category : #'api - building' }
LeParentSnippetBuilder >> addAfter: anExistingSnippet [
	<return: #LeTextSnippet>
	^ self buildDo: [ :aNewSnippet |
		self parent addSnippet: aNewSnippet after: anExistingSnippet ].
]

{ #category : #'api - building' }
LeParentSnippetBuilder >> addBefore: anExistingSnippet [
	<return: #LeTextSnippet>
	^ self buildDo: [ :aNewSnippet |
		self parent addSnippet: aNewSnippet before: anExistingSnippet ].
]

{ #category : #'private - building' }
LeParentSnippetBuilder >> buildDo: aBlock [
	<return: #LeSnippet>
	| aNewBlock |
	aNewBlock := self build.
	aBlock value: aNewBlock.
	
	self 
		assert: [ (aNewBlock isKindOf: LeSnippet) ]
		description: [ 'Newly created block must be kind of ', LeSnippet name, ', but is ', aNewBlock class ].
	
	^ aNewBlock
]

{ #category : #'api - accessing' }
LeParentSnippetBuilder >> database [
	^ database
]

{ #category : #'api - accessing' }
LeParentSnippetBuilder >> database: aDatabase [

	database := aDatabase.

]

{ #category : #'private - testing' }
LeParentSnippetBuilder >> hasDatabase [
	^ self database isDatabase
]

{ #category : #initialization }
LeParentSnippetBuilder >> initialize [
	super initialize.
	database := LeDatabase null.

]

{ #category : #'api - accessing' }
LeParentSnippetBuilder >> parent [
	^ parent
]

{ #category : #'api - accessing' }
LeParentSnippetBuilder >> parent: anObject [
	parent := anObject
]
