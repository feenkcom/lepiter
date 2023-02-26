Extension { #name : #XdManifest }

{ #category : #'*Lepiter-XDoc' }
XdManifest >> hasLepiterPage [
	<return: #Boolean>
	^ self documents 
		anySatisfy: [ :eachDocument | eachDocument type = LeXdPageType  ]
]
