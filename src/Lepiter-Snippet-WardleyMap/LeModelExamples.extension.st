Extension { #name : #LeModelExamples }

{ #category : #'*Lepiter-Snippet-WardleyMap' }
LeModelExamples >> databaseWithTwoPagesHavingWardleyMapSnippets [
	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase database pageOne snippetOne snippetTwo pageTwo |
	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	pageOne := database pageBuilder
			title: self pageOneTitle;
			add.
	pageTwo := database pageBuilder
			title: self pageTwoTitle;
			add.

	snippetOne := LeWardleyMapSnippet new
			wardleyMap: GtWardleyMapModelExamples new newMapWithNodes.
	pageOne addSnippet: snippetOne.

	snippetTwo := LeWardleyMapSnippet new
			wardleyMap: GtWardleyMapModelExamples new newMapWithPipelineInnerNodes.
	pageTwo addSnippet: snippetTwo.

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-WardleyMap' }
LeModelExamples >> pageOneHavingWardleyMapSnippets [
	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithTwoPagesHavingWardleyMapSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]
