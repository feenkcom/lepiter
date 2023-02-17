Class {
	#name : #LeLinkPageUidReference,
	#superclass : #LeLinkPageReference,
	#instVars : [
		'pageUid'
	],
	#category : #'Lepiter-Core-Links'
}

{ #category : #'instance creation' }
LeLinkPageUidReference class >> forPageUid: aPageUid [
	^ self new
		pageUid: aPageUid
]

{ #category : #'instance creation' }
LeLinkPageUidReference class >> forPageUid: aPageUid targetDatabaseUUID: aDatabaseUUID [
	^ self new
		pageUid: aPageUid;
		targetDatabaseUUID: aDatabaseUUID
]

{ #category : #accessing }
LeLinkPageUidReference >> content: aPage [
	self pageUid: aPage uid.
	super content: aPage.
]

{ #category : #accessing }
LeLinkPageUidReference >> description [
	^ 'Page Uid Reference: ', (self page 
			ifNil: [ self pageUid asString ] 
			ifNotNil: [ :aPage | aPage title ])
]

{ #category : #testing }
LeLinkPageUidReference >> isExistingPage [
	^ self explicitLink database hasPageUID: self pageUid.
]

{ #category : #testing }
LeLinkPageUidReference >> isReferencingContent: aLeContent [ 
	self assert: [ aLeContent notNil ].
	
	^ (super isReferencingContent: aLeContent) and: [
			aLeContent isPage and: [
				aLeContent uid = self pageUid ] ]
]

{ #category : #accessing }
LeLinkPageUidReference >> pageUid [
	^ pageUid
]

{ #category : #accessing }
LeLinkPageUidReference >> pageUid: anUid [
	self assert: [ anUid notNil ].
	self assert: [ pageUid isNil ].
	self assert: [ self page isNil ].
	
	pageUid := anUid
]

{ #category : #actions }
LeLinkPageUidReference >> resolveInDatabase: aDatabase [
	self assert: [ self pageUid notNil ].
	self assert: [ self content isNil ].
	self assert: [ self explicitLink notNil ].
	
	aDatabase 
		pageWithID: self pageUid 
		ifPresent: [ :aPage | 
			self basicContent: aPage ] 
		ifAbsent: [ "self inform: 'Could not find page for uuid ', self pageUid asString" ]
]

{ #category : #accessing }
LeLinkPageUidReference >> status [
	^ self isExistingPage
		ifTrue: [ LeLinkReferenceStatus exists ]
		ifFalse: [ LeLinkReferenceStatus notFound ]
]

{ #category : #accessing }
LeLinkPageUidReference >> targetId [
	^ self pageUid
]
