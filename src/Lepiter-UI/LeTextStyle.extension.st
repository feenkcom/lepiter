Extension { #name : #LeTextStyle }

{ #category : #'*Lepiter-UI' }
LeTextStyle >> styleText: aText using: aLeBlockStyler [
	aLeBlockStyler
		styleText: aText 
		body: self 
]
