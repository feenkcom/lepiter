"
I am a ${class:LeSnippet}$.
I hold a ${method:LeWordSnippet>>#word|label=#selector}$ and its ${method:LeWordSnippet>>#explanation|label=#selector}$.
!! Examples
!!! Snippet without explanation
The following example shows a snippet with the ${example:LeWordExamples>>#word|label}$ word. By pressing the Enter key or pressing the search button, it searches the word explanation.
${example:LeWordExamples>>#snippet|codeExpanded=false|previewExpanded=true}$
!!! Snippet with a word explanation
${example:LeWordExamples>>#snippetWithExplanation|codeExpanded=false|previewExpanded=true}$

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
LeWordSnippet class >> contextMenuItemSpefication [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'Word explanation'
]

{ #category : #factory }
LeWordSnippet class >> empty [
	^ self new
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
LeWordSnippet >> attachments [
	^ {LeAttachment loadFromFolder: (self database 
		resolveDbFile: (Path  *self explanationAttachmentName) parent pathString )}
]

{ #category : #'api - accessing' }
LeWordSnippet >> contentAsString [
	^ self word
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

	explanation == anExplanation
		ifTrue: [ ^ self ].

	explanation := anExplanation.

	self updateCachedExplanationBy: aSource.
	self announceExplanationChangedBy: aSource.
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
		column: 'ID' item: #basename;
		column: 'Name' item: [ :aDirectory | 
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
		title: 'Explanation Raw Data' 
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
		reader: [ :aContent | 
			| anArray |
			anArray := STON fromString: aContent.
			self 
				explanation: (LeWordExplanation new 
					word: anArray first;
					rawData: anArray second)
				source: aSource ];
		read
]

{ #category : #'private - updating' }
LeWordSnippet >> updateCachedExplanationBy: aSource [
	LeStoreAttachmentWriter new
		database: self database;
		attachmentName: self explanationAttachmentName;
		contentName: 'word-snippet-explanation.json';
		content: [ STONJSON toString: (Array 
			with: self explanation word
			with: self explanation rawData) ];
		writer: [ :anAttachmentName | 
			self explanationAttachmentName: anAttachmentName source: aSource ];
		write.
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
