Extension { #name : #MemoryFileWriteStream }

{ #category : #'*Lepiter-Store' }
MemoryFileWriteStream >> truncate [ 

	stream ifNotNil: [ stream truncate ]
]
