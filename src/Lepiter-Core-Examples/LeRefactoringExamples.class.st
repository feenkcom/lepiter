Class {
	#name : #LeRefactoringExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Refactoring'
}

{ #category : #methods }
LeRefactoringExamples >> renameInstVarNamedMethod [
	<gtExample>
	<return: #OrderedCollection>
	| model refactoring snippetChanges queryingObjectChanges pharoSnippets textSnippets |
	model := GtRBNamespace new.
	refactoring := GtRBRenameMethodRefactoring
			model: model
			renameMethod: #instVarNamed:
			in: Object
			to: #instVarNamed1:
			permutation: #(1).
	refactoring primitiveExecute.
	snippetChanges := model changes gtAllChanges
			select: [ :each | each isKindOf: LeSnippetChange ].
	queryingObjectChanges := snippetChanges
			select: [ :each | 
				each snippet page isNamedPage
					and: [ each snippet page title = 'Querying objects' ] ].
	pharoSnippets := queryingObjectChanges
			select: [ :each | each snippet isKindOf: LePharoSnippet ].
	self assert: pharoSnippets notEmpty.
	pharoSnippets
		detect: [ :each | '*game instVarNamed1: #routeCache*' match: each newSource ]
		ifNone: [ self error: 'Pharo snippet modification not found' ].
	textSnippets := queryingObjectChanges
			select: [ :each | each snippet isKindOf: LeTextSnippet ].
	self assert: textSnippets notEmpty.
	textSnippets
		detect: [ :each | '*{{gtMethod:*Object>>#instVarNamed1:}}*' match: each newSource ]
		ifNone: [ self error: 'Text snippet modification not found' ].
	^ queryingObjectChanges
]
