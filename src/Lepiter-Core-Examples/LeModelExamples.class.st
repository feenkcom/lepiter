Class {
	#name : #LeModelExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Models'
}

{ #category : #examples }
LeModelExamples >> databaseWithManyPagesOfDifferentCreateTimes [
	<gtExample>
	<return: #LeTemporaryDatabase>
	| aTemporaryDatabase aDatabase aTime |
	aTemporaryDatabase := LeTemporaryDatabase new.
	aDatabase := aTemporaryDatabase database.

	aTime := DateAndTime now.
	1
		to: 100
		do: [ :anIndex | 
			| aPageName aPage aTextSnippetContents aSnippet |
			aPageName := 'Page {1}' format: {anIndex}.
			aPage := aDatabase pageBuilder
					title: aPageName;
					createTime: aTime - 25 hours;
					editTime: aTime;
					add.
			aTextSnippetContents := 'Text of the page {1}' format: {anIndex}.
			aSnippet := aPage snippetBuilder
					string: aTextSnippetContents;
					createTime: aTime - 25 hours;
					editTime: aTime;
					add.
			aTime := aTime - 8 hours ].

	^ aTemporaryDatabase
]

{ #category : #examples }
LeModelExamples >> databaseWithOnePage [
	<gtExample>
	<return: #LeTemporaryDatabase>
	| aTemporaryDatabase aDatabase aPageName aPage aTextSnippetContents aSnippet |
	aTemporaryDatabase := LeTemporaryDatabase new.
	aDatabase := aTemporaryDatabase database.

	aPageName := 'Page One'.
	aPage := aDatabase pageBuilder
			title: aPageName;
			add.
	aTextSnippetContents := 'Text of the page one'.
	aSnippet := aPage snippetBuilder
			string: aTextSnippetContents;
			add.

	^ aTemporaryDatabase
]

{ #category : #examples }
LeModelExamples >> page50OfDatabaseWithManyPagesOfDifferentCreateTimes [
	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithManyPagesOfDifferentCreateTimes.
	database := temporaryDatabase database.

	page := database pageNamed: 'Page 50'.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #examples }
LeModelExamples >> pageOneFromDatabaseWithOnlyOnePage [
	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithOnePage.
	database := temporaryDatabase database.

	page := database pages anyOne.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]
