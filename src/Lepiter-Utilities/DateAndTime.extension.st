Extension { #name : 'DateAndTime' }

{ #category : '*Lepiter-Utilities' }
DateAndTime >> printToMinute [
	"Answer a string YYYY-MM-DD HH:MM"
	^ String streamContents: [ :stream |
		stream
			<< self asDate iso8601;
			space.
		self hour printOn: stream base: 10 length: 2 padded: true.
		stream nextPut: $:.
		self minute printOn: stream base: 10 length: 2 padded: true ]
]
