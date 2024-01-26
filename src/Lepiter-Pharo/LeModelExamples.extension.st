Extension { #name : #LeModelExamples }

{ #category : #'*Lepiter-Pharo' }
LeModelExamples >> databaseWithPageHavingOnePharoSnippet [
	"Page with one Pharo snippet that have valid executable code"

	<gtExample>
	| temporaryDatabase database pageOne snippetOne |
	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	pageOne := database pageBuilder
			title: self pageOneTitle;
			add.

	snippetOne := LePharoSnippet new
			code: 'FileLocator imageDirectory'.
	pageOne addSnippet: snippetOne.

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Pharo' }
LeModelExamples >> pageOneWithOnePharoSnippet [
	"Page with one Pharo snippet that have valid executable code"

	<gtExample>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithPageHavingOnePharoSnippet.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]
