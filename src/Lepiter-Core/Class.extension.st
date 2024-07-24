Extension { #name : #Class }

{ #category : #'*Lepiter-Core' }
Class >> lepiterReferences [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases
		inject: #() asAsyncStream
		into: [ :sum :each | sum merge: (each asyncSnippetClassReferencesTo: self name) ]
]
