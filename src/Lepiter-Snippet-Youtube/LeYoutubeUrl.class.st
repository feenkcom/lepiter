Class {
	#name : #LeYoutubeUrl,
	#superclass : #Object,
	#instVars : [
		'string',
		'url'
	],
	#category : #'Lepiter-Snippet-Youtube-Support'
}

{ #category : #accessing }
LeYoutubeUrl >> allowedYoutubeHosts [
	^ #('youtube.com' 'youtu.be'
	'www.youtube.com' 'www.youtu.be'
	'm.youtube.com' 'm.youtu.be')
]

{ #category : #accessing }
LeYoutubeUrl >> embedVideoIdAndStart [
	"Return YouTube video start-at position"

	<return: #String>
	^ self videoId
		ifNil: [ ^ '' ]
		ifNotNil: [ :aVideoId | 
			'{1}?start={2}' format: {aVideoId. self startAt} ]
]

{ #category : #'gt - extensions' }
LeYoutubeUrl >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Provided string';
			value: self string.
		GtPhlowOverviewItem new
			name: 'URL';
			value: self url.
		GtPhlowOverviewItem new
			name: 'Is valid YouTube video url';
			if: self isValidYoutubeUrl description: 'Valid YouTube URL';
			if: self isValidYoutubeUrl not
				description: ('Invalid Youtube URL' asRopedText
						foreground: BrGlamorousColors errorBackgroundColor);
			value: self isValidYoutubeUrl.
		GtPhlowOverviewItem new
			name: 'Video ID';
			if: self videoId isNil
				description: (('Invalid video ID: {1}' format: {self videoId}) asRopedText
						foreground: BrGlamorousColors errorBackgroundColor);
			value: self videoId.
		GtPhlowOverviewItem new
			name: 'Start at time [seconds]';
			value: self startAt.
		GtPhlowOverviewItem new
			name: 'Embed video ID and start at time';
			value: self embedVideoIdAndStart}
]

{ #category : #'gt - extensions' }
LeYoutubeUrl >> gtOverviewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		items: [ self gtOverview ];
		column: 'Name' text: #name weight: 0.5;
		column: 'Value' text: #description;
		send: #value
]

{ #category : #testing }
LeYoutubeUrl >> isValidYoutubeUrl [
	^ self url isNotNil
		and: [ (self allowedYoutubeHosts includes: self url host)
				and: [ self videoId isNotNil ] ]
]

{ #category : #accessing }
LeYoutubeUrl >> startAt [
	"Return YouTube video start-at position"

	<return: #String>
	self url ifNil: [ ^ '0' ].
	^ self url hasQuery
		ifTrue: [ self url query at: 't' 
			ifPresent: [ :aString | aString ] 
			ifAbsent: [ '0' ] ]
		ifFalse: [ '0' ]
]

{ #category : #accessing }
LeYoutubeUrl >> string [
	"Return string representing a complete URL"

	<return: #String>
	^ string
]

{ #category : #'api - initialization' }
LeYoutubeUrl >> string: anUrlString [
	string := anUrlString.
	(self allowedYoutubeHosts
		anySatisfy: [ :aHost | anUrlString beginsWith: aHost caseSensitive: false ])
		ifTrue: [
			url := ('https://{1}' format: {anUrlString}) asZnUrl ]
		ifFalse: [
			"Not every arbitrary string is a valid URL" 
			[ url := anUrlString asZnUrl ] on: Error do: [ url := nil ] ]
]

{ #category : #accessing }
LeYoutubeUrl >> url [
	<return: #ZnUrl>
	^ url
]

{ #category : #accessing }
LeYoutubeUrl >> videoId [
	"Return YouTube video ID"

	<return: #String>
	self url ifNil: [ ^ nil ].
	^ self url hasQuery
		ifTrue: [ self url query
				at: 'v'
				ifAbsent: [ self url pathSegments ifNotEmpty: #last ifEmpty: [ nil ] ] ]
		ifFalse: [ self url pathSegments ifNotEmpty: #last ifEmpty: [ nil ] ]
]
