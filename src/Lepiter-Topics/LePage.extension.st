Extension { #name : #LePage }

{ #category : #'*Lepiter-Topics' }
LePage >> pageString [
	^ GtLlmLepiterContentExporter new
		page: self;
		export
]
