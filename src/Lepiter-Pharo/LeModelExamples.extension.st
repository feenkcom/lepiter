Extension { #name : #LeModelExamples }

{ #category : #'*Lepiter-Pharo' }
LeModelExamples >> databaseWithPageHavingManyPharoSnippets [
	<gtExample>
	| temporaryDatabase database pageOne aSnippet |
	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	pageOne := database pageBuilder
			title: self pageOneTitle;
			add.

	aSnippet := LePharoSnippet new code: 'GtCoderEmbeddedDebuggerElement enableEmbeddedDebugger'.
	pageOne addSnippet: aSnippet.
	aSnippet := LePharoSnippet new code: 'GtCoderEmbeddedDebuggerElement disableEmbeddedDebugger'.
	pageOne addSnippet: aSnippet.

	1
		to: 10
		do: [ :anIndex | 
			| eachSnippet |
			eachSnippet := LePharoSnippet new code: 'FileLocator imageDirectory'.
			pageOne addSnippet: eachSnippet.
			eachSnippet := LePharoSnippet new code: 'aValue := 108'.
			pageOne addSnippet: eachSnippet.
			eachSnippet := LePharoSnippet new code: 'aValue'.
			pageOne addSnippet: eachSnippet.
			eachSnippet := LePharoSnippet new code: 'aValue / 0'.
			anIndex = 2
				ifTrue: [ | aCode |
					aCode := String
							streamContents: [ :aStream | 
								0
									to: 50
									do: [ :aDiv | 
										aStream
											nextPutAll: 'aValue / ';
											print: aDiv;
											nextPut: $.;
											cr ] ].
					eachSnippet code: aCode ].
			pageOne addSnippet: eachSnippet ].

	^ temporaryDatabase
]

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

{ #category : #'*Lepiter-Pharo' }
LeModelExamples >> pageOneWithPageHavingManyPharoSnippets [
	<gtExample>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithPageHavingManyPharoSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]
