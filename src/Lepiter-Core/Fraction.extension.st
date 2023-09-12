Extension { #name : #Fraction }

{ #category : #'*Lepiter-Core' }
Fraction >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeObject: self
]
