Extension { #name : #LeHeadingStyle }

{ #category : #'*Lepiter-UI' }
LeHeadingStyle >> styleText: aText using: aLeBlockStyler [
	aLeBlockStyler
		styleText: aText 
		heading: self 
]
