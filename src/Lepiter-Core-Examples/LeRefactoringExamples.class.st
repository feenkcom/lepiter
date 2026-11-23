Class {
	#name : #LeRefactoringExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Refactoring'
}

{ #category : #methods }
LeRefactoringExamples >> renameClassInExampleSnippet [
	"LeExampleSnippet>>#changeToRenameClass:to: renames the example class (the snippet stores its name as a String)"

	<gtExample>
	<return: #LeExampleSnippetChange>
	| snippet change |
	snippet := LeExampleSnippet new
		exampleBehaviorName: #LeRefactoringExamples;
		exampleSelector: #renameClassInExampleSnippet;
		yourself.
	change := snippet changeToRenameClass: #LeRefactoringExamples to: #LeRefactoringExamples1.
	self assert: change notNil.
	^ change
]

{ #category : #methods }
LeRefactoringExamples >> renameClassInGemstoneSnippet [
	<gtExample>
	<return: #OrderedCollection>
	| model refactoring snippetChanges queryingObjectChanges pharoSnippets |
	model := GtRBNamespace new.
	refactoring := GtRBRenameClassRefactoring
			model: model
			rename: #GtGsRelease
			to: #GtGsRelease1.
	refactoring primitiveExecute.
	snippetChanges := model changes gtAllChanges
			select: [ :each | each isKindOf: LeSnippetChange ].
	queryingObjectChanges := snippetChanges
			select: [ :each | 
				each snippet page isNamedPage
					and: [ each snippet page title
							= 'Checking the loaded gt4gemstone version inside a GemStone extent' ] ].
	pharoSnippets := queryingObjectChanges
			select: [ :each | each snippet isKindOf: LeGemStoneSnippet ].
	self assert: pharoSnippets notEmpty.
	pharoSnippets
		detect: [ :each | '*GtGsRelease1*' match: each newSource ]
		ifNone: [ self error: 'Pharo snippet modification not found' ].
	^ queryingObjectChanges
]

{ #category : #methods }
LeRefactoringExamples >> renameClassInPharoSnippet [
	"LeCodeSnippet>>#changeToRenameClass:to: renames the class in variable references (parsed as Strings) and in Symbol literals"

	<gtExample>
	<return: #LeSnippetChange>
	| change |
	change := (LePharoSnippet code: 'Foo new. #Foo') changeToRenameClass: #Foo to: #Bar.
	self assert: change newSource equals: 'Bar new. #Bar'.
	^ change
]

{ #category : #methods }
LeRefactoringExamples >> renameClassInTextSnippet [
	"LeTextSnippet>>#changeToRenameClass:to: renames the class in a {{gtClass:}} annotation (its class name is parsed as a String)"

	<gtExample>
	<return: #LeSnippetChange>
	| change |
	change := (LeTextSnippet string: 'See {{gtClass:Foo}} here') changeToRenameClass: #Foo to: #Bar.
	self assert: change newSource equals: 'See {{gtClass:Bar}} here'.
	^ change
]

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

{ #category : #methods }
LeRefactoringExamples >> renameMethodInGemstoneSnippet [
	<gtIgnoreConstraint: #GtSendersOfHaltSelectorsInGtPackagesConstraint>
	<gtExample>
	<return: #OrderedCollection>
	| model refactoring snippetChanges queryingObjectChanges pharoSnippets |
	model := GtRBNamespace new.
	refactoring := GtRBRenameMethodRefactoring
			model: model
			renameMethod: #halt
			in: Object
			to: #halt1
			permutation: #().
	refactoring primitiveExecute.
	snippetChanges := model changes gtAllChanges
			select: [ :each | each isKindOf: LeSnippetChange ].
	queryingObjectChanges := snippetChanges
			select: [ :each | 
				each snippet page isNamedPage
					and: [ each snippet page title
							= 'How to - snippets with multiple halts for resume in the GemStoneDebugger' ] ].
	pharoSnippets := queryingObjectChanges
			select: [ :each | each snippet isKindOf: LeGemStoneSnippet ].
	self assert: pharoSnippets notEmpty.
	pharoSnippets
		detect: [ :each | '*self halt1*' match: each newSource ]
		ifNone: [ self error: 'Pharo snippet modification not found' ].
	^ queryingObjectChanges
]

{ #category : #methods }
LeRefactoringExamples >> renameMethodInTextSnippet [
	"LeTextSnippet>>#changeToRenameSelector:to:using: renames the selector in a {{gtMethod:}} annotation (its selector is parsed as a String)"

	<gtExample>
	<return: #LeSnippetChange>
	| change |
	change := (LeTextSnippet string: 'See {{gtMethod:Foo>>#foo}} here') changeToRenameSelector: #foo to: #bar using: nil.
	self assert: change newSource equals: 'See {{gtMethod:Foo>>#bar}} here'.
	^ change
]
