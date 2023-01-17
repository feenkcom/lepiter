Class {
	#name : #LeTransferSnippetChildrenCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'sourceSnippetUid'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeTransferSnippetChildrenCommandSpecification >> sourceSnippetUid [

	^ sourceSnippetUid
]

{ #category : #accessing }
LeTransferSnippetChildrenCommandSpecification >> sourceSnippetUid: anUid [

	sourceSnippetUid := anUid
]
