Extension { #name : #LeContentCommandExamples }

{ #category : #'*Lepiter-Store' }
LeContentCommandExamples >> assertTargePageIsSerialisable [
	| jsonString|
	jsonString := LeJsonV4 uniqueInstance 
		serializePretty: self targetPage.
	self assert: jsonString notNil.
	
	LeJsonV4 uniqueInstance 
		deserialize: jsonString readStream
]
