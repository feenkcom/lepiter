Extension { #name : #Symbol }

{ #category : #'*Lepiter-Core' }
Symbol >> leReferences [
	^ LeSearchReferencesFilter selector: self
]

{ #category : #'*Lepiter-Core' }
Symbol >> leSenders [
	^ self leReferences
]
