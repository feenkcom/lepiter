Class {
	#name : #LeDatabaseClassStoreQueueEntry,
	#superclass : #Object,
	#instVars : [
		'monitor'
	],
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #actions }
LeDatabaseClassStoreQueueEntry >> apply [
	"Apply the receiver's changes"

	^ self subclassResponsibility 
]

{ #category : #accessing }
LeDatabaseClassStoreQueueEntry >> monitor [
	^ monitor
]

{ #category : #accessing }
LeDatabaseClassStoreQueueEntry >> monitor: anObject [
	monitor := anObject
]

{ #category : #accessing }
LeDatabaseClassStoreQueueEntry >> pageSelector [

	^ self subclassResponsibility
]
