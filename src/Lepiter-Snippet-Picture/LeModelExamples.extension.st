Extension { #name : #LeModelExamples }

{ #category : #'*Lepiter-Snippet-Picture' }
LeModelExamples >> pageWithTwoAttachmentPictures [
	"Page with picture snippets. Some picture files repeats by purpose."

	<gtExample>
	| temporaryDatabase database page pictureFileOne pictureAttachmentOne snippetOne pictureFileTwo pictureAttachmentTwo snippetTwo snippetThree |
	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	page := database pageBuilder
			title: 'Page with pictures';
			add.

	pictureFileOne := FileLocator gtResource / 'feenkcom/gtoolkit/doc/feenk.png'.
	pictureAttachmentOne := database addAttachmentByCopy: pictureFileOne.

	snippetOne := LePictureSnippet new
			urlString: pictureAttachmentOne;
			caption: 'Feenk'.
	page addSnippet: snippetOne.

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

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]
