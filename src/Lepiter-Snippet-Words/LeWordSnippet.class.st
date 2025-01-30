"
I am a {{gtClass:LeSnippet}}.
I hold a {{gtMethod:LeWordSnippet>>#word|label=#selector}} and its {{gtMethod:LeWordSnippet>>#explanation|label=#selector}}.
## Examples
### Snippet without explanation
The following example shows a snippet with the {{gtExample:LeWordExamples>>#word|label}} word. By pressing the Enter key or pressing the search button, it searches the word explanation.
{{gtExample:LeWordExamples>>#snippet|codeExpanded=false|previewExpanded=true}}
### Snippet with a word explanation
{{gtExample:LeWordExamples>>#snippetWithExplanation|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #LeWordSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'word',
		'explanation',
		'explanationAttachmentName'
	],
	#category : #'Lepiter-Snippet-Words-Snippet'
}

{ #category : #'api - accessing menu' }
LeWordSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LeWordSnippet class >> description [
	^ 'Word explanation'
]

{ #category : #factory }
LeWordSnippet class >> empty [
	^ self new
]

{ #category : #accessing }
LeWordSnippet class >> explanationAttachmentFileName [
	^ 'word-snippet-explanation.json'
]

{ #category : #'lepiter-store' }
LeWordSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#word -> #wordString);
		add: (#explanationAttachmentName -> #explanationAttachmentNameString);
		yourself
]

{ #category : #'lepiter-store' }
LeWordSnippet class >> leJsonV3Name [

	^ 'wordSnippet'
]

{ #category : #'lepiter-store' }
LeWordSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#word -> #wordString);
		add: (#explanationAttachmentName -> #explanationAttachmentNameString);
		yourself
]

{ #category : #'lepiter-store' }
LeWordSnippet class >> leJsonV4Name [

	^ 'wordSnippet'
]

{ #category : #visiting }
LeWordSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitWordSnippet: self
]

{ #category : #'private - announcing' }
LeWordSnippet >> announceExplanationChangedBy: aSource [
	self notifyAnnouncement: (LeWordSnippetExplanationChangedAnnouncement new
		source: aSource;
		snippet: self;
		explanation: self explanation)
]

{ #category : #'private - announcing' }
LeWordSnippet >> announceWordChangedBy: aSource [
	self notifyAnnouncement: (LeWordSnippetWordChangedAnnouncement new
		source: aSource;
		snippet: self;
		word: self word)
]

{ #category : #converting }
LeWordSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeWordSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeWordSnippet >> attachmentNames [
	^ self explanationAttachmentName 
		ifNotNil: [ :aName | {aName} ] 
		ifNil: [ #() ]
]

{ #category : #accessing }
LeWordSnippet >> contentAsString [
	^ String
		streamContents: [ :aStream | 
			aStream
				nextPutAll: (self explanation
						ifNotNil: #word
						ifNil: [ self word ifNotNil: #asString ifNil: [ '' ] ]) ]
]

{ #category : #'api - accessing' }
LeWordSnippet >> explanation [
	<return: #LeWordExplanation>
	^ explanation
]

{ #category : #'api - accessing' }
LeWordSnippet >> explanation: anExplanation [
	self explanation: anExplanation source: nil.
]

{ #category : #'api - accessing' }
LeWordSnippet >> explanation: anExplanation source: aSource [

	self
		assert: [ anExplanation isNotNil ]
		description: [ 'Explanation must be non-nil' ].
	(explanation isNil or: [ explanation = anExplanation ]) ifTrue: [ 
		explanation := anExplanation.
		self updateCachedExplanationBy: aSource.
		^ self ].

	explanation := anExplanation.

	self updateCachedExplanationBy: aSource.
	self announceExplanationChangedBy: aSource
]

{ #category : #'private - updating' }
LeWordSnippet >> explanationAttachmentFileName [
	^ self class explanationAttachmentFileName
]

{ #category : #'api - accessing' }
LeWordSnippet >> explanationAttachmentName [
	^ explanationAttachmentName
]

{ #category : #'api - accessing' }
LeWordSnippet >> explanationAttachmentName: aString [
	self explanationAttachmentName: aString source: nil
]

{ #category : #'api - accessing' }
LeWordSnippet >> explanationAttachmentName: aString source: aSource [
	self explanationAttachmentName = aString
		ifTrue: [ ^ self ].
	explanationAttachmentName := aString.
]

{ #category : #'gt-extensions' }
LeWordSnippet >> gtDefinitionsFor: aView [
	<gtView>
	explanation ifNil: [ ^ aView empty ].
	^ explanation gtDefinitionsFor: aView 
]

{ #category : #'gt-extensions' }
LeWordSnippet >> gtUIExplanationFor: aView [
	<gtView>
	explanation ifNil: [ ^ aView empty ].
	^ explanation gtUIExplanationFor: aView 
]

{ #category : #accessing }
LeWordSnippet >> gtViewAttachmentsFor: aView [
	<gtView>
	self explanationAttachmentName ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Attachments';
		items: [ { self database 
			resolveDbFile: (Path  *self explanationAttachmentName) parent pathString } ];
		column: 'ID' text: #basename;
		column: 'Name' text: [ :aDirectory | 
			| allFiles |
			allFiles := aDirectory files select: [ :aFile | 
				aFile basename ~= LeAttachment basename ].
			allFiles size = 1
				ifTrue: [ allFiles first basename ]
				ifFalse: [ allFiles size asString, ' attachments' ] ]
]

{ #category : #'gt-extensions' }
LeWordSnippet >> gtViewExplanationRawDataFor: aView [
	<gtView>
	explanation ifNil: [ ^ aView empty ].
	^ (explanation gtRawDataFor: aView)
		title: 'Explanation raw data' 
]

{ #category : #testing }
LeWordSnippet >> hasWord [
	^ self word notNil
]

{ #category : #initialization }
LeWordSnippet >> initialize [
	super initialize.
	word := ''.
]

{ #category : #'private - exporting' }
LeWordSnippet >> markdownOn: stream level: anInteger [
	anInteger * 4 timesRepeat: [ stream nextPut: Character space ].
	stream
		<< '- ';
		<< self contentAsString trimBoth.
	self
		childrenDo: [ :child | 
			stream cr.
			child markdownOn: stream level: anInteger + 1 ]
]

{ #category : #'api - accessing' }
LeWordSnippet >> onAddedToDatabase [
	super onAddedToDatabase.
	self explanationAttachmentName ifNil: [ ^ self ].
	self readCachedExplanationBy: nil.
]

{ #category : #printing }
LeWordSnippet >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '(';
		nextPutAll: (self word ifNil: [ '<nil>']);
		nextPutAll: ')'
]

{ #category : #'private - updating' }
LeWordSnippet >> readCachedExplanationBy: aSource [
	LeStoreAttachmentReader new
		database: self database;
		attachmentName: self explanationAttachmentName;
		reader: [ :aBinaryContent | 
			| anArray |
			anArray := STON fromString: aBinaryContent utf8Decoded.
			self 
				explanation: (LeWordExplanation new 
					word: anArray first;
					rawData: anArray second)
				source: aSource ];
		read
]

{ #category : #accessing }
LeWordSnippet >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new word: '.
	self word storeOn: aStream.
	aStream nextPutAll: '; explanation: '.
	self explanation storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'private - updating' }
LeWordSnippet >> updateCachedExplanationBy: aSource [
	LeStoreAttachmentWriter new
		database: self database;
		attachmentName: self explanationAttachmentName;
		contentName: self explanationAttachmentFileName;
		content: [ STONJSON
				toString: (Array with: self explanation word with: self explanation rawData) ];
		writer: [ :anAttachmentName | self explanationAttachmentName: anAttachmentName source: aSource ];
		write
]

{ #category : #'api - accessing' }
LeWordSnippet >> word [
	^ word
]

{ #category : #'api - accessing' }
LeWordSnippet >> word: aWordString [
	self word: aWordString source: nil
]

{ #category : #'api - accessing' }
LeWordSnippet >> word: aWordString source: aSource [
	self 
		assert: [ aWordString isNotNil ]
		description: [ 'Word must be non-nil' ].

	word = aWordString
		ifTrue: [ ^ self ].
	word := aWordString.
	
	self announceWordChangedBy: aSource
]
