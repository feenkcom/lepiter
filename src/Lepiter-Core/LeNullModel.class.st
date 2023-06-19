Class {
	#name : #LeNullModel,
	#superclass : #LeModel,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Core-Model'
}

{ #category : #testing }
LeNullModel >> isNullObject [
	^ true
]

{ #category : #'announcer - subscription' }
LeNullModel >> unsubscribe: anObject [
	"Null models don't do anything, so ignore any announcement requests"
]

{ #category : #'announcer - subscription' }
LeNullModel >> when: anAnnouncementClass send: aSelector to: anObject [
	"Null models don't do anything, so ignore any announcement requests"
]
