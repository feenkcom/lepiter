Extension { #name : #ScaledDecimal }

{ #category : #'*Lepiter-Core' }
ScaledDecimal >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeObject: self
]
