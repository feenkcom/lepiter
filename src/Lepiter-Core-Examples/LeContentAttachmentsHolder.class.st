Class {
	#name : #LeContentAttachmentsHolder,
	#superclass : #Object,
	#instVars : [
		'attachments',
		'content',
		'temporaryDatabase'
	],
	#category : #'Lepiter-Core-Examples-Attachments'
}

{ #category : #accessing }
LeContentAttachmentsHolder >> attachments [
	^ attachments
]

{ #category : #accessing }
LeContentAttachmentsHolder >> attachments: anObject [
	attachments := anObject
]

{ #category : #accessing }
LeContentAttachmentsHolder >> content [
	^ content
]

{ #category : #accessing }
LeContentAttachmentsHolder >> content: anObject [
	content := anObject
]

{ #category : #accessing }
LeContentAttachmentsHolder >> database [
	^ (self content isKindOf: LeDatabase)
		ifTrue: [ self content ]
		ifFalse: [ self content database ]
]

{ #category : #'gt - extensions' }
LeContentAttachmentsHolder >> gtAttachmentsFor: aView [
	<gtView>
	self attachments ifNil: [ ^ aView page ].
	
	^ aView forward
		title: 'Attachments';
		priority: 1;
		object: [ self attachments ];
		view: #gtAttachmentsFor:
]

{ #category : #'gt - extensions' }
LeContentAttachmentsHolder >> gtContentLiveFor: aView [
	<gtView>
	self content ifNil: [ ^ aView page ].
	self content class isAbstract ifTrue: [ ^ aView empty ].

	^ aView forward
		title: 'Live';
		priority: 10;
		object: [ self content ];
		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
LeContentAttachmentsHolder >> gtDatabaseLiveFor: aView [
	<gtView>
	content ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Database';
		priority: 40;
		object: [ self database ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeContentAttachmentsHolder >> temporaryDatabase [
	^ temporaryDatabase
]

{ #category : #accessing }
LeContentAttachmentsHolder >> temporaryDatabase: anObject [
	temporaryDatabase := anObject
]
