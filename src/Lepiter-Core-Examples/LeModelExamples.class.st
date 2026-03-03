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
LeModelExamples >> databaseWithManyPagesOfDifferentCreateTimesAndToC [
	<gtExample>
	<return: #LeTemporaryDatabase>
	| aTemporaryDatabase aDatabase aToCPage aTime |
	aTemporaryDatabase := LeTemporaryDatabase new.
	aDatabase := aTemporaryDatabase database.
	
	aTime := DateAndTime now.
	aToCPage := aDatabase pageBuilder
		title: 'Table of Contents';
		createTime: aTime - 25 hours;
		editTime: aTime;
		add.
	aTime := aTime - 8 hours.
	
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
					
			anIndex < 61 ifTrue: [
				aToCPage snippetBuilder
						string: ('[[{1}]]  ' format: { aPageName });
						createTime: aTime - 25 hours;
						editTime: aTime;
						add ].
			
			aTime := aTime - 8 hours. ].
			
	aDatabase tableOfContentsPageID: aToCPage uid.
	self assert: aDatabase tableOfContents equals: aToCPage.

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
LeModelExamples >> page49OfDatabaseWithManyPagesOfDifferentCreateTimes [
	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithManyPagesOfDifferentCreateTimes.
	database := temporaryDatabase database.

	page := database pageNamed: 'Page 49'.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
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
LeModelExamples >> page50OfDatabaseWithManyPagesOfDifferentCreateTimesAndToC [
	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithManyPagesOfDifferentCreateTimesAndToC.
	database := temporaryDatabase database.

	page := database pageNamed: 'Page 50'.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #examples }
LeModelExamples >> page60OfDatabaseWithManyPagesOfDifferentCreateTimesAndToC [
	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithManyPagesOfDifferentCreateTimesAndToC.
	database := temporaryDatabase database.

	page := database pageNamed: 'Page 60'.

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
