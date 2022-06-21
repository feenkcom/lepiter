Class {
	#name : #LeCommandSpecification,
	#superclass : #Object,
	#instVars : [
		'commandUid',
		'contentUid'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeCommandSpecification >> commandUid [

	^ commandUid
]

{ #category : #accessing }
LeCommandSpecification >> commandUid: anUid [

	commandUid := anUid
]

{ #category : #accessing }
LeCommandSpecification >> contentUid [

	^ contentUid
]

{ #category : #accessing }
LeCommandSpecification >> contentUid: anUid [

	contentUid := anUid
]
