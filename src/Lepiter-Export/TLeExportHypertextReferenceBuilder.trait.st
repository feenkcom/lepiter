Trait {
	#name : #TLeExportHypertextReferenceBuilder,
	#category : #'Lepiter-Export-Page Links - Builders'
}

{ #category : #accessing }
TLeExportHypertextReferenceBuilder classSide >> optionValue [
	"Return a value that can be used to define builders from command line."

	<return: #String or: nil>
	^ nil
]

{ #category : #'api - building' }
TLeExportHypertextReferenceBuilder >> hrefFromPageLink: aPageLink [
	"Convert a page link into a hypertext reference."

	<return: #String>
	^ self explicitRequirement
]
