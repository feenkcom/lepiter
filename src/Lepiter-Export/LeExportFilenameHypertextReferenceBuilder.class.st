Class {
	#name : #LeExportFilenameHypertextReferenceBuilder,
	#superclass : #Object,
	#traits : 'TLeExportHypertextReferenceBuilder',
	#classTraits : 'TLeExportHypertextReferenceBuilder classTrait',
	#category : #'Lepiter-Export-Page Links - Builders'
}

{ #category : #'api - building' }
LeExportFilenameHypertextReferenceBuilder >> hrefFromPageLink: aPageLink [
	<return: #String>
	^ aPageLink fileName
]
