Extension { #name : #LeModelExamples }

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> databaseWithPageHavingLargePictureSnippets [
	"Pages with picture snippets."

	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase database page form pngFile possibleColors |
	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	page := database pageBuilder
			title: self pageOneTitle;
			add.

	form := Form extent: 1600 @ 1000 depth: 16.
	possibleColors := Color gtRegisteredColors.
	1
		to: form extent x
		do: [ :x | 
			1
				to: form extent y
				do: [ :y | form colorAt: x @ y put: possibleColors atRandom color ] ].
	pngFile := FileReference
			newTempFilePrefix: 'lepiter-model-examples'
			suffix: '-large-image.png'.
	PNGReadWriter putForm: form onFileNamed: pngFile.

	5
		timesRepeat: [ | pictureAttachment snippet |
			pictureAttachment := database addAttachmentByCopy: pngFile.
			snippet := LePictureSnippet new
					urlString: pictureAttachment;
					caption: 'Blank form'.
			page addSnippet: snippet ].

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> databaseWithPageHavingManyPictureSnippets [
	"Pages with picture snippets."

	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase database pageOne pictureFileOne pictureFileTwo |
	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	pageOne := database pageBuilder
			title: self pageOneTitle;
			add.

	pictureFileOne := FileLocator gtResource / 'feenkcom/gtoolkit/doc/feenk.png'.
	pictureFileTwo := FileLocator gtResource / 'feenkcom/gtoolkit/doc/gtoolkit.png'.

	15
		timesRepeat: [ | pictureAttachmentOne pictureAttachmentTwo snippetOne snippetTwo |
			pictureAttachmentOne := database addAttachmentByCopy: pictureFileOne.
			snippetOne := LePictureSnippet new
					urlString: pictureAttachmentOne;
					caption: 'Feenk'.
			pageOne addSnippet: snippetOne.

			pictureAttachmentTwo := database addAttachmentByCopy: pictureFileTwo.
			snippetTwo := LePictureSnippet new
					urlString: pictureAttachmentTwo;
					caption: 'Glamorous Toolkit'.
			snippetOne addSnippet: snippetTwo ].

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> databaseWithTwoPagesHavingPictureSnippets [
	"Pages with picture snippets. Some picture files repeats by purpose."

	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase database pageOne pictureFileOne pictureAttachmentOne snippetOne pictureFileTwo pictureAttachmentTwo snippetTwo snippetThree pageTwo snippetFour |
	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	pageOne := database pageBuilder
			title: self pageOneTitle;
			add.

	pictureFileOne := FileLocator gtResource / 'feenkcom/gtoolkit/doc/feenk.png'.
	pictureAttachmentOne := database addAttachmentByCopy: pictureFileOne.

	snippetOne := LePictureSnippet new
			urlString: pictureAttachmentOne;
			caption: 'Feenk'.
	self assert: snippetOne reference isEmpty.
	pageOne addSnippet: snippetOne.
	self assert: snippetOne reference isEmpty.

	pictureFileTwo := FileLocator gtResource / 'feenkcom/gtoolkit/doc/gtoolkit.png'.
	pictureAttachmentTwo := database addAttachmentByCopy: pictureFileTwo.

	snippetTwo := LePictureSnippet new
			urlString: pictureAttachmentTwo;
			caption: 'Glamorous Toolkit'.
	snippetOne addSnippet: snippetTwo.

	snippetThree := LePictureSnippet new
			urlString: pictureAttachmentOne;
			caption: 'Feenk 2'.
	snippetTwo addSnippet: snippetThree.

	pageTwo := database pageBuilder
			title: self pageTwoTitle;
			add.

	snippetFour := LePictureSnippet new
			urlString: pictureAttachmentTwo;
			caption: 'Glamorous Toolkit 2'.
	pageTwo addSnippet: snippetFour.

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds [
	"Pages with picture snippets. Some picture files repeats by purpose.
	All picture snippets have defined reference IDs."

	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase database referenceIndex |
	temporaryDatabase := self databaseWithTwoPagesHavingPictureSnippets.
	database := temporaryDatabase database.

	referenceIndex := 0.
	database
		pagesDo: [ :eachPage | 
			eachPage
				allChildrenDepthFirstDo: [ :eachSnippet | 
					eachSnippet isPictureSnippet
						ifTrue: [ referenceIndex := referenceIndex + 1.
							eachSnippet reference: 'picture' , referenceIndex asString ] ] ].

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds_toc1 [
	"Pages with picture snippets. Some picture files repeats by purpose.
	All picture snippets have defined reference IDs.
	Defined Table of Contents with Page One followed by Page Two."

	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase database tocPage |
	temporaryDatabase := self
			databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds.
	database := temporaryDatabase database.

	tocPage := database pageBuilder
			title: 'Table of Contents';
			add.
	self assert: database pages size equals: 3.

	tocPage snippetBuilder
		string: '[[' , self pageOneTitle , ']]';
		add.
	tocPage snippetBuilder
		string: '[[' , self pageTwoTitle , ']]';
		add.
	database tableOfContentsPageID: tocPage uid.
	self assert: database tableOfContents equals: tocPage.

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds_toc2 [
	"Pages with picture snippets. Some picture files repeats by purpose.
	All picture snippets have defined reference IDs.
	Defined Table of Contents with Page Two followed by Page One."

	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase database tocPage |
	temporaryDatabase := self
			databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds.
	database := temporaryDatabase database.

	tocPage := database pageBuilder
			title: 'Table of Contents';
			add.
	self assert: database pages size equals: 3.

	tocPage snippetBuilder
		string: '[[' , self pageTwoTitle , ']]';
		add.
	tocPage snippetBuilder
		string: '[[' , self pageOneTitle , ']]';
		add.
	database tableOfContentsPageID: tocPage uid.
	self assert: database tableOfContents equals: tocPage.

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageOneTitle [
	^ 'Page one'
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageOneWithTwoAttachmentPictures [
	"Page with picture snippets. Some picture files repeats by purpose."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithTwoPagesHavingPictureSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageOneWithTwoAttachmentPictures_definedReferenceIds [
	"Page with picture snippets. Some picture files repeats by purpose.
	All picture snippets have defined reference IDs."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self
			databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageOneWithTwoAttachmentPictures_definedReferenceIds_toc1 [
	"Page with picture snippets. Some picture files repeats by purpose.
	All picture snippets have defined reference IDs.
	Defined Table of Contents with Page One followed by Page Two."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self
			databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds_toc1.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageOneWithTwoAttachmentPictures_definedReferenceIds_toc2 [
	"Page with picture snippets. Some picture files repeats by purpose.
	All picture snippets have defined reference IDs.
	Defined Table of Contents with Page Two followed by Page One."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self
			databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds_toc2.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageThreeTitle [
	^ 'Page three with words'
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageThreeWithOneWordAttachment [
	"Page with picture snippets. Some picture files repeats by purpose."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithWordSnippet.
	database := temporaryDatabase database.

	page := database pageNamed: self pageThreeTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageTwoTitle [
	^ 'Page two'
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageTwoWithOneAttachmentPictures [
	"Page with a picture snippet."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithTwoPagesHavingPictureSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self pageTwoTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageTwoWithOneAttachmentPictures_definedReferenceIds [
	"Page with a picture snippet.
	All picture snippets have defined reference IDs."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self
			databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds.
	database := temporaryDatabase database.

	page := database pageNamed: self pageTwoTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageTwoWithOneAttachmentPictures_definedReferenceIds_toc1 [
	"Page with a picture snippet.
	All picture snippets have defined reference IDs.
	Defined Table of Contents with Page One followed by Page Two."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self
			databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds_toc1.
	database := temporaryDatabase database.

	page := database pageNamed: self pageTwoTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageTwoWithOneAttachmentPictures_definedReferenceIds_toc2 [
	"Page with a picture snippet.
	All picture snippets have defined reference IDs.
	Defined Table of Contents with Page Two followed by Page One."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self
			databaseWithTwoPagesHavingPictureSnippets_definedReferenceIds_toc2.
	database := temporaryDatabase database.

	page := database pageNamed: self pageTwoTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageWithLargePictureSnippets [
	"Page with a picture snippet."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithPageHavingLargePictureSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageWithManyPictureSnippets [
	"Page with a picture snippet."

	<gtExample>
	<return: #LePageExampleHolder>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithPageHavingManyPictureSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]
