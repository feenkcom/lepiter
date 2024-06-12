Class {
	#name : #LeWardleyMapNodeReference,
	#superclass : #LeLinkSnippetUidReference,
	#instVars : [
		'nodeUUID'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Snippet'
}

{ #category : #'lepiter-store' }
LeWardleyMapNodeReference class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#nodeUUID -> #nodeUUID);
		yourself
]

{ #category : #'lepiter-store' }
LeWardleyMapNodeReference class >> leJsonV3Name [

	^ 'wardleyMapNodeReference'
]

{ #category : #'lepiter-store' }
LeWardleyMapNodeReference class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#nodeUUID -> #nodeUUID);
		yourself
]

{ #category : #'lepiter-store' }
LeWardleyMapNodeReference class >> leJsonV4Name [

	^ 'wardleyMapNodeReference'
]

{ #category : #testing }
LeWardleyMapNodeReference >> description [
	^ 'Wardley Map node reference: ', (self nodeUUID asString)
]

{ #category : #testing }
LeWardleyMapNodeReference >> matches: anotherObject [
	^ (super matches: anotherObject) and: [ 
			self nodeUUID = anotherObject nodeUUID ]
]

{ #category : #accessing }
LeWardleyMapNodeReference >> nodeUUID [
	^ nodeUUID
]

{ #category : #accessing }
LeWardleyMapNodeReference >> nodeUUID: anObject [
	nodeUUID := anObject
]

{ #category : #actions }
LeWardleyMapNodeReference >> resolveInDatabase: aDatabase [
	super resolveInDatabase: aDatabase.
	self content ifNil: [ ^ self ].
	
	self flag: #hack.
	self explicitLink targetReference content
		ifNil: [ self explicitLink targetReference resolveAndLinkReference ].
	self explicitLink targetReference content 
		ifNil: [ ^ self ].
	self content updateWardleyMapDecorators.
]
