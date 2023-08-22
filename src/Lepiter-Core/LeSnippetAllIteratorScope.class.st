Class {
	#name : #LeSnippetAllIteratorScope,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #printing }
LeSnippetAllIteratorScope >> gtDisplayOn: stream [
	stream nextPutAll: 'content and its children tree hiearchy attachments'
]
