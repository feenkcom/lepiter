Extension { #name : #STONJSON }

{ #category : #'*Lepiter-Store' }
STONJSON class >> prettyPrint: aString [ 
	"Pretty print the supplied string"

	^ self toStringPretty: (self fromString: aString)
]
