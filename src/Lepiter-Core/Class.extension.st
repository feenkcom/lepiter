Extension { #name : #Class }

{ #category : #'*Lepiter-Core' }
Class >> leReferences [
	^ LeSearchClassReferencesFilter forClass: self
]
