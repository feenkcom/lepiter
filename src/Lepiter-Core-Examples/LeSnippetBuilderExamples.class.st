Class {
	#name : #LeSnippetBuilderExamples,
	#superclass : #LeContentBuilderExamples,
	#category : #'Lepiter-Core-Examples-Builder'
}

{ #category : #'examples - basic' }
LeSnippetBuilderExamples >> basicBuilder [
	<gtExample>
	<return: #LeSnippetBuilder>
	| aBuilder |
	aBuilder := LeTextSnippet builder.
	^ aBuilder
]

{ #category : #'examples - basic' }
LeSnippetBuilderExamples >> basicSnippet [
	<gtExample>
	<return: #LeNullContent>
	| aBuilder aPage |
	aBuilder := self basicBuilder.
	aPage := aBuilder build.
	self assert: aPage class equals: LeSnippet null class.
	^ aPage
]

{ #category : #'examples - blocks' }
LeSnippetBuilderExamples >> pageInDatabase [
	<gtExample>
	<return: #LePage>
	| aDatabase aPage |
	aDatabase := self database.
	aPage := aDatabase pageBuilder
			title: 'one';
			add.
	^ aPage
]

{ #category : #'examples - blocks' }
LeSnippetBuilderExamples >> pharoBlockInPageAndDatabase [
	<gtExample>
	<return: #LePharoSnippet>
	| aDatabase aPage aSnippet |
	aPage := self pageInDatabase.
	aDatabase := aPage database.
	aSnippet := aPage snippetBuilder
			pharo: 'a := 42';
			add.
	self assert: aSnippet code equals: 'a := 42'.
	self assert: aSnippet parent equals: aPage.
	self assert: aSnippet database equals: aDatabase.
	self assert: aSnippet createTime isNotNil.
	self assert: aSnippet createTime <= LeTime now.
	self assert: aSnippet createEmail equals: aDatabase userEmail.
	self assert: aSnippet editTime equals: aSnippet createTime.
	self assert: aSnippet editEmail equals: aSnippet createEmail.
	^ aSnippet
]

{ #category : #'examples - blocks' }
LeSnippetBuilderExamples >> textSnippetInPageAndDatabase [
	<gtExample>
	<return: #LeTextSnippet>
	| aDatabase aPage aSnippet |
	aPage := self pageInDatabase.
	aDatabase := aPage database.
	aSnippet := aPage snippetBuilder
			string: 'one > one';
			add.
	self assert: aSnippet string equals: 'one > one'.
	self assert: aSnippet parent equals: aPage.
	self assert: aSnippet database equals: aDatabase.
	self assert: aSnippet createTime isNotNil.
	self assert: aSnippet createTime <= LeTime now.
	self assert: aSnippet createEmail equals: aDatabase userEmail.
	self assert: aSnippet editTime equals: aSnippet createTime.
	self assert: aSnippet editEmail equals: aSnippet createEmail.
	^ aSnippet
]
