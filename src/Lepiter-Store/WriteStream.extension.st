Extension { #name : 'WriteStream' }

{ #category : '*Lepiter-Store' }
WriteStream >> truncate [ 

	readLimit := readLimit min: writeLimit
]
