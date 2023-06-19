Class {
	#name : #LeLinkContentReference,
	#superclass : #LeLinkReference,
	#instVars : [
		'content',
		'targetDatabaseUUID'
	],
	#category : #'Lepiter-Core-Links'
}

{ #category : #'instance creation' }
LeLinkContentReference class >> forContent: aLeContent [
	^ self new
		content: aLeContent
]

{ #category : #accessing }
LeLinkContentReference >> basicContent: aLeContent [
	content := aLeContent.
]

{ #category : #updating }
LeLinkContentReference >> clearContent [
	content := nil
]

{ #category : #accessing }
LeLinkContentReference >> content [
	^ content
]

{ #category : #accessing }
LeLinkContentReference >> content: aLeContent [
	self assert: [ content isNil ].
	
	self basicContent: aLeContent
]

{ #category : #'gt-extensions' }
LeLinkContentReference >> gtLiveFor: aView [
	<gtView>
	self content ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self content ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Object'
			tooltip: 'Inspect origin referenced object'
			action: [ :aButton | aButton phlow spawnObject: self content ]
]

{ #category : #testing }
LeLinkContentReference >> isLeContentReference [
	^ true
]

{ #category : #testing }
LeLinkContentReference >> isReferencingContent: aLeContent [
	"I check if this reference is for the given content. I do not rely on 
	comparing the identity of the content as the reference could be unresolved."
	| linkReferenceDatabaseUUID givenContentDatabaseUUID |
	self assert: [ aLeContent notNil ].
	self assert: [ self explicitLink notNil ].
	self assert: [ self explicitLink database notNil ].
	
	linkReferenceDatabaseUUID := self targetDatabaseUUID ifNil: [ 
		self explicitLink database monitor 
			ifNil: [ nil ]
			ifNotNil: [ :aMonitor | aMonitor uuidString ] ].
	
	givenContentDatabaseUUID := aLeContent database monitor 
		ifNil: [ nil ]
		ifNotNil: [ :aMonitor | aMonitor uuidString ].
			
	^ givenContentDatabaseUUID = linkReferenceDatabaseUUID
]

{ #category : #testing }
LeLinkContentReference >> isResolved [
	^ self content notNil
]

{ #category : #comparing }
LeLinkContentReference >> matches: anObject [
	"Equality with another reference means we indicate towards the same content.
	For example two references pointint to the page name 'One' are equal, even
	if one reference is resolved and the other is not, ot they are resolved 
	to two different pages in two different databases."
	
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self targetId = anObject targetId 
		and: [ self targetDatabaseUUID = anObject targetDatabaseUUID ]
]

{ #category : #actions }
LeLinkContentReference >> resolveAndLinkInDatabase: aDatabase [
	self assert: [ aDatabase notNil ].
	
	self resolveInDatabase: aDatabase.
	self content ifNotNil: [ :aLeContent |
		aLeContent linkedBy: self explicitLink ]
]

{ #category : #actions }
LeLinkContentReference >> resolveAndLinkReference [ 
	self isResolved ifTrue: [
		"Only resolve the reference if it needs to be resolved."
		^ self].
	self targetDatabaseDo: [ :aTargetDatabase |
		self resolveAndLinkInDatabase: aTargetDatabase ]
]

{ #category : #actions }
LeLinkContentReference >> resolveInDatabase: aDatabase [
	self subclassResponsibility
]

{ #category : #actions }
LeLinkContentReference >> resolveReference [ 
	self isResolved ifTrue: [
		"Only resolve the reference if it needs to be resolved."
		^ self ].
	self targetDatabaseDo: [ :aTargetDatabase |
		self resolveInDatabase: aTargetDatabase ]
]

{ #category : #accessing }
LeLinkContentReference >> status [
	^ self isResolved
		ifTrue: [ LeLinkReferenceStatus exists ]
		ifFalse: [ LeLinkReferenceStatus notFound ]
]

{ #category : #accessing }
LeLinkContentReference >> targetDatabaseDo: aBlock [ 	
	^ self 
		targetDatabaseFrom: self explicitLink database 
		do: aBlock 
]

{ #category : #accessing }
LeLinkContentReference >> targetDatabaseFrom: aCurrentDatabase do: aBlock [ 

	"In case there is no database specified or the id is the same
	as the one of the databasee containing the link resolve the
	reference in this database."
	(self targetDatabaseUUID isNil or: [ 
		self targetDatabaseUUID = aCurrentDatabase uuid ]) 
			ifTrue: [ ^ aBlock value: aCurrentDatabase ].
		
	"If there is no parent database we have no way to resolve the reference"
	aCurrentDatabase parent ifNil: [ ^ self ].
			
	aCurrentDatabase parent 
		databaseWithID: self targetDatabaseUUID 
		ifFound: [ :aTargetDatabase | aBlock value: aTargetDatabase ] 
		ifNone: [  
			"We cannot resolve the link in case the database is not resolved. "
			^ self ]
]

{ #category : #accessing }
LeLinkContentReference >> targetDatabaseUUID [
	^ targetDatabaseUUID
]

{ #category : #accessing }
LeLinkContentReference >> targetDatabaseUUID: aUUIDString36 [
	"Set the UUID of the database containing the link.
	Links within the origins database should have UUID = nil"

	targetDatabaseUUID := aUUIDString36
]

{ #category : #accessing }
LeLinkContentReference >> targetId [
	self subclassResponsibility
]

{ #category : #actions }
LeLinkContentReference >> unlink [	
	self content ifNil: [ ^ self ].
	self content unlinkedBy: self explicitLink.
]
