Extension { #name : #LeModelExamples }

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> databaseWithTwoPagesHavingPictureSnippets [
	"Pages with picture snippets. Some picture files repeats by purpose."

	<gtExample>
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
	pageOne addSnippet: snippetOne.

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
LeModelExamples >> pageOneTitle [
	^ 'Page one with pictures'
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageOneWithTwoAttachmentPictures [
	"Page with picture snippets. Some picture files repeats by purpose."

	<gtExample>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithTwoPagesHavingPictureSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self pageOneTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageTwoTitle [
	^ 'Page two with pictures'
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageTwoWithOneAttachmentPictures [
	"Page with a picture snippet."

	<gtExample>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithTwoPagesHavingPictureSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self pageTwoTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]
