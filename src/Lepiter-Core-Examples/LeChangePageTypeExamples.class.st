Class {
	#name : #LeChangePageTypeExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #'examples - model' }
LeChangePageTypeExamples >> basicUnnamedPage [
	<gtExample>
	<return: #LePage>
	| page |
	page := LePage unnamedPage.

	self assert: page title equals: 'Page'.
	self assert: page type title equals: 'Page'.

	^ page
]

{ #category : #'examples - model' }
LeChangePageTypeExamples >> basicUnnamedPageWithCustomDefaultTitle [
	<gtExample>
	<return: #LePage>
	| page |
	page := LePage unnamedPageWithDefaultTitle: 'Custom Default'.

	self assert: page title equals: 'Custom Default'.
	self assert: page type title equals: 'Custom Default'.

	^ page
]

{ #category : #'examples - model' }
LeChangePageTypeExamples >> databaseWithOneUnnamedPage [
	<gtExample>
	<return: #LeDatabase>
	| aPage aDatabase |
	aDatabase := LeContentBuilderExamples new database.
	aPage := self basicUnnamedPage.
	aDatabase addPage: aPage.

	self assert: aDatabase pages size equals: 1.
	self assert: aDatabase pagesByName size equals: 0.
	self assert: aDatabase unnamedPagesByUid size equals: 1.
	self assert: aDatabase dailyNotes size equals: 0.

	^ aDatabase
]

{ #category : #'examples - model' }
LeChangePageTypeExamples >> databaseWithTwoUnnamedPage [
	<gtExample>
	<return: #LeDatabase>
	| aFirstPage aSecondPage aDatabase |
	aDatabase := LeContentBuilderExamples new database.
	aFirstPage := self basicUnnamedPage.
	aSecondPage := self basicUnnamedPageWithCustomDefaultTitle.
	aDatabase addPage: aFirstPage.
	aDatabase addPage: aSecondPage.

	self assert: aDatabase pages size equals: 2.
	self assert: aDatabase pagesByName size equals: 0.
	self assert: aDatabase unnamedPagesByUid size equals: 2.
	self assert: aDatabase dailyNotes size equals: 0.

	^ aDatabase
]

{ #category : #'examples - page title' }
LeChangePageTypeExamples >> updateUnnamedPageToNamedPage [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPage |
	aDatabase := self databaseWithOneUnnamedPage.
	aPage := aDatabase pages first.
	aPage updateTitle: 'named'.
	self assert: aPage title equals: 'named'.
	self assert: aPage type isNamedPageType.

	self assert: aDatabase pages size equals: 1.
	self assert: aDatabase pagesByName size equals: 1.
	self assert: aDatabase unnamedPagesByUid size equals: 0.
	self assert: aDatabase dailyNotes size equals: 0.

	^ aDatabase
]
