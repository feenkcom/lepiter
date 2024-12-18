Class {
	#name : #LeExportFilenameAndExtensionHypertextReferenceBuilder,
	#superclass : #Object,
	#traits : 'TLeExportHypertextReferenceBuilder',
	#classTraits : 'TLeExportHypertextReferenceBuilder classTrait',
	#category : #'Lepiter-Export-Page Links - Builders'
}

{ #category : #accessing }
LeExportFilenameAndExtensionHypertextReferenceBuilder class >> optionValue [
	"Return a value that can be used to define builders from command line."

	<return: #String or: nil>
	^ 'filename+extension'
]

{ #category : #'api - building' }
LeExportFilenameAndExtensionHypertextReferenceBuilder >> hrefFromPageLink: aPageLink [
	<return: #String>
	^ aPageLink fileNameWithExtension
]
