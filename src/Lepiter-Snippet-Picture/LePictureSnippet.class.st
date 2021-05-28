Class {
	#name : #LePictureSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'urlString'
	],
	#category : #'Lepiter-Snippet-Picture-Snippet'
}

{ #category : #accessing }
LePictureSnippet class >> contextMenuItemSpefication [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		priority: 3;
		snippetClass: self;
		title: 'Picture'
]

{ #category : #factory }
LePictureSnippet class >> empty [ 

	^ self new
]

{ #category : #jsonV3 }
LePictureSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#urlString -> #url);
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

{ #category : #'api - accessing' }
LePictureSnippet >> contentAsString [
	^ urlString
]

{ #category : #initialization }
LePictureSnippet >> initialize [
	super initialize.

	urlString := ''
]

{ #category : #'api - testing' }
LePictureSnippet >> isEmpty [
	^ super isEmpty and: [ urlString isEmpty ]
]

{ #category : #'api - testing' }
LePictureSnippet >> isNotEmpty [
	^ super isNotEmpty or: [ urlString isNotEmpty ]
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
