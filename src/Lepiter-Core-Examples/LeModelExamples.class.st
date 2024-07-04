Class {
	#name : #LeModelExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Models'
}

{ #category : #examples }
LeModelExamples >> databaseWithManyPagesOfDifferentCreateTimes [
	<gtExample>
	| aTemporaryDatabase aDatabase aTime |
	aTemporaryDatabase := LeTemporaryDatabase new.
	aDatabase := aTemporaryDatabase database.

	aTime := DateAndTime now.
	1 to: 100 do: [ :anIndex | 
		| aPageName aPage aTextSnippetContents aSnippet |
		aPageName := 'Page {1}' format: { anIndex }.
		aPage := aDatabase pageBuilder 
			title: aPageName; 
			createTime: aTime - 25 hours;
			editTime: aTime;
			add.
		aTextSnippetContents := 'Text of the page {1}' format: { anIndex }.
		aSnippet := aPage snippetBuilder 
			string: aTextSnippetContents; 
			createTime: aTime - 25 hours;
			editTime: aTime;
			add.
		aTime := aTime - 8 hours.
	].

	^ aTemporaryDatabase
]

{ #category : #examples }
LeModelExamples >> page50OfDatabaseWithManyPagesOfDifferentCreateTimes [
	<gtExample>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithManyPagesOfDifferentCreateTimes.
	database := temporaryDatabase database.

	page := database pageNamed: 'Page 50'.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]
