Class {
	#name : #LeLocalStorageExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #examples }
LeLocalStorageExamples >> ensureAttributeOrdering [
	"Check that a the process of reading and writing a JSON file doesn't change the attribute ordering"

	<gtExample>
	<return: #ByteString>
	| pageJson fileSystem file storage jsonObject file2 pageJson2 |
	pageJson := ((self class >> #jsonSource) comments second
			copyReplaceAll: ''''
			with: '"') withUnixLineEndings.
	fileSystem := FileSystem memory.
	file := fileSystem root / 'page.json'.
	file writeStreamDo: [ :stream | stream << pageJson ].
	storage := LeLocalStorage new.

	jsonObject := storage loadJsonFrom: file.
	file2 := fileSystem root / 'page2.json'.
	storage write: jsonObject toJsonFile: file2.
	pageJson2 := file2 contents.

	self assert: pageJson2 withUnixLineEndings equals: pageJson.
	^ pageJson
]

{ #category : #private }
LeLocalStorageExamples >> jsonSource [
	"The following comment contains the test json.
	It must be the second comment in the method."
"{
	'__schema' : '3.2',
	'__type' : 'page',
	'children' : {
		'__type' : 'snippets',
		'items' : [
			{
				'__type' : 'pharoSnippet',
				'children' : {
					'__type' : 'snippets',
					'items' : [ ]
				},
				'createEmail' : {
					'__type' : 'email',
					'emailString' : 'example@gmail.com'
				},
				'createTime' : {
					'__type' : 'time',
					'time' : {
						'__type' : 'dateAndTime',
						'dateAndTimeString' : '2021-04-14T12:19:54.622524+02:00'
					}
				},
				'editEmail' : {
					'__type' : 'email',
					'emailString' : 'example@gmail.com'
				},
				'editTime' : {
					'__type' : 'time',
					'time' : {
						'__type' : 'dateAndTime',
						'dateAndTimeString' : '2021-04-14T12:25:04.234914+02:00'
					}
				},
				'uid' : {
					'__type' : 'uid',
					'uidString' : 'DqjU2jQf'
				},
				'code' : '4+3'
			}
		]
	},
	'createEmail' : {
		'__type' : 'email',
		'emailString' : 'example@gmail.com'
	},
	'createTime' : {
		'__type' : 'time',
		'time' : {
			'__type' : 'dateAndTime',
			'dateAndTimeString' : '2021-04-14T12:19:54.622395+02:00'
		}
	},
	'editEmail' : {
		'__type' : 'email',
		'emailString' : 'example@gmail.com'
	},
	'editTime' : {
		'__type' : 'time',
		'time' : {
			'__type' : 'dateAndTime',
			'dateAndTimeString' : '2021-04-14T12:19:54.622395+02:00'
		}
	},
	'pageType' : {
		'__type' : 'unnamedPage'
	},
	'uid' : {
		'__type' : 'uuid',
		'uuid' : '98c02ed3-4d7c-0d00-8491-87fe0aa9bd0e'
	}
}"
]
