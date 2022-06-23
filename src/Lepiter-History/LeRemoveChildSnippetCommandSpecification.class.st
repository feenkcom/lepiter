Class {
	#name : #LeRemoveChildSnippetCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'childUid'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeRemoveChildSnippetCommandSpecification >> childUid [

	^ childUid
]

{ #category : #accessing }
LeRemoveChildSnippetCommandSpecification >> childUid: anObject [

	childUid := anObject
]
