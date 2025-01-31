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

{ #category : #accessing }
LeYoutubeReferenceSnippet >> gtYoutubeReferenceInfoFor: aView [
	<gtView>
	^ self leRawYoutubeReferenceInfo gtYoutubeReferenceInfoFor: aView.
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> html [
	^ self leRawYoutubeReferenceInfo html
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

{ #category : #accessing }
LeYoutubeReferenceSnippet >> youtubeUrl [
	^ urlString
]

{ #category : #accessing }
LeYoutubeReferenceSnippet >> youtubeUrl: aString [
	urlString := aString
]
