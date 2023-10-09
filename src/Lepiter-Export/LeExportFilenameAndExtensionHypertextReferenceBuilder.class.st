Class {
	#name : #LeExportFilenameAndExtensionHypertextReferenceBuilder,
	#superclass : #Object,
	#traits : 'TLeExportHypertextReferenceBuilder',
	#classTraits : 'TLeExportHypertextReferenceBuilder classTrait',
	#category : #'Lepiter-Export-Page Links - Builders'
}

{ #category : #'api - building' }
LeExportFilenameAndExtensionHypertextReferenceBuilder >> hrefFromPageLink: aPageLink [
	<return: #String>
	^ aPageLink fileNameWithExtension
]
