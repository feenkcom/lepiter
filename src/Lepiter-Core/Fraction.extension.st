Extension { #name : #Fraction }

{ #category : #'*Lepiter-Core' }
Fraction >> neoJsonOn: neoJSONWriter [
	"Write the receiver with the supplied writer"

	"If there is a specific mapping for the receiver, use that instead of the general collection"
	^ (neoJSONWriter mappingFor: self class ifAbsent: [ nil ])
		ifNotNil: [ neoJSONWriter writeObject: self ]
		ifNil: [ super neoJsonOn: neoJSONWriter ]
]
