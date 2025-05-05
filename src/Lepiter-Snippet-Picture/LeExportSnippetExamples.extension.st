Extension { #name : #LeExportSnippetExamples }

{ #category : #'*Lepiter-Snippet-Picture' }
LeExportSnippetExamples >> pictureFile_ExistingOne [
	^ (GtResourcesUtility resourceAtPath: Path 
		* 'feenkcom'
		/ 'gtoolkit-demos' 
		/ 'data' 
		/ 'faceapi' 
		/ '1280px-Einstein-with-habicht-and-solovine.jpg') asUrl asString
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeExportSnippetExamples >> pictureFile_MissingOne [
	^ (GtResourcesUtility resourceAtPath: Path 
		* 'feenkcom'
		/ 'gtoolkit' 
		/ 'data' 
		/ 'inexistent-image-file.jpg') asUrl asString
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeExportSnippetExamples >> pictureSnippetWithExistingFileReference [
	<gtExample>
	<return: #LePictureSnippet>
	| snippet |
	snippet := LePictureSnippet new urlString: self pictureFile_ExistingOne.

	^ snippet
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeExportSnippetExamples >> pictureSnippetWithHttps [
	<gtExample>
	<return: #LePictureSnippet>
	| snippet |
	snippet := LePictureSnippet new
			urlString: 'https://gtoolkit.com/assets/pictures/use-case-rest-api.png'.

	^ snippet
]

{ #category : #'*Lepiter-Snippet-Picture' }
LeExportSnippetExamples >> pictureSnippetWithMissingFileReference [
	<gtExample>
	<return: #LePictureSnippet>
	| snippet |
	snippet := LePictureSnippet new urlString: self pictureFile_MissingOne.

	^ snippet
]
