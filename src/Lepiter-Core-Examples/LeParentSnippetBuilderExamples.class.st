Class {
	#name : #LeParentSnippetBuilderExamples,
	#superclass : #LeSnippetBuilderExamples,
	#category : #'Lepiter-Core-Examples-Builder'
}

{ #category : #'examples - blocks' }
LeParentSnippetBuilderExamples >> emptySnippetInPageAndDatabase [
	<gtExample>
	<return: #LeTextSnippet>
	| aDatabase aPage aSnippet |
	aDatabase := self database.
	aPage := aDatabase pageBuilder
			title: 'one';
			add.
	aSnippet := aPage snippetBuilder
			empty;
			add.
	self assert: aSnippet text isNotNil.
	self assert: aSnippet text asString equals: ''.
	self assert: aSnippet parent equals: aPage.
	self assert: aSnippet database equals: aDatabase.
	self assert: aSnippet createTime isNotNil.
	self assert: aSnippet createTime <= LeTime now.
	self assert: aSnippet createEmail equals: aDatabase userEmail.
	self assert: aSnippet editTime equals: aSnippet createTime.
	self assert: aSnippet editEmail equals: aSnippet createEmail.
	self assert: aSnippet uid isNotNil.
	^ aSnippet
]
