Extension { #name : #DateAndTime }

{ #category : #'*Lepiter-Utilities' }
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

{ #category : #'*Lepiter-Utilities' }
DateAndTime >> printToSeconds [
	"Answer a string YYYY-MM-DD HH:MM:SS"
	^ String streamContents: [:s | 
		self printYMDOn: s.
		s nextPutAll: ' '.
		self printHMSOn: s]
]
