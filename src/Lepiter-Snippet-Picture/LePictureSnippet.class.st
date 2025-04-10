Class {
	#name : #LePictureSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'urlString',
		'caption',
		'previewHeight',
		'reference'
	],
	#category : #'Lepiter-Snippet-Picture-Snippet'
}

{ #category : #accessing }
LePictureSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		priority: 3;
		snippetClass: self;
		title: self description
]

{ #category : #accessing }
LePictureSnippet class >> description [
	^ 'Picture'
]

{ #category : #factory }
LePictureSnippet class >> empty [ 

	^ self new
]

{ #category : #jsonV3 }
LePictureSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#urlString -> #url);
		add: (#caption -> #caption);
		add: (#previewHeight -> #previewHeight);
		add: (#reference -> #reference);
		yourself
]

{ #category : #accessing }
LePictureSnippet class >> leJsonV3Name [

	^ 'pictureSnippet'
]

{ #category : #jsonV3 }
LePictureSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#urlString -> #url);
		add: (#caption -> #caption);
		add: (#previewHeight -> #previewHeight);
		add: (#reference -> #reference);
		yourself
]

{ #category : #accessing }
LePictureSnippet class >> leJsonV4Name [

	^ 'pictureSnippet'
]

{ #category : #visiting }
LePictureSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitPictureSnippet: self
]

{ #category : #accessing }
LePictureSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LePictureSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LePictureSnippet >> attachmentNames [
	self urlStringUtility isFile ifFalse: [ ^ #() ].
	(self urlString beginsWith: LeLocalStore attachmentsDirectoryName) ifFalse: [ ^ #() ].

	^ Array with: self urlString
]

{ #category : #accessing }
LePictureSnippet >> caption [ 
	<return: #String>

	^ caption
]

{ #category : #accessing }
LePictureSnippet >> caption: aString [

	^ self caption: aString source: self
]

{ #category : #accessing }
LePictureSnippet >> caption: aString source: aSource [
	"Change the picture caption."
	self
		assert: [ aString notNil ]
		description: [ 'Caption must be non-nil' ].

	self caption = aString
		ifTrue: [ ^ self ].

	caption := aString.
	self updateEditTimeAndEmail.
	self announceContentChangedBy: aSource
]

{ #category : #'api - accessing' }
LePictureSnippet >> contentAsString [
	^ urlString
]

{ #category : #'private - updating' }
LePictureSnippet >> createReference [
	self database ifNil: [ ^ self ].
	self database isDatabase ifFalse: [ ^ self ].
	self assert: self hasReference not.

	self reference: self database pictureReferenceNextId
]

{ #category : #'api - testing' }
LePictureSnippet >> hasCaption [
	^ self caption isNotNil and: [ self caption trimBoth isNotEmpty ]
]

{ #category : #accessing }
LePictureSnippet >> hasContent [
	^ self urlString isNotEmpty or: [ self caption isNotEmpty ]
]

{ #category : #testing }
LePictureSnippet >> hasReference [
	^ self reference isNotNil and: [ self reference isNotEmpty ]
]

{ #category : #initialization }
LePictureSnippet >> initialize [
	super initialize.

	urlString := ''.
	caption := ''.
	previewHeight := 0.
	reference := ''
]

{ #category : #testing }
LePictureSnippet >> isPictureSnippet [
	^ true
]

{ #category : #testing }
LePictureSnippet >> isPictureSnippetWithReference: aReference [
	"Return true if aReference is same as #reference.
	aReference is a String instance."

	^ self hasReference and: [ self reference = aReference ]
]

{ #category : #'private - exporting' }
LePictureSnippet >> markdownOn: stream level: anInteger [
	"Write the receiver as an HTML string on the supplied stream.
	This is currently a simplistic implementation which doesn't handle line breaks within the block properly (they need to be indented)"

	self isEmpty ifTrue: [ ^ self ].

	anInteger * 4 timesRepeat:
		[ stream nextPut: Character space ].
	stream 
		<< '- ';
		<< self urlString trimBoth.

	self childrenDo: [ :child |
		stream cr.
		child markdownOn: stream level: anInteger + 1 ]
]

{ #category : #accessing }
LePictureSnippet >> pictureFileBytes [
	^ self urlString asFileReference binaryReadStream upToEnd.
]

{ #category : #accessing }
LePictureSnippet >> previewHeight [ 
	<return: #Number>

	^ previewHeight ifNil: [ 0 ]
]

{ #category : #accessing }
LePictureSnippet >> previewHeight: aString [

	^ self previewHeight: aString source: self
]

{ #category : #accessing }
LePictureSnippet >> previewHeight: aNumber source: aSource [
	"Change the picture preview height."
	self
		assert: [ aNumber notNil ]
		description: [ 'Preview height must be non-nil' ].
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Preview height must be equal or greater than 0' ].
	
	(self previewHeight closeTo: aNumber precision: 0.1)
		ifTrue: [ ^ self ].

	previewHeight := aNumber.
	self updateEditTimeAndEmail.
	self announceContentChangedBy: aSource
]

{ #category : #accessing }
LePictureSnippet >> reference [ 
	<return: #String>

	^ reference
]

{ #category : #accessing }
LePictureSnippet >> reference: aString [
	self reference: aString source: self
]

{ #category : #accessing }
LePictureSnippet >> reference: aString source: aSource [
	"Change the picture reference.
	The reference is a name that can be used to reference pictures in other parts, e.g., a text.
	For example: {{gtFigure:ref=figure1}}"
	self
		assert: [ aString notNil ]
		description: [ 'Reference must be non-nil' ].

	self reference = aString
		ifTrue: [ ^ self ].

	reference := aString.
	self updateEditTimeAndEmail.
	self announceContentChangedBy: aSource
]

{ #category : #printing }
LePictureSnippet >> storeOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new urlString: '.
	self urlString storeOn: aStream.
	aStream nextPutAll: '; caption: '.
	self caption storeOn: aStream.
	aStream nextPutAll: '; previewHeight: '.
	self previewHeight storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
LePictureSnippet >> urlString [ 
	<return: #String>

	^ urlString
]

{ #category : #accessing }
LePictureSnippet >> urlString: aString [

	^ self urlString: aString source: self
]

{ #category : #accessing }
LePictureSnippet >> urlString: aString source: anObject [
	"Change the url string of a picture.
	The String may not neccessarily be a fully valid URL"
	self
		assert: [ aString notNil ]
		description: [ 'URL string must not be nil' ].

	self urlString = aString
		ifTrue: [ ^ self ].

	urlString := aString.
	self updateEditTimeAndEmail.
	self announceContentChangedBy: anObject
]

{ #category : #'api - utility' }
LePictureSnippet >> urlStringUtility [
	<return: #GtUrlStringUtility>
	^ LeUrlStringUtilityBuilder new
		database: self database;
		urlString: self urlString;
		build;
		urlStringUtility
]
