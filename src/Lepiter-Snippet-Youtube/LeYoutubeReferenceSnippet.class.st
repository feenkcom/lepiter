Class {
	#name : #LeYoutubeReferenceSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'urlString',
		'leRawYoutubeReferenceInfo'
	],
	#category : #'Lepiter-Snippet-Youtube-Model'
}

{ #category : #accessing }
LeYoutubeReferenceSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #accessing }
LeYoutubeReferenceSnippet class >> description [
	^ 'Youtube'
]

{ #category : #accessing }
LeYoutubeReferenceSnippet class >> empty [ 
	^ self new youtubeUrl: ''.
]

{ #category : #accessing }
LeYoutubeReferenceSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: (#youtubeUrl -> #youtubeUrl);
		yourself 
]

{ #category : #accessing }
LeYoutubeReferenceSnippet class >> leJsonV4Name [
	^ 'youtubeSnippet'
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> acceptVisitor: aVisitor [
	^ aVisitor visitYoutubeReferenceSnippet: self
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeYoutubeReferenceViewModel new snippetModel: self
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> authorName [
	^ self leRawYoutubeReferenceInfo authorName
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> authorUrl [
	^ leRawYoutubeReferenceInfo authorUrl
]

{ #category : #testing }
LeYoutubeReferenceSnippet >> canMoveToAnotherDatabase [
	^ true
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> contentAsString [
	^ urlString
]

{ #category : #views }
LeYoutubeReferenceSnippet >> gtHtmlIFrame16per9For: aView [
	<gtView>
	^ aView textEditor
		title: 'HTML';
		priority: 2;
		text: [ self htmlIFrame16per9 ]
]

{ #category : #views }
LeYoutubeReferenceSnippet >> gtVideoInfoFor: aView [
	<gtView>
	self leRawYoutubeReferenceInfo ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Video info';
		object: [ 
			self leRawYoutubeReferenceInfo ];
		view: #gtRawDataFor:
]

{ #category : #views }
LeYoutubeReferenceSnippet >> gtYoutubeInfoFor: aView [
	<gtView>
	^ aView forward
		title: 'Youtube Info';
		priority: 3;
		object: [ self leRawYoutubeReferenceInfo ];
		view: #gtRawDataFor:
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> html [
	^ self leRawYoutubeReferenceInfo html
]

{ #category : #'as yet unclassified' }
LeYoutubeReferenceSnippet >> htmlIFrame16per9 [
	^ '<iframe 
	style="aspect-ratio: 16 / 9; height: 100%;" 
	src="https://www.youtube.com/embed/' , self videoIdAndStart
		, '" 
	title="YouTube video player" 
	frameborder="0" 
	allow="accelerometer;autoplay;clipboard-write;encrypted-media;gyroscope;picture-in-picture;web-share"
	referrerpolicy="strict-origin-when-cross-origin" 
	allowfullscreen>
</iframe>'
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> leRawYoutubeReferenceInfo [
	^ leRawYoutubeReferenceInfo ifNil: [
		leRawYoutubeReferenceInfo := LeRawYoutubeReferenceInfo fromYoutubeStringUrl: urlString]
]

{ #category : #'private - exporting' }
LeYoutubeReferenceSnippet >> markdownOn: stream level: anInteger [
	anInteger * 4 timesRepeat: [ stream nextPut: Character space ].
	stream
		cr;
		<< '['; << self title; <<  ']('; << (self youtubeUrl); << ')';
		cr
]

{ #category : #printing }
LeYoutubeReferenceSnippet >> storeOn: aStream [
	aStream nextPutAll: '(LeYoutubeReferenceSnippet new urlString: '.
	self urlString storeOn: aStream.
	aStream nextPutAll: '; yourself)'
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> thumbnailUrl [
	^ self leRawYoutubeReferenceInfo thumbnailUrl
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> title [
	^ self leRawYoutubeReferenceInfo title
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> urlString [
	^ urlString
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> urlString: aString [

	^ self urlString: aString source: self
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> urlString: aString source: anObject [
	"Change the url string of a picture.
	The String may not neccessarily be a fully valid URL"
	self
		assert: [ aString notNil ]
		description: [ 'URL string must not be nil' ].

	self urlString = aString
		ifTrue: [ ^ self ].

	urlString := aString.
	
	leRawYoutubeReferenceInfo := LeRawYoutubeReferenceInfo fromYoutubeStringUrl: aString.
	self updateEditTimeAndEmail.
	self announceContentChangedBy: anObject
]

{ #category : #'as yet unclassified' }
LeYoutubeReferenceSnippet >> urlStringUtility [
	| db rootDir |
	db := self database.

	rootDir := (db isDatabase not or: [ db monitor isNil ])
			ifTrue: [ FileLocator workingDirectory resolve ]
			ifFalse: [ db monitor localRoot ].

	urlString := self urlString.
	^ GtUrlStringUtility new
		rootDirectory: rootDir;
		urlString: urlString
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> videoId [
	^ LeYoutubeUrl new
		string: self urlString;
		videoId
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> videoIdAndStart [
	^ LeYoutubeUrl new
		string: self urlString;
		videoIdAndStart
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> youtubeUrl [
	^ urlString
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> youtubeUrl: aString [
	urlString := aString
]
