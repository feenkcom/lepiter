Extension { #name : #Symbol }

{ #category : #'*Lepiter-Core' }
Symbol >> lepiterReferences [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
		inject: #() asAsyncStream
		into: [ :sum :each | sum merge: (each asyncSnippetReferencesTo: self) ]
]

{ #category : #'*Lepiter-Core' }
Symbol >> lepiterSenders [
	^ self lepiterReferences
]
