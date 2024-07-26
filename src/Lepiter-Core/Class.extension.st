Extension { #name : #Class }

{ #category : #'*Lepiter-Core' }
Class >> lepiterReferences [
	^ LeSearchClassReferencesFilter forClass: self
]
