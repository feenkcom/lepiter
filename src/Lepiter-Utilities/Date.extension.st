Extension { #name : #Date }

{ #category : #'*Lepiter-Utilities' }
Date >> iso8601 [
	"Answer the receiver printed in ISO 86601 format (YYYY-MM-DD)"

	^ String streamContents: [ :stream |
		BasicDatePrinter default printYMD: self withLeadingSpace: false on: stream ]
]
