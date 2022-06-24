Class {
	#name : #LeTransferSnippetChildrenCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'sourceSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeTransferSnippetChildrenCommandSpecification >> sourceSnippet [

	^ sourceSnippet
]

{ #category : #accessing }
LeTransferSnippetChildrenCommandSpecification >> sourceSnippet: anObject [

	sourceSnippet := anObject
]
