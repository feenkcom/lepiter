Class {
	#name : #LeContentAllIteratorScope,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Core-Attachments'
}

{ #category : #printing }
LeContentAllIteratorScope >> gtDisplayOn: stream [
	stream nextPutAll: 'content and its children tree hierarchy attachments'
]
