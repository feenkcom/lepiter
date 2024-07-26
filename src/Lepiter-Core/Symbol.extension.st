Extension { #name : #Symbol }

{ #category : #'*Lepiter-Core' }
Symbol >> lepiterReferences [
	^ LeSearchReferencesFilter selector: self
]

{ #category : #'*Lepiter-Core' }
Symbol >> lepiterSenders [
	^ self lepiterReferences
]
