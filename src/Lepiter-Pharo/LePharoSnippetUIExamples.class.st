Class {
	#name : #LePharoSnippetUIExamples,
	#superclass : #Object,
	#traits : 'TLeSpaceExamples + TAssertable',
	#classTraits : 'TLeSpaceExamples classTrait + TAssertable classTrait',
	#category : #'Lepiter-Pharo-Examples'
}

{ #category : #'examples - basic' }
LePharoSnippetUIExamples >> basicDatabase [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := LeDatabase new.
	self assert: aDatabase size equals: 0.
	^ aDatabase
]

{ #category : #'examples - create example' }
LePharoSnippetUIExamples >> createExampleProtocolForTypedPackageName [
	"Create example files the method under examples when the package typed in the form is the package of the class
	(the typed name is a String, the package name a Symbol), and as an extension of another package"

	<gtExample>
	<return: #LePharoCreateExampleElement>
	| element |
	element := LePharoCreateExampleElement new.
	self
		assert: (element exampleProtocolFor: self class inPackageNamed: self class package name asString)
		equals: #examples.
	self
		assert: (element exampleProtocolFor: self class inPackageNamed: 'Lepiter-Core') asString
		equals: '*Lepiter-Core'.
	^ element
]

{ #category : #examples }
LePharoSnippetUIExamples >> snippet [
	<gtExample>
	<return: #LePharoSnippet>
	^ LePharoSnippet new code: '42 inspect'
]

{ #category : #examples }
LePharoSnippetUIExamples >> treeNodeElement [
	<gtExample>
	<return: #LePharoSnippetElement>
	| aSnippet aSnippetUIModel aSnippetElement |
	aSnippet := self snippet.
	aSnippetUIModel := aSnippet asSnippetViewModel.
	aSnippetElement := aSnippetUIModel snippetElementClass new.
	aSnippetElement snippetViewModel: aSnippetUIModel.

	^ aSnippetElement
]
