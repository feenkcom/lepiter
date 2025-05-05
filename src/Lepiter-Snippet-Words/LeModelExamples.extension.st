Extension { #name : #LeModelExamples }

{ #category : #'*Lepiter-Snippet-Words' }
LeModelExamples >> databaseWithWordSnippet [
	<gtExample>
	<return: #LeTemporaryDatabase>
	| temporaryDatabase database pageOne snippetOne attachmentName |
	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	pageOne := database pageBuilder
			title: self pageThreeTitle;
			add.

	attachmentName := database
			addAttachmentWithContent: self toolkitExplanationString
			named: LeWordSnippet explanationAttachmentFileName.

	snippetOne := LeWordSnippet new.
	snippetOne explanationAttachmentName: attachmentName.

	pageOne addSnippet: snippetOne.

	self assert: snippetOne explanation isNotNil.

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippet-Words' }
LeModelExamples >> toolkitExplanationString [
	^ '[
	"toolkit",
	[
		{
			"phonetics" : [ ],
			"meanings" : [
				{
					"definitions" : [
						{
							"synonyms" : [ ],
							"definition" : "An assembly of tools.",
							"antonyms" : [ ]
						},
						{
							"synonyms" : [ ],
							"definition" : "A set of basic components for developing software.",
							"antonyms" : [ ]
						}
					],
					"synonyms" : [ ],
					"antonyms" : [ ],
					"partOfSpeech" : "noun"
				}
			],
			"word" : "toolkit",
			"sourceUrls" : [
				"https://en.wiktionary.org/wiki/toolkit"
			],
			"license" : {
				"name" : "CC BY-SA 3.0",
				"url" : "https://creativecommons.org/licenses/by-sa/3.0"
			}
		}
	]
]'
]
