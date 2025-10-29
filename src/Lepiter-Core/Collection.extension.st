Extension { #name : #Collection }

{ #category : #'*Lepiter-Core' }
Collection >> asLePages [
	^ LePages new items: self
]
