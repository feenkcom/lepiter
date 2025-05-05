Class {
	#name : #LeRoamJsonExamples,
	#superclass : #Object,
	#category : #'Lepiter-Translator-Roam-Example'
}

{ #category : #'examples - json' }
LeRoamJsonExamples >> databaseWithOnePageNoCreateValues [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self reader
			databaseFromString: self databaseWithOnePageNoCreateValuesJson.
	self assert: aDatabase size equals: 1.
	^ aDatabase
]

{ #category : #'accessing - json' }
LeRoamJsonExamples >> databaseWithOnePageNoCreateValuesJson [

	^ '[ {
		"title" : "July 26th, 2019",
		"edit-time" : 1564179233107,
		"edit-email" : "email@example.com"
	} ]'
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> databaseWithOnePageNoEditValues [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self reader
			databaseFromString: self databaseWithOnePageNoEditValuesJson.
	self assert: aDatabase size equals: 1.
	^ aDatabase
]

{ #category : #'accessing - json' }
LeRoamJsonExamples >> databaseWithOnePageNoEditValuesJson [
	^ '[ {
		"title" : "July 26th, 2019",
		"create-time" : 1564179233107,
		"create-email" : "email@example.com"
	} ]'
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> databaseWithOnePageNoEditValues_Read [
	<gtExample>
	<return: #FileReference>
	| aDatabase aFile |
	aFile := self databaseWithOnePageNoEditValues_Write.
	aDatabase := LeDatabase fromRoamJsonFile: aFile.
	self assert: aDatabase isNotNil.
	self assert: aDatabase size equals: 1.
	^ aFile
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> databaseWithOnePageNoEditValues_Write [
	<gtExample>
	<return: #FileReference>
	| aDatabase aFile |
	aDatabase := self databaseWithOnePageNoEditValues.
	aFile := FileSystem memory workingDirectory / 'file.json'.
	self assert: aFile exists not.
	aDatabase toRoamJsonFile: aFile.
	self assert: aFile exists.
	self assert: aFile size isZero not.
	self assert: aFile contents equals: self exportedDatabaseJson.
	^ aFile
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> databaseWithOnePageWithSnippetWithInvalidBase64Encoder [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase targetPage targetSnippet |
	aDatabase := self reader
			databaseFromString: self databaseWithOnePageWithSnippetWithInvalidBase64EncoderJson.
	self assert: aDatabase size equals: 1.

	targetPage := aDatabase pages first.
	self assert: targetPage children size equals: 1.

	targetSnippet := targetPage children first.
	self assert: targetSnippet uidString equals: 'Wuu11jwlbWuuAAAAAAAAAA=='.

	^ aDatabase
]

{ #category : #'accessing - json' }
LeRoamJsonExamples >> databaseWithOnePageWithSnippetWithInvalidBase64EncoderJson [
	^ '[ {
		"title" : "Page with a snippet",
		"create-time" : 1564179233107,
		"create-email" : "email@example.com",
		"uid": "RA1UXmzp0",
		"children" : [
			{
				"string" : "A link with an id that triggers a ZnCharacterEncodingError encoding.",
				"create-time" : 1599417273794,
				"create-email" : "@<unknown>",
				"edit-time" : 1599417281535,
				"edit-email" : "@<unknown>",
				"uid" : "Wuu11jwlb"
			}
		]
	} ]'
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> databaseWithPageWithSnippetLink [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase pageWithLink snippetWithLink |
	aDatabase := self reader
			databaseFromString: self databaseWithPageWithSnippetLinkJson.
	self assert: aDatabase size equals: 2.

	pageWithLink := aDatabase pageNamed: 'One snippet with link'.
	self assert: pageWithLink children size equals: 1.

	snippetWithLink := pageWithLink children first.
	self assert: snippetWithLink string equals: 'link ((Wuu11jwlbWuuAAAAAAAAAA==))'.

	^ aDatabase
]

{ #category : #'accessing - json' }
LeRoamJsonExamples >> databaseWithPageWithSnippetLinkJson [
	^ '[ {
		"title" : "Target Page",
		"create-time" : 1599299533370,
		"create-email" : "jane@doe.com",
		"edit-time" : 1599299533370,
		"edit-email" : "jane@doe.com",
		"children" : [
			{
				"string" : "Target Snippet",
				"create-time" : 1599417273794,
				"create-email" : "@<unknown>",
				"edit-time" : 1599417281535,
				"edit-email" : "@<unknown>",
				"uid" : "Wuu11jwlb",
				"children" : [ ]
			}
		]
	},
	{
		"title" : "One snippet with link",
		"create-time" : 1599299533370,
		"create-email" : "jane@doe.com",
		"edit-time" : 1599299533370,
		"edit-email" : "jane@doe.com",
		"children" : [
			{
				"string" : "link ((Wuu11jwlb))",
				"create-time" : 1599417273794,
				"create-email" : "@<unknown>",
				"edit-time" : 1599417281535,
				"edit-email" : "@<unknown>",
				"uid" : "pWRyFfmVo",
				"children" : [ ]
			}
		]
	} ]'
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> databaseWithPageWithSnippetWithTwoLinks [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase pageWithLink snippetWithLink |
	aDatabase := self reader
			databaseFromString: self databaseWithPageWithSnippetWithTwoLinksJson.
	self assert: aDatabase size equals: 2.

	pageWithLink := aDatabase pageNamed: 'One snippet with link'.
	self assert: pageWithLink children size equals: 1.

	snippetWithLink := pageWithLink children first.
	self
		assert: snippetWithLink string
		equals: 'link ((Wuu11jwlbWuuAAAAAAAAAA==)) and ((OpgJN0KUhOpgAAAAAAAAAA==))'.

	^ aDatabase
]

{ #category : #'accessing - json' }
LeRoamJsonExamples >> databaseWithPageWithSnippetWithTwoLinksJson [
	^ '[ {
		"title" : "Target Page",
		"create-time" : 1599299533370,
		"create-email" : "jane@doe.com",
		"edit-time" : 1599299533370,
		"edit-email" : "jane@doe.com",
		"children" : [
			{
				"string" : "Target Snippet One",
				"create-time" : 1599417273794,
				"create-email" : "@<unknown>",
				"edit-time" : 1599417281535,
				"edit-email" : "@<unknown>",
				"uid" : "Wuu11jwlb",
				"children" : [ ]
			},
			{
				"string" : "Target Snippet Two",
				"create-time" : 1599417273796,
				"create-email" : "@<unknown>",
				"edit-time" : 1599417281539,
				"edit-email" : "@<unknown>",
				"uid" : "OpgJN0KUh",
				"children" : [ ]
			}
		]
	},
	{
		"title" : "One snippet with link",
		"create-time" : 1599299533370,
		"create-email" : "jane@doe.com",
		"edit-time" : 1599299533370,
		"edit-email" : "jane@doe.com",
		"children" : [
			{
				"string" : "link ((Wuu11jwlb)) and ((OpgJN0KUh))",
				"create-time" : 1599417273794,
				"create-email" : "@<unknown>",
				"edit-time" : 1599417281535,
				"edit-email" : "@<unknown>",
				"uid" : "pWRyFfmVo",
				"children" : [ ]
			}
		]
	} ]'
]

{ #category : #accessing }
LeRoamJsonExamples >> defaultPictureSnippet [
	<gtExample>
	<return: #LePictureSnippet>
	| pictureSnippet |
	pictureSnippet := LePictureSnippet new.
	self assert: pictureSnippet roamJsonStringContent equals: ''.

	^ pictureSnippet
]

{ #category : #accessing }
LeRoamJsonExamples >> editTime [
	^ 1564179233107
]

{ #category : #'accessing - json' }
LeRoamJsonExamples >> exportedDatabaseJson [
	^ '[
	{
		"title" : "July 26th, 2019",
		"create-time" : 1564179233107,
		"create-email" : "email@example.com",
		"edit-time" : 1564179233107,
		"edit-email" : "email@example.com",
		"children" : [ ]
	}
]'
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> helpDatabaseFromJsonImport [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self reader databaseFromString: self helpDatabaseJson.

	self assert: aDatabase size equals: 5.

	^ aDatabase
]

{ #category : #'accessing - json' }
LeRoamJsonExamples >> helpDatabaseJson [
	^ '[
	{
		"title" : "September 4th, 2020",
		"create-time" : 1599255508029,
		"create-email" : "jane@doe.com",
		"edit-time" : 1599255508029,
		"edit-email" : "jane@doe.com",
		"children" : [
			{
				"string" : "[[lepĭter]] is powered by [[Glamorous Toolkit]]",
				"create-time" : 1599255550821,
				"create-email" : "jane@doe.com",
				"edit-time" : 1599255611651,
				"edit-email" : "jane@doe.com",
				"uid" : "reIKDhPY",
				"children" : [ ]
			}
		]
	},
	{
		"title" : "lepĭter",
		"create-time" : 1599417193575,
		"create-email" : "@<unknown>",
		"edit-time" : 1599417193575,
		"edit-email" : "@<unknown>",
		"children" : [
			{
				"string" : "lepĭter is multiple things at the same time:",
				"create-time" : 1599255621591,
				"create-email" : "jane@doe.com",
				"edit-time" : 1599255774594,
				"edit-email" : "jane@doe.com",
				"uid" : "1qpXSwWM",
				"children" : [
					{
						"string" : "It is a local-first solution for managing networked thought.",
						"create-time" : 1599255647980,
						"create-email" : "jane@doe.com",
						"edit-time" : 1599255847250,
						"edit-email" : "jane@doe.com",
						"uid" : "LhB0QVSA",
						"children" : [ ]
					},
					{
						"string" : "It is a programmable interface for your database.",
						"create-time" : 1599255749469,
						"create-email" : "jane@doe.com",
						"edit-time" : 1599255846067,
						"edit-email" : "jane@doe.com",
						"uid" : "egMdI3+y",
						"children" : [ ]
					},
					{
						"string" : "It is an example of using the mechanisms of  [[Glamorous Toolkit]] for an end user application.",
						"create-time" : 1599255668805,
						"create-email" : "jane@doe.com",
						"edit-time" : 1599255844251,
						"edit-email" : "jane@doe.com",
						"uid" : "aKDB+Bgd",
						"children" : [ ]
					}
				]
			}
		]
	},
	{
		"title" : "Glamorous Toolkit",
		"create-time" : 1599417193576,
		"create-email" : "@<unknown>",
		"edit-time" : 1599417193576,
		"edit-email" : "@<unknown>",
		"children" : [
			{
				"string" : "[Glamorous Toolkit](https://gtoolkit.com) is the moldable development environment. It is a live notebook. It is a flexible search interface. It is a fancy code editor. It is a software analysis platform. It is a data visualization engine. All in one. ((reIKDhPY))",
				"create-time" : 1599289069146,
				"create-email" : "jane@doe.com",
				"edit-time" : 1599417308601,
				"edit-email" : "@<unknown>",
				"uid" : "xaIfkjaN",
				"children" : [ ]
			}
		]
	},
	{
		"title" : "Page with Snippet with 4 links",
		"create-time" : 1599299533370,
		"create-email" : "jane@doe.com",
		"edit-time" : 1599299533370,
		"edit-email" : "jane@doe.com",
		"children" : [
			{
				"string" : "Lepiters is ((LhB0QVSA)), ((egMdI3+y)) and ((aKDB+Bgd)) / ((aKDB+Bgd))",
				"create-time" : 1599417273794,
				"create-email" : "@<unknown>",
				"edit-time" : 1599417281535,
				"edit-email" : "@<unknown>",
				"uid" : "Wuu11jwlb",
				"children" : [ ]
			}
		]
	},
	{
		"title" : "One snippet with link",
		"create-time" : 1599299533370,
		"create-email" : "jane@doe.com",
		"edit-time" : 1599299533370,
		"edit-email" : "jane@doe.com",
		"children" : [
			{
				"string" : "link ((LhB0QVSA))",
				"create-time" : 1599417273794,
				"create-email" : "@<unknown>",
				"edit-time" : 1599417281535,
				"edit-email" : "@<unknown>",
				"uid" : "pWRyFfmVo",
				"children" : [ ]
			}
		]
	}
]'
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> helpDatabaseSnippetWithFourLinks [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase targetPage targetSnippet |
	aDatabase := self reader databaseFromString: self helpDatabaseJson.
	self assert: aDatabase size equals: 5.

	targetPage := aDatabase pageNamed: 'Page with Snippet with 4 links'.
	self assert: targetPage children size equals: 1.

	targetSnippet := targetPage children first.
	self
		assert: targetSnippet string
		equals: 'Lepiters is ((LhB0QVSAAAAAAAAAAAAAAA==)), ((egMdI3+yAAAAAAAAAAAAAA==)) and ((aKDB+BgdAAAAAAAAAAAAAA==)) / ((aKDB+BgdAAAAAAAAAAAAAA==))'.

	^ aDatabase
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> pageNoCreateValues [
	<gtExample>
	<return: #LePage>
	| aDatabase aPage |
	aDatabase := self databaseWithOnePageNoCreateValues.
	aPage := aDatabase anyOne.
	self assert: aPage database equals: aDatabase.
	self assert: aPage editTime isNotNil.
	self assert: aPage editEmail isNotNil.
	self assert: aPage createTime isNotNil.
	self assert: aPage createEmail isNotNil.
	self assert: aPage createTime equals: aPage editTime.
	self assert: aPage createEmail equals: aPage editEmail.
	self assert: aPage wasEdited not.
	^ aPage
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> pageNoEditValues [
	<gtExample>
	<return: #LePage>
	| aDatabase aPage |
	aDatabase := self databaseWithOnePageNoEditValues.
	aPage := aDatabase anyOne.
	self assert: aPage database equals: aDatabase.
	self assert: aPage editTime isNotNil.
	self assert: aPage editEmail isNotNil.
	self assert: aPage createTime isNotNil.
	self assert: aPage createEmail isNotNil.
	self assert: aPage createTime equals: aPage editTime.
	self assert: aPage createEmail equals: aPage editEmail.
	self assert: aPage wasEdited not.
	^ aPage
]

{ #category : #'examples - basic' }
LeRoamJsonExamples >> pageWithSnippet [
	<gtExample>
	<return: #LePage>
	| db page |
	db := LeDatabase new.
	page := db pageBuilder
			title: 'Page with Pharo Snippet';
			add.
	page snippetBuilder
		string: 'Preceding text block';
		add.

	page addSnippet: (LePharoSnippet new code: '42 inspect').
	page snippetBuilder
		string: 'Following text block';
		add.

	^ page
]

{ #category : #'examples - basic' }
LeRoamJsonExamples >> pageWithSnippetJSONExport [
	"Export the example page in Roam JSON format"

	<gtExample>
	<return: #ByteString>
	| page roamJSON jsonObject blocks snippetBlock code |
	page := self pageWithSnippet.
	roamJSON := String
			streamContents: [ :stream | LeRoamJsonTranslator default page: page toStream: stream ].
	jsonObject := STONJSON fromString: roamJSON.
	blocks := jsonObject at: #children.
	snippetBlock := blocks second.
	code := snippetBlock at: #string.

	self assert: code equals: '```smalltalk\42 inspect\```' withCRs.

	^ roamJSON
]

{ #category : #accessing }
LeRoamJsonExamples >> pictureSnippetWithURL [
	<gtExample>
	<return: #LePictureSnippet>
	| urlString pictureSnippet |
	urlString := 'https://domain.com/picture.jpg'.

	pictureSnippet := self defaultPictureSnippet.
	pictureSnippet urlString: urlString.
	self
		assert: pictureSnippet roamJsonStringContent
		equals: ('![]({1})' format: {urlString}).

	^ pictureSnippet
]

{ #category : #'examples - basic' }
LeRoamJsonExamples >> readEditTime [
	<gtExample>
	<return: #DateAndTime>
	| aDateAndTime |
	aDateAndTime := self reader
			readString: self editTime asString
			as: DateAndTime
			withMapping: #dateAndTimeMappingFor:.
	self assert: aDateAndTime equals: '2019-07-26T22:13:53.107+00:00' asDateAndTime.
	^ aDateAndTime
]

{ #category : #accessing }
LeRoamJsonExamples >> reader [
	^ LeRoamJsonTranslator default
]

{ #category : #'examples - json' }
LeRoamJsonExamples >> simplePage [
	<gtExample>
	<return: #LePage>
	| aPage |
	aPage := self reader
			readString: self simplePageJson
			as: LePage
			withMapping: #pageMappingFor:.

	self assert: aPage children size equals: 0.

	^ aPage
]

{ #category : #'accessing - json' }
LeRoamJsonExamples >> simplePageJson [
	^ '{
		"title" : "July 26th, 2019",
		"edit-time" : 1564179233107,
		"edit-email" : "email@example.com"
	}'
]

{ #category : #'examples - basic' }
LeRoamJsonExamples >> writeEditTime [
	<gtExample>
	<return: #ByteString>
	| aDateAndTime aString |
	aDateAndTime := self readEditTime.
	aString := self writer
			write: aDateAndTime
			as: DateAndTime
			withMapping: #dateAndTimeMappingFor:.

	self assert: aString asInteger equals: self editTime.
	self assert: aString equals: self editTime asString.

	^ aString
]

{ #category : #accessing }
LeRoamJsonExamples >> writer [
	^ LeRoamJsonTranslator default
]
