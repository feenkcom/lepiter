Class {
	#name : #LeExportFilenameHypertextReferenceBuilder,
	#superclass : #Object,
	#traits : 'TLeExportHypertextReferenceBuilder',
	#classTraits : 'TLeExportHypertextReferenceBuilder classTrait',
	#category : #'Lepiter-Export-Page Links - Builders'
}

{ #category : #accessing }
LeExportFilenameHypertextReferenceBuilder class >> optionValue [
	"Return a value that can be used to define builders from command line."

	<return: #String or: nil>
	^ 'filename'
]

{ #category : #'api - building' }
LeExportFilenameHypertextReferenceBuilder >> hrefFromPageLink: aPageLink [
	<return: #String>
	^ aPageLink fileName
]
