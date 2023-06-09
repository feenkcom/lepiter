Class {
	#name : #LeAttachedLink,
	#superclass : #LeExplicitLink,
	#instVars : [
		'storageDatabase',
		'originReference',
		'targetReference',
		'createEmail',
		'createTime'
	],
	#category : #'Lepiter-Core-Links'
}

{ #category : #accessing }
LeAttachedLink >> createEmail [
	^ createEmail
]

{ #category : #accessing }
LeAttachedLink >> createEmail: anObject [
	createEmail := anObject
]

{ #category : #accessing }
LeAttachedLink >> createTime [
	^ createTime
]

{ #category : #accessing }
LeAttachedLink >> createTime: anObject [
	createTime := anObject
]

{ #category : #accessing }
LeAttachedLink >> database [
	^ storageDatabase
]

{ #category : #accessing }
LeAttachedLink >> database: aDatabase [
	self assert: [ aDatabase notNil and: [ storageDatabase isNil ] ].
	storageDatabase := aDatabase
]

{ #category : #printing }
LeAttachedLink >> description [
	^ String streamContents: [ :aStream | .
		aStream 
			nextPutAll: '(origin: ';
			print: self originReference description;
			nextPutAll: ', target: ';
			print: self targetReference description;
			nextPutAll: ')' ]
]

{ #category : #accessing }
LeAttachedLink >> editEmail [
	"Attached links cannot be currently edited."
	^ self createEmail
]

{ #category : #accessing }
LeAttachedLink >> editTime [
	"Attached links cannot be currently edited."
	^ self createTime
]

{ #category : #testing }
LeAttachedLink >> isAttachedLink [
	^ true
]

{ #category : #callbacks }
LeAttachedLink >> onAboutToAddToDatabase: aDatabase [
	self assert: [ self database isNil ].
	super onAboutToAddToDatabase: aDatabase.
	
	self createEmail ifNil: [
		self createEmail: aDatabase userEmail ].
	self createTime ifNil: [
		self createTime: LeTime now ].
]

{ #category : #callbacks }
LeAttachedLink >> onAddedToDatabase: aDatabase [
	self assert: [ self database isNil ] description: 'There should be no database explicitly set'.
	super onAddedToDatabase: aDatabase.
	
	self database: aDatabase.
	self resolveReferences
]

{ #category : #accessing }
LeAttachedLink >> originReference [
	^ originReference
]

{ #category : #accessing }
LeAttachedLink >> originReference: aLinkReference [
	self assert: [ aLinkReference notNil and: [ originReference isNil ] ].
	self assert: [ aLinkReference explicitLink isNil ].
	
	originReference := aLinkReference.
	originReference explicitLink: self.
]

{ #category : #printing }
LeAttachedLink >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: '(origin: ';
		print: self originReference description;
		nextPutAll: ', target: ';
		print: self targetReference description;
		nextPutAll: ')'
]

{ #category : #actions }
LeAttachedLink >> reloadFromExternalLink: anotherAttachedLink [
	"Currently no changes of links during reloading are supported.
	Normally this should not happen as now it is not posssibe to change links from the UI"
	self assert: [ anotherAttachedLink notNil ].
	self 
		assert: [ anotherAttachedLink isAttachedLink ]
		description: 'Only attached links can be used to reload the content'.
		
	self assert: [ self originReference matches: anotherAttachedLink originReference ].
	self assert: [ self targetReference matches: anotherAttachedLink targetReference ].
]

{ #category : #actions }
LeAttachedLink >> resolveReferences [
	self originReference resolveReference.
	self targetReference resolveAndLinkReference.
]

{ #category : #accessing }
LeAttachedLink >> targetReference [
	^ targetReference
]

{ #category : #accessing }
LeAttachedLink >> targetReference: aLinkReference [
	self assert: [ aLinkReference notNil and: [ targetReference isNil ] ].
	self assert: [ aLinkReference explicitLink isNil ].
	
	targetReference := aLinkReference.
	targetReference explicitLink: self.
]

{ #category : #actions }
LeAttachedLink >> unlinkReferences [
	self targetReference unlink.
]
