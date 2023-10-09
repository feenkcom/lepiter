Trait {
	#name : #TLeExportHypertextReferenceBuilder,
	#category : #'Lepiter-Export-Page Links - Builders'
}

{ #category : #'api - building' }
TLeExportHypertextReferenceBuilder >> hrefFromPageLink: aPageLink [
	"Convert a page link into a hypertext reference."

	<return: #String>
	^ self explicitRequirement
]
