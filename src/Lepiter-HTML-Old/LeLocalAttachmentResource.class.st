Class {
	#name : #LeLocalAttachmentResource,
	#superclass : #LePageResource,
	#instVars : [
		'fileReference'
	],
	#category : #'Lepiter-HTML-Old-Exporter'
}

{ #category : #accessing }
LeLocalAttachmentResource >> fileReference [
	^ fileReference
]

{ #category : #accessing }
LeLocalAttachmentResource >> fileReference: anObject [
	fileReference := anObject
]
