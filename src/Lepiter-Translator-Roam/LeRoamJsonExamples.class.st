Class {
	#name : #LeRoamJsonExamples,
	#superclass : #Object,
	#category : #'Lepiter-Translator-Roam-Example'
}

{ #category : #'examples - json' }
LeRoamJsonExamples >> databaseWithOnePageNoCreateValues [
	<gtExample>
	| aDatabase |
	aDatabase := self reader
		databaseFromString: self databaseWithOnePageNoCreateValuesJson.
	self assert: aDatabase size equals: 1.
	^ aDatabase
]

{ #category : #'examples - json' }
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
	| aDatabase |
	aDatabase := self reader
		databaseFromString: self databaseWithOnePageNoEditValuesJson.
	self assert: aDatabase size equals: 1.
	^ aDatabase
]

{ #category : #'examples - json' }
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

{ #category : #accessing }
LeRoamJsonExamples >> defaultPictureSnippet [
	<gtExample>
	| pictureSnippet |

	pictureSnippet := LePictureSnippet new.
	self assert: pictureSnippet roamJsonStringContent equals: ''.

	^ pictureSnippet
]

{ #category : #accessing }
LeRoamJsonExamples >> editTime [
	^ 1564179233107
]

{ #category : #'examples - json' }
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
LeRoamJsonExamples >> pageNoCreateValues [
	<gtExample>
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
	| page roamJSON jsonObject blocks snippetBlock code |

	page := self pageWithSnippet.
	roamJSON := String streamContents: [ :stream |
		LeRoamJsonTranslator default page: page toStream: stream ].
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
	| urlString pictureSnippet |
	
	urlString := 'https://domain.com/picture.jpg'.
	
	pictureSnippet := self defaultPictureSnippet.
	pictureSnippet urlString: urlString.
	self assert: pictureSnippet roamJsonStringContent equals: ('![]({1})' format: { urlString }).

	^ pictureSnippet
]

{ #category : #'examples - basic' }
LeRoamJsonExamples >> readEditTime [
	<gtExample>
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
	| aPage |
	aPage := self reader
		readString: self simplePageJson 
		as: LePage 
		withMapping: #pageMappingFor:.
		
	self assert: aPage children size equals: 0.
	
	^ aPage
]

{ #category : #'examples - json' }
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
