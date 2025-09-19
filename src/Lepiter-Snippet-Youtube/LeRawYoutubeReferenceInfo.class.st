Class {
	#name : #LeRawYoutubeReferenceInfo,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'Lepiter-Snippet-Youtube-Model'
}

{ #category : #accessing }
LeRawYoutubeReferenceInfo class >> fromYoutubeStringUrl: aYoutubeStringUrl [
	| response embedUrl |
	embedUrl := 'https://www.youtube.com/oembed?url=' , aYoutubeStringUrl
		, '&format=json'.
	[ response := ZnClient new forJsonREST get: embedUrl ]
		on: NeoJSONParseError
		do: [ response := nil ].
	^ self new rawData: response
]

{ #category : #accessing }
LeRawYoutubeReferenceInfo >> authorName [
	^ rawData ifNotNil: [:rd | rd at: 'author_name' ]  ifNil: [nil]
]

{ #category : #accessing }
LeRawYoutubeReferenceInfo >> authorUrl [
	^ rawData ifNotNil: [:rd | rd at: 'author_url' ]  ifNil: [nil]
]

{ #category : #views }
LeRawYoutubeReferenceInfo >> gtRawDataFor: aView [
	<gtView>
	self rawData ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Raw data';
		items: [ [
			self rawData ] value associations ];
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ]
]

{ #category : #accessing }
LeRawYoutubeReferenceInfo >> html [
	^ rawData ifNotNil: [:rd | rd at: 'html' ]  ifNil: [nil]
]

{ #category : #accessing }
LeRawYoutubeReferenceInfo >> rawData [
	^ rawData 
]

{ #category : #accessing }
LeRawYoutubeReferenceInfo >> rawData: response [ 
	rawData := response
]

{ #category : #accessing }
LeRawYoutubeReferenceInfo >> thumbnailUrl [
	^ rawData ifNotNil: [:rd | rd at: 'thumbnail_url' ]  ifNil: [nil]
]

{ #category : #accessing }
LeRawYoutubeReferenceInfo >> title [
	^ rawData ifNotNil: [:rd | rd at: 'title' ]  ifNil: [nil]
]
