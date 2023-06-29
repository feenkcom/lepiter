Class {
	#name : #LeContentBuilder,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : 'Lepiter-Core-Builders'
}

{ #category : #'private - building' }
LeContentBuilder >> buildEmailFrom: anEmail [
	<return: #LeEmail>
	^ anEmail isString
		ifTrue: [ LeEmail new email: anEmail ]
		ifFalse: [ anEmail ]
]

{ #category : #'private - building' }
LeContentBuilder >> buildPresentTime [
	<return: #LeTime>
	^ LeTime now
]

{ #category : #'private - building' }
LeContentBuilder >> buildTimeFrom: aTime [
	<return: #LeTime>
	^ (aTime isKindOf: LeTime)
		ifTrue: [ aTime ]
		ifFalse: [ LeTime new time: aTime asDateAndTime ]
]

{ #category : #'private - accessing' }
LeContentBuilder >> content [
	<return: #LeContent>
	^ content
]

{ #category : #'api - configuration' }
LeContentBuilder >> createEmail: anEmail [
	| aLeEmail |
	aLeEmail := self buildEmailFrom: anEmail.
	self content createEmail: aLeEmail.
]

{ #category : #'api - configuration' }
LeContentBuilder >> createTime: aTime [
	| aLeTime |
	aLeTime := self buildTimeFrom: aTime.
	self content createTime: aLeTime.
]

{ #category : #'api - configuration' }
LeContentBuilder >> createdBy: anEmail [
	| aLeEmail |
	aLeEmail := self buildEmailFrom: anEmail.
	self createEmail: aLeEmail.
	self editEmail: aLeEmail.
]

{ #category : #'api - configuration' }
LeContentBuilder >> createdNow [
	| aTime |
	aTime := self buildPresentTime.
	self createTime: aTime.
	self editTime: aTime.
]

{ #category : #'api - configuration' }
LeContentBuilder >> createdNowBy: anEmail [
	self 
		createdNow;
		createdBy: anEmail
]

{ #category : #defaults }
LeContentBuilder >> defaultContent [
	<return: #LeContent>
	^ self subclassResponsibility
]

{ #category : #'api - configuration' }
LeContentBuilder >> editEmail: anEmail [
	| aLeEmail |
	aLeEmail := self buildEmailFrom: anEmail.
	self content editEmail: aLeEmail.
]

{ #category : #'api - configuration' }
LeContentBuilder >> editTime: aTime [
	| aLeTime |
	aLeTime := self buildTimeFrom: aTime.
	self content editTime: aLeTime.
]

{ #category : #'api - configuration' }
LeContentBuilder >> editedBy: anEmail [
	| aLeEmail |
	aLeEmail := self buildEmailFrom: anEmail.
	self editEmail: aLeEmail.
]

{ #category : #'api - configuration' }
LeContentBuilder >> editedNow [
	| aTime |
	aTime := self buildPresentTime.
	self editTime: aTime.
]

{ #category : #'api - configuration' }
LeContentBuilder >> editedNowBy: anEmail [
	self 
		editedNow;
		editedBy: anEmail
]

{ #category : #initialization }
LeContentBuilder >> initialize [
	super initialize.
	content := self defaultContent.
]
